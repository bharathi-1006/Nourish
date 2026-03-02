import Foundation

// MARK: - Health Profile

struct HealthProfile: Codable {
    // Common fields
    var age: Int = 0
    var gender: Gender = .other
    var heightCm: Double = 0
    var weightKg: Double = 0

    // Diabetic Mode
    var fastingSugar: Double = 0       // mg/dL
    var postMealSugar: Double = 0      // mg/dL

    // Heart Care Mode
    var bloodPressureSystolic: Int = 0
    var bloodPressureDiastolic: Int = 0
    var cholesterolMgdL: Int = 0

    // Weight Loss / Gain
    var targetWeightKg: Double = 0

    enum Gender: String, Codable, CaseIterable {
        case male = "Male"
        case female = "Female"
        case other = "Other"
    }

    // MARK: - Profile Completion Validation

    /// Returns true only when the profile contains real, non-zero user data.
    /// An empty HealthProfile() (all defaults) is always considered incomplete.
    var isCompleted: Bool {
        age > 0 && heightCm > 0 && weightKg > 0
    }

    /// Mode-aware completion check: verifies common fields AND mode-specific fields.
    func isCompleted(for mode: HealthMode) -> Bool {
        guard isCompleted else { return false }
        switch mode {
        case .normal:
            return true
        case .diabetic:
            // Require at least one blood sugar reading
            return fastingSugar > 0 || postMealSugar > 0
        case .heartCare:
            // Require BP readings
            return bloodPressureSystolic > 0 && bloodPressureDiastolic > 0
        case .weightLoss, .weightGain:
            // Require a target weight
            return targetWeightKg > 0
        }
    }

    // MARK: BMR (Mifflin-St Jeor)
    var bmr: Double {
        guard heightCm > 0, weightKg > 0, age > 0 else { return 2000 }
        switch gender {
        case .male:
            return 10 * weightKg + 6.25 * heightCm - 5 * Double(age) + 5
        case .female, .other:
            return 10 * weightKg + 6.25 * heightCm - 5 * Double(age) - 161
        }
    }

    /// Sedentary TDEE
    var tdee: Double { bmr * 1.2 }

    /// Target daily calories depending on mode
    func targetCalories(for mode: HealthMode) -> Int {
        switch mode {
        case .normal:       return Int(tdee)
        case .diabetic:     return Int(tdee)
        case .heartCare:    return Int(tdee)
        case .weightLoss:   return max(1200, Int(tdee - 500))
        case .weightGain:   return Int(tdee + 500)
        }
    }
}

// MARK: - Health Profile Store

class HealthProfileStore: ObservableObject {

    @Published var profiles: [String: HealthProfile] = [:]
    /// Modes for which the user has already completed the profile
    @Published var completedModes: Set<String> = []

    private let profilesKey = "healthProfiles_v2"
    private let completedKey = "completedHealthModes_v2"

    init() {
        load()
    }

    // MARK: Public

    func profile(for mode: HealthMode) -> HealthProfile? {
        profiles[mode.rawValue]
    }

    func save(profile: HealthProfile, for mode: HealthMode) {
        profiles[mode.rawValue] = profile
        completedModes.insert(mode.rawValue)
        persist()
    }

    func hasCompletedProfile(for mode: HealthMode) -> Bool {
        // Must be in the completed set AND have valid, non-empty profile data.
        // This prevents an empty HealthProfile() (from a dismissed/skipped form)
        // from being treated as a completed profile.
        guard completedModes.contains(mode.rawValue),
              let profile = profiles[mode.rawValue] else { return false }
        return profile.isCompleted(for: mode)
    }

    func clearProfile(for mode: HealthMode) {
        profiles.removeValue(forKey: mode.rawValue)
        completedModes.remove(mode.rawValue)
        persist()
    }

    // MARK: Persistence

    private func persist() {
        if let data = try? JSONEncoder().encode(profiles) {
            UserDefaults.standard.set(data, forKey: profilesKey)
        }
        UserDefaults.standard.set(Array(completedModes), forKey: completedKey)
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: profilesKey),
           let decoded = try? JSONDecoder().decode([String: HealthProfile].self, from: data) {
            profiles = decoded
        }
        let stored = UserDefaults.standard.stringArray(forKey: completedKey) ?? []
        completedModes = Set(stored)
    }
}
