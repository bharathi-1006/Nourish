import Foundation
import Speech
import AVFoundation

final class SpeechRecognizerManager: ObservableObject {

    // MARK: - Published state (main thread only)
    @Published private(set) var recognizedText: String = ""
    @Published private(set) var isRecording: Bool = false
    @Published private(set) var permissionsGranted: Bool = false   // mic shown once this is true
    @Published private(set) var errorMessage: String? = nil

    // MARK: - Private
    private var speechRecognizer: SFSpeechRecognizer?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var audioSessionActive = false
    private var tapInstalled = false
    private var _isStarting = false
    private var _isTearingDown = false  // guard against re-entrant teardown
    private let controlQueue = DispatchQueue(label: "com.nourish.speech.control", qos: .userInitiated)

    init() {} // No hardware access here — deferred until permissions granted

    // MARK: - Request Permissions
    func requestPermissions(completion: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { [weak self] authStatus in
            guard authStatus == .authorized else {
                DispatchQueue.main.async {
                    self?.permissionsGranted = false
                    completion(false)
                }
                return
            }
            AVAudioApplication.requestRecordPermission { [weak self] micGranted in
                DispatchQueue.main.async {
                    guard micGranted, let self else {
                        self?.permissionsGranted = false
                        completion(false)
                        return
                    }
                    // Create recognizer only after both permissions are granted
                    self.speechRecognizer = SFSpeechRecognizer(locale: .current)
                    self.permissionsGranted = true
                    completion(true)
                }
            }
        }
    }

    // MARK: - Start Recording
    func startRecording() {
        controlQueue.async { [weak self] in
            guard let self else { return }
            guard !self._isStarting else { return }

            // FIX: Use audioEngine.isRunning instead of DispatchQueue.main.sync { isRecording }
            // The main.sync caused a potential deadlock when called from certain contexts.
            guard !self.audioEngine.isRunning else { return }

            guard let recognizer = self.speechRecognizer, recognizer.isAvailable else {
                self.publishError("Speech recognition is not available.")
                return
            }

            self._isStarting = true
            self.teardown()

            DispatchQueue.main.async {
                self.recognizedText = ""
                self.errorMessage   = nil
            }

            // Configure audio session
            let session = AVAudioSession.sharedInstance()
            do {
                try session.setCategory(.record, mode: .measurement, options: .duckOthers)
                try session.setActive(true, options: .notifyOthersOnDeactivation)
                self.audioSessionActive = true
            } catch {
                self._isStarting = false
                self.publishError("Audio session failed: \(error.localizedDescription)")
                return
            }

            // FIX: Do NOT set requiresOnDeviceRecognition = true.
            // On-device recognition has aggressive silence timeouts (~1-2 seconds) and
            // auto-terminates sessions quickly, making the mic appear broken immediately
            // after starting. Server-based recognition is more tolerant of pauses.
            let request = SFSpeechAudioBufferRecognitionRequest()
            request.shouldReportPartialResults = true
            self.recognitionRequest = request

            // Install tap — callback only calls append() which is thread-safe
            let inputNode = self.audioEngine.inputNode
            let fmt = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: fmt) { [weak self] buf, _ in
                self?.recognitionRequest?.append(buf)
            }
            self.tapInstalled = true

            self.audioEngine.prepare()
            do {
                try self.audioEngine.start()
            } catch {
                self.teardown()
                self._isStarting = false
                self.publishError("Microphone could not start. Please try again.")
                return
            }

            // Recognition callback — dispatch to main for UI updates.
            // FIX: Filter out cancellation errors (code 301/203) which fire every time
            // we call stopRecording() — these are expected and should NOT re-trigger stop.
            self.recognitionTask = recognizer.recognitionTask(with: request) { [weak self] result, error in
                guard let self else { return }
                if let result {
                    let text = result.bestTranscription.formattedString
                    DispatchQueue.main.async { self.recognizedText = text }
                }
                if let error {
                    let nsErr = error as NSError
                    // 301 = kAFAssistantErrorDomain "Cancelled", 203 = "Retry" — both are normal on stop
                    let isCancellation = nsErr.code == 301 || nsErr.code == 203
                    if !isCancellation {
                        DispatchQueue.main.async { self.stopRecording() }
                    }
                } else if result?.isFinal == true {
                    DispatchQueue.main.async { self.stopRecording() }
                }
            }

            self._isStarting = false
            DispatchQueue.main.async { self.isRecording = true }
        }
    }

    // MARK: - Stop Recording
    func stopRecording() {
        controlQueue.async { [weak self] in
            guard let self else { return }
            self._isStarting = false
            DispatchQueue.main.async { self.isRecording = false }
            self.teardown()
        }
    }

    // MARK: - Teardown (controlQueue only)
    private func teardown() {
        // FIX: Guard against re-entrant teardown (recognition callback → stopRecording → teardown
        // while a prior teardown is still in progress causes double-stop crashes)
        guard !_isTearingDown else { return }
        _isTearingDown = true
        defer { _isTearingDown = false }

        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        recognitionTask    = nil
        recognitionRequest = nil

        // FIX: Stop engine before removing tap to avoid crash from in-flight audio callbacks
        if audioEngine.isRunning { audioEngine.stop() }
        if tapInstalled {
            audioEngine.inputNode.removeTap(onBus: 0)
            tapInstalled = false
        }
        if audioSessionActive {
            try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
            audioSessionActive = false
        }
    }

    private func publishError(_ msg: String) {
        DispatchQueue.main.async { self.errorMessage = msg }
    }

    deinit {
        recognitionTask?.cancel()
        if audioEngine.isRunning { audioEngine.stop() }
    }
}
