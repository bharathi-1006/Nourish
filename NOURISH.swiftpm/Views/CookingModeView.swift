import SwiftUI

struct CookingModeView: View {
    @Environment(\.dismiss) var dismiss
    let recipe: Recipe
    
    @State private var currentStepIndex = 0
    @State private var completedSteps: Set<String> = []
    @State private var showTimer = false
    @State private var timerDuration: Int = 0
    @State private var timeRemaining: Int = 0
    @State private var isTimerRunning = false
    
    var currentStep: CookingStep {
        recipe.steps[currentStepIndex]
    }
    
    // Enhanced instruction for cooking mode (3-5 lines with detailed guidance)
    var detailedInstruction: String {
        let step = currentStep
        let baseInstruction = step.instruction.lowercased()
        
        // Elaborate based on common cooking actions
        if baseInstruction.contains("preheat") || baseInstruction.contains("heat") {
            return "Turn on your \(baseInstruction.contains("oven") ? "oven" : "stove") and set it to the specified temperature. Allow sufficient time for it to reach the right heat level before proceeding. This ensures even cooking and optimal results. Keep the door closed while preheating to maintain consistent temperature."
        } else if baseInstruction.contains("chop") || baseInstruction.contains("dice") || baseInstruction.contains("cut") || baseInstruction.contains("slice") {
            return "Prepare your ingredients by carefully cutting them to the specified size. Use a sharp knife and a stable cutting board for safety. Uniform pieces ensure even cooking. Take your time and maintain consistent sizes throughout for the best texture and appearance."
        } else if baseInstruction.contains("mix") || baseInstruction.contains("combine") || baseInstruction.contains("stir") || baseInstruction.contains("whisk") {
            return "Thoroughly combine all the listed ingredients in a clean bowl. Stir gently but consistently to ensure everything is evenly distributed. Continue mixing until no streaks remain and the mixture has a uniform appearance. Scrape down the sides of the bowl as needed."
        } else if baseInstruction.contains("boil") || baseInstruction.contains("simmer") {
            return "Bring the ingredients to the appropriate temperature on the stove. Watch carefully as the liquid begins to bubble. Adjust the heat to maintain a steady, gentle boil without overflowing. Stir occasionally to prevent sticking and ensure even heat distribution throughout."
        } else if baseInstruction.contains("bake") || baseInstruction.contains("cook in oven") {
            return "Place your prepared dish in the preheated oven at the center rack for even heat circulation. Set a timer for the specified duration. Avoid opening the oven door frequently, as this releases heat and affects cooking time. Check for doneness near the end of the cooking time."
        } else if baseInstruction.contains("fry") || baseInstruction.contains("sauté") || baseInstruction.contains("pan-fry") {
            return "Heat oil or butter in your pan over medium-high heat until shimmering but not smoking. Add ingredients carefully to avoid splashing. Cook without overcrowding the pan to ensure proper browning. Flip or stir as needed for even cooking, and adjust heat if food browns too quickly."
        } else if baseInstruction.contains("season") || baseInstruction.contains("add salt") || baseInstruction.contains("spice") {
            return "Add your seasonings and spices gradually, tasting as you go to achieve the perfect balance. Start with less than you think you need—you can always add more. Sprinkle evenly across the dish for consistent flavor. Allow seasonings time to develop and blend with other ingredients."
        } else if baseInstruction.contains("serve") || baseInstruction.contains("plate") || baseInstruction.contains("garnish") {
            return "Carefully transfer your finished dish to serving plates or bowls. Arrange the components attractively for visual appeal. Add any final garnishes or toppings as specified. Serve immediately while hot for the best flavor and texture. Enjoy your delicious homemade meal!"
        } else {
            // Fallback: Add helpful context to the original instruction
            return "\(step.instruction). Take your time with this step to ensure proper technique. Follow the measurements and timing carefully for optimal results. Maintain clean workspace and proper food safety practices throughout the process."
        }
    }
    
    var progress: Double {
        Double(currentStepIndex + 1) / Double(recipe.steps.count)
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Cooking Mode")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Text("Step \(currentStepIndex + 1) of \(recipe.steps.count)")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .padding(20)
                .background(Color.black.opacity(0.3))
                
                // Progress Bar
                ProgressView(value: progress)
                    .tint(.white)
                    .padding(20)
                
                Spacer()
                
                // Main Content
                VStack(spacing: 24) {
                    // Step Number
                    Text("\(currentStep.stepNumber)")
                        .font(.system(size: 72, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    // Step Instruction - Enhanced with detailed guidance
                    Text(detailedInstruction)
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                        .padding(.horizontal, 24)
                    
                    // Timer Button
                    if let duration = currentStep.duration, duration > 0 {
                        Button(action: {
                            showTimer = true
                            timerDuration = duration
                            timeRemaining = duration
                        }) {
                            HStack {
                                Image(systemName: "timer")
                                Text("Set Timer (\(formatDuration(duration)))")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(12)
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                
                Spacer()
                
                // Navigation Buttons
                HStack(spacing: 16) {
                    Button(action: {
                        if currentStepIndex > 0 {
                            currentStepIndex -= 1
                        }
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Previous")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(12)
                    }
                    .disabled(currentStepIndex == 0)
                    .opacity(currentStepIndex == 0 ? 0.5 : 1.0)
                    
                    Button(action: {
                        completedSteps.insert(currentStep.id)
                        if currentStepIndex < recipe.steps.count - 1 {
                            currentStepIndex += 1
                        } else {
                            dismiss()
                        }
                    }) {
                        HStack {
                            Text(currentStepIndex == recipe.steps.count - 1 ? "Done" : "Next")
                                .font(.system(size: 16, weight: .semibold))
                            Image(systemName: currentStepIndex == recipe.steps.count - 1 ? "checkmark" : "chevron.right")
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(12)
                    }
                }
                .padding(20)
            }
            
            // Timer Overlay
            if showTimer {
                TimerView(
                    isPresented: $showTimer,
                    duration: $timerDuration,
                    timeRemaining: $timeRemaining,
                    isRunning: $isTimerRunning
                )
            }
        }
    }
    
    private func formatDuration(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        if minutes > 0 {
            return String(format: "%02d:%02d", minutes, secs)
        } else {
            return String(format: "%02ds", secs)
        }
    }
}

struct TimerView: View {
    @Binding var isPresented: Bool
    @Binding var duration: Int
    @Binding var timeRemaining: Int
    @Binding var isRunning: Bool
    
    @State private var timer: Timer?
    
    var formattedTime: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var progress: CGFloat {
        guard duration > 0 else { return 0 }
        return CGFloat(timeRemaining) / CGFloat(duration)
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.85)
                .ignoresSafeArea()
                .onTapGesture {} // block taps behind

            VStack(spacing: 28) {

                // Title
                Text("Timer")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                // Ring + time
                ZStack {
                    // Track
                    Circle()
                        .stroke(Color.white.opacity(0.15), lineWidth: 12)

                    // Progress arc
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(
                            LinearGradient(colors: [Color.orange, Color.yellow],
                                           startPoint: .topLeading, endPoint: .bottomTrailing),
                            style: StrokeStyle(lineWidth: 12, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                        .animation(.linear(duration: 1), value: progress)

                    VStack(spacing: 4) {
                        Text(formattedTime)
                            .font(.system(size: 54, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)
                        Text(isRunning ? "remaining" : (timeRemaining == duration ? "ready" : "paused"))
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.5))
                            .textCase(.uppercase)
                            .tracking(1.5)
                    }
                }
                .frame(width: 220, height: 220)

                // Start/Pause + Reset
                HStack(spacing: 14) {
                    // Reset
                    Button(action: {
                        timer?.invalidate()
                        timer = nil
                        timeRemaining = duration
                        isRunning = false
                    }) {
                        Image(systemName: "gobackward")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            .background(Color.white.opacity(0.12))
                            .clipShape(Circle())
                            .overlay(Circle().strokeBorder(Color.white.opacity(0.2), lineWidth: 1))
                    }

                    // Start / Pause
                    Button(action: {
                        isRunning.toggle()
                        if isRunning { startTimer() } else {
                            timer?.invalidate(); timer = nil
                        }
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: isRunning ? "pause.fill" : "play.fill")
                                .font(.system(size: 18, weight: .bold))
                            Text(isRunning ? "Pause" : "Start")
                                .font(.system(size: 17, weight: .bold))
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.orange)
                        .cornerRadius(28)
                    }
                }

                // Close
                Button(action: {
                    timer?.invalidate(); timer = nil
                    isPresented = false; isRunning = false
                }) {
                    Text("Close Timer")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white.opacity(0.7))
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.white.opacity(0.08))
                        .cornerRadius(14)
                        .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Color.white.opacity(0.15), lineWidth: 1))
                }
            }
            .padding(28)
            .background(
                RoundedRectangle(cornerRadius: 28)
                    .fill(Color(white: 0.1))
                    .overlay(RoundedRectangle(cornerRadius: 28).strokeBorder(Color.white.opacity(0.1), lineWidth: 1))
                    .shadow(color: .black.opacity(0.6), radius: 40, x: 0, y: 20)
            )
            .padding(.horizontal, 24)
        }
    }
    
    private func startTimer() {
        timer?.invalidate()
        let t = Timer(timeInterval: 1.0, repeats: true) { [self] _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                timer = nil
                isRunning = false
                playNotification()
            }
        }
        RunLoop.main.add(t, forMode: .common)
        timer = t
    }
    
    private func playNotification() {
        // Simple haptic feedback
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(.success)
    }
}

#Preview {
    CookingModeView(recipe: Recipe(
        id: "1",
        title: "Test",
        description: "Test",
        heroImage: "pizza",
        cuisine: "Italian",
        diet: "Vegetarian",
        category: "Dinner",
        preparationTime: 30,
        cookingTime: 20,
        difficulty: "Easy",
        servings: 4,
        ingredients: [],
        steps: [
            CookingStep(id: "1", stepNumber: 1, instruction: "Preheat oven", image: nil, duration: 600),
            CookingStep(id: "2", stepNumber: 2, instruction: "Mix ingredients", image: nil, duration: 300)
        ],
        nutrition: Nutrition(calories: 300, protein: "10g", carbs: "40g", fat: "10g", fiber: "5g"),
        rating: 4.5,
        reviews: 100,
        mode: .normal
    ))
}
