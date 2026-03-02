import SwiftUI

// MARK: - Health Level Enum

enum HealthLevel {
    case low, normal, elevated, high, veryHigh, underweight, overweight, invalidValue

    var label: String {
        switch self {
        case .low:         return "Low"
        case .normal:      return "Normal"
        case .elevated:    return "Elevated"
        case .high:        return "High"
        case .veryHigh:    return "Very High"
        case .underweight: return "Underweight"
        case .overweight:  return "Overweight"
        case .invalidValue:       return "Invalid Value"
        }
    }

    var color: Color {
        switch self {
        case .normal:      return Color(red: 0.20, green: 0.78, blue: 0.35)
        case .low:         return Color(red: 0.28, green: 0.65, blue: 0.95)
        case .elevated:    return Color(red: 0.95, green: 0.72, blue: 0.10)
        case .high:        return Color(red: 0.95, green: 0.45, blue: 0.10)
        case .veryHigh:    return Color(red: 0.88, green: 0.15, blue: 0.15)
        case .underweight: return Color(red: 0.28, green: 0.65, blue: 0.95)
        case .overweight:  return Color(red: 0.95, green: 0.45, blue: 0.10)
        case .invalidValue:       return Color(red: 0.80, green: 0.10, blue: 0.10)
        }
    }

    var icon: String {
        switch self {
        case .normal:      return "checkmark.circle.fill"
        case .low:         return "arrow.down.circle.fill"
        case .elevated:    return "exclamationmark.circle.fill"
        case .high:        return "exclamationmark.triangle.fill"
        case .veryHigh:    return "exclamationmark.octagon.fill"
        case .underweight: return "arrow.down.circle.fill"
        case .overweight:  return "arrow.up.circle.fill"
        case .invalidValue:       return "xmark.circle.fill"
        }
    }
}

// MARK: - Health Assessment Engine

struct HealthAssessment {

    // MARK: Blood Sugar
    static func fastingSugarLevel(_ value: Double) -> HealthLevel {
        if value <= 0 || value > 600 { return .invalidValue }
        if value < 70               { return .low }
        if value <= 99              { return .normal }
        if value <= 125             { return .elevated }
        if value <= 199             { return .high }
        return .veryHigh
    }

    static func postMealSugarLevel(_ value: Double) -> HealthLevel {
        if value <= 0 || value > 700 { return .invalidValue }
        if value < 70               { return .low }
        if value <= 139             { return .normal }
        if value <= 199             { return .elevated }
        return .high
    }

    static func fastingSugarAdvice(_ level: HealthLevel) -> String {
        switch level {
        case .low:      return "Your fasting sugar is below 70 mg/dL (hypoglycaemia range). Consult a doctor and prioritise complex carbs."
        case .normal:   return "Fasting sugar is within the healthy range (70–99 mg/dL). Keep maintaining a balanced diet."
        case .elevated: return "Fasting sugar (100–125 mg/dL) indicates pre-diabetes. Reducing refined carbs and sugar is strongly recommended."
        case .high:     return "Fasting sugar (126–199 mg/dL) is in the diabetic range. Please follow your doctor's diet plan carefully."
        case .veryHigh: return "Fasting sugar above 200 mg/dL is critically high. Seek medical attention and strictly follow a low-GI diet."
        case .invalidValue:    return "Please enter a valid fasting sugar value (70–600 mg/dL)."
        default:        return ""
        }
    }

    static func postMealSugarAdvice(_ level: HealthLevel) -> String {
        switch level {
        case .low:      return "Post-meal sugar below 70 mg/dL suggests hypoglycaemia. Eat balanced meals with protein and fibre."
        case .normal:   return "Post-meal sugar is normal (under 140 mg/dL). Excellent control — maintain your current eating habits."
        case .elevated: return "Post-meal sugar (140–199 mg/dL) is elevated. Limit simple carbs and opt for fibre-rich, low-GI foods."
        case .high:     return "Post-meal sugar above 200 mg/dL indicates poor glycaemic control. Follow a strict diabetic meal plan."
        case .invalidValue:    return "Please enter a valid post-meal sugar value (70–700 mg/dL)."
        default:        return ""
        }
    }

    // MARK: Blood Pressure
    static func bpLevel(systolic: Int, diastolic: Int) -> HealthLevel {
        if systolic <= 0 || systolic > 300 || diastolic <= 0 || diastolic > 200 { return .invalidValue }
        if diastolic >= systolic { return .invalidValue }
        if systolic < 90 || diastolic < 60               { return .low }
        if systolic <= 120 && diastolic <= 80            { return .normal }
        if systolic <= 129 && diastolic <= 80            { return .elevated }
        if systolic <= 139 || diastolic <= 89            { return .high }
        return .veryHigh
    }

    static func bpAdvice(_ level: HealthLevel) -> String {
        switch level {
        case .low:      return "Blood pressure is low (below 90/60). Stay hydrated, avoid skipping meals, and include adequate sodium."
        case .normal:   return "Blood pressure is in the healthy range (below 120/80). Keep up your heart-friendly lifestyle."
        case .elevated: return "Blood pressure is elevated (120–129/<80). Reduce sodium intake and increase physical activity."
        case .high:     return "Blood pressure is high (130–139/80–89 or above). Strictly limit sodium, saturated fat, and processed foods."
        case .veryHigh: return "Blood pressure is very high (140+/90+). This requires immediate medical attention and a strict low-sodium diet."
        case .invalidValue:    return "Please enter valid blood pressure values. Systolic must be greater than diastolic, and values must be realistic."
        default:        return ""
        }
    }

    // MARK: Cholesterol
    static func cholesterolLevel(_ value: Int) -> HealthLevel {
        if value <= 0 || value > 700 { return .invalidValue }
        if value < 100              { return .low }
        if value <= 199             { return .normal }
        if value <= 239             { return .elevated }
        return .high
    }

    static func cholesterolAdvice(_ level: HealthLevel) -> String {
        switch level {
        case .low:      return "Cholesterol below 100 mg/dL is very low. Ensure adequate intake of healthy fats like avocado, nuts, and olive oil."
        case .normal:   return "Cholesterol is in the healthy range (below 200 mg/dL). Continue eating heart-healthy fats and fibre."
        case .elevated: return "Cholesterol is borderline high (200–239 mg/dL). Reduce saturated fat, fried foods, and increase omega-3 intake."
        case .high:     return "Cholesterol is high (240+ mg/dL). Avoid trans fats, processed foods. Include oats, legumes, and fatty fish."
        case .invalidValue:    return "Please enter a valid cholesterol value (100–700 mg/dL)."
        default:        return ""
        }
    }

    // MARK: BMI & Weight
    static func bmi(weightKg: Double, heightCm: Double) -> Double {
        guard heightCm > 0, weightKg > 0 else { return 0 }
        let h = heightCm / 100
        return weightKg / (h * h)
    }

    static func bmiLevel(_ bmi: Double) -> HealthLevel {
        if bmi <= 0 || bmi > 80 { return .invalidValue }
        if bmi < 18.5           { return .underweight }
        if bmi <= 24.9          { return .normal }
        if bmi <= 29.9          { return .elevated }
        return .overweight
    }

    static func bmiLabel(_ bmi: Double, level: HealthLevel) -> String {
        switch level {
        case .underweight: return "Underweight (BMI \(String(format: "%.1f", bmi)))"
        case .normal:      return "Healthy (BMI \(String(format: "%.1f", bmi)))"
        case .elevated:    return "Overweight (BMI \(String(format: "%.1f", bmi)))"
        case .overweight:  return "Obese (BMI \(String(format: "%.1f", bmi)))"
        default:           return "BMI \(String(format: "%.1f", bmi))"
        }
    }

    // MARK: Target Weight Validation
    static func validateTargetWeight(current: Double, target: Double, mode: HealthMode) -> (level: HealthLevel, message: String) {
        guard target > 0, current > 0 else {
            return (.invalidValue, "Please enter a valid target weight.")
        }
        if target < 30 || target > 300 {
            return (.invalidValue, "Target weight seems unrealistic. Please enter a value between 30–300 kg.")
        }
        let diff = target - current
        switch mode {
        case .weightLoss:
            if target >= current {
                return (.invalidValue, "Target weight must be less than your current weight (\(Int(current)) kg) for weight loss.")
            }
            if diff < -50 {
                return (.elevated, "A loss of \(Int(abs(diff))) kg is aggressive. Aim for gradual reduction with a calorie deficit of 500 kcal/day.")
            }
            return (.normal, "Goal: lose \(String(format: "%.1f", abs(diff))) kg. A deficit of ~500 kcal/day gets you there in \(Int(abs(diff) * 7)) weeks.")
        case .weightGain:
            if target <= current {
                return (.invalidValue, "Target weight must be greater than your current weight (\(Int(current)) kg) for weight gain.")
            }
            if diff > 40 {
                return (.elevated, "A gain of \(Int(diff)) kg is significant. Aim for a healthy surplus of 300–500 kcal/day with strength training.")
            }
            return (.normal, "Goal: gain \(String(format: "%.1f", diff)) kg. A surplus of ~500 kcal/day gets you there in \(Int(diff * 7)) weeks.")
        default:
            return (.normal, "")
        }
    }

    // MARK: Basic Field Validation
    static func validateAge(_ value: String) -> String? {
        guard let v = Int(value), v > 0 else { return "Age must be a positive number." }
        if v < 5  { return "Age seems too low. Please check." }
        if v > 120 { return "Age seems too high. Please check." }
        return nil
    }

    static func validateHeight(_ value: String) -> String? {
        guard let v = Double(value), v > 0 else { return "Height must be a positive number." }
        if v < 50  { return "Height seems too low (min 50 cm). Please check." }
        if v > 250 { return "Height seems too high (max 250 cm). Please check." }
        return nil
    }

    static func validateWeight(_ value: String) -> String? {
        guard let v = Double(value), v > 0 else { return "Weight must be a positive number." }
        if v < 10  { return "Weight seems too low (min 10 kg). Please check." }
        if v > 500 { return "Weight seems too high (max 500 kg). Please check." }
        return nil
    }
}

// MARK: - Health Profile Setup View

struct HealthProfileView: View {
    let mode: HealthMode
    @EnvironmentObject var profileStore: HealthProfileStore
    @EnvironmentObject var modeManager: HealthModeManager
    @Environment(\.dismiss) private var dismiss

    @State private var age: String = ""
    @State private var gender: HealthProfile.Gender = .other
    @State private var heightCm: String = ""
    @State private var weightKg: String = ""
    @State private var fastingSugar: String = ""
    @State private var postMealSugar: String = ""
    @State private var bpSystolic: String = ""
    @State private var bpDiastolic: String = ""
    @State private var cholesterol: String = ""
    @State private var targetWeight: String = ""
    @State private var showValidationError = false
    @State private var showAssessment = false

    private var theme: HealthModeTheme { HealthModeTheme.theme(for: mode) }

    // MARK: - Live Assessment Computations

    private var ageError: String?       { age.isEmpty       ? nil : HealthAssessment.validateAge(age) }
    private var heightError: String?    { heightCm.isEmpty  ? nil : HealthAssessment.validateHeight(heightCm) }
    private var weightError: String?    { weightKg.isEmpty  ? nil : HealthAssessment.validateWeight(weightKg) }

    private var bmiValue: Double {
        guard let h = Double(heightCm), let w = Double(weightKg) else { return 0 }
        return HealthAssessment.bmi(weightKg: w, heightCm: h)
    }
    private var bmiLevel: HealthLevel { HealthAssessment.bmiLevel(bmiValue) }

    private var fastingSugarLvl: HealthLevel {
        guard let v = Double(fastingSugar), !fastingSugar.isEmpty else { return .normal }
        return HealthAssessment.fastingSugarLevel(v)
    }
    private var postMealSugarLvl: HealthLevel {
        guard let v = Double(postMealSugar), !postMealSugar.isEmpty else { return .normal }
        return HealthAssessment.postMealSugarLevel(v)
    }
    private var bpLvl: HealthLevel {
        guard let s = Int(bpSystolic), let d = Int(bpDiastolic),
              !bpSystolic.isEmpty, !bpDiastolic.isEmpty else { return .normal }
        return HealthAssessment.bpLevel(systolic: s, diastolic: d)
    }
    private var cholesterolLvl: HealthLevel {
        guard let v = Int(cholesterol), !cholesterol.isEmpty else { return .normal }
        return HealthAssessment.cholesterolLevel(v)
    }
    private var targetWeightAssessment: (level: HealthLevel, message: String) {
        let current = Double(weightKg) ?? 0
        let target  = Double(targetWeight) ?? 0
        guard !targetWeight.isEmpty, !weightKg.isEmpty else { return (.normal, "") }
        return HealthAssessment.validateTargetWeight(current: current, target: target, mode: mode)
    }

    /// True when enough mode-specific data is entered to show the assessment panel
    private var canShowAssessment: Bool {
        let hasBase = !age.isEmpty && !heightCm.isEmpty && !weightKg.isEmpty
        switch mode {
        case .normal:     return hasBase
        case .diabetic:   return hasBase && (!fastingSugar.isEmpty || !postMealSugar.isEmpty)
        case .heartCare:  return hasBase && (!bpSystolic.isEmpty || !cholesterol.isEmpty)
        case .weightLoss, .weightGain: return hasBase && !targetWeight.isEmpty
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        // ── Cinematic header ────────────────────────────────
                        ZStack(alignment: .bottom) {
                            LinearGradient(
                                colors: [theme.primaryColor, theme.accentColor.opacity(0.8)],
                                startPoint: .topLeading, endPoint: .bottomTrailing
                            )
                            .overlay(LinearGradient(colors:[.white.opacity(0.10),.clear], startPoint:.top, endPoint:.bottom))
                            .frame(height: 200)

                            VStack(spacing: 12) {
                                ZStack {
                                    Circle().fill(.white.opacity(0.20)).frame(width: 80, height: 80)
                                    Circle().fill(.white.opacity(0.10)).frame(width: 80, height: 80).blur(radius: 10)
                                    Image(systemName: mode.icon)
                                        .font(.system(size: 34, weight: .semibold))
                                        .foregroundColor(.white)
                                        .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
                                }
                                VStack(spacing: 5) {
                                    Text("Your Health Profile")
                                        .font(.system(size: 24, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                    Text("Personalise your \(mode.displayName) plan")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.white.opacity(0.82))
                                }
                            }
                            .padding(.bottom, 24)
                        }

                        VStack(spacing: 20) {
                            commonSection
                            modeSpecificSection

                            // ── Health Assessment Panel ──────────────────────
                            if canShowAssessment {
                                healthAssessmentPanel
                                    .transition(.opacity.combined(with: .move(edge: .top)))
                            }

                            saveButton
                        }
                        .padding(.horizontal, 20).padding(.top, 24).padding(.bottom, 48)
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: canShowAssessment)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }.foregroundColor(.secondary)
                }
            }
            .alert("Please fill all required fields correctly", isPresented: $showValidationError) {
                Button("OK", role: .cancel) {}
            }
            .onAppear {
                if let saved = profileStore.profile(for: mode), saved.isCompleted(for: mode) {
                    age         = saved.age > 0        ? String(saved.age)        : ""
                    heightCm    = saved.heightCm > 0   ? String(saved.heightCm)   : ""
                    weightKg    = saved.weightKg > 0   ? String(saved.weightKg)   : ""
                    gender      = saved.gender
                    switch mode {
                    case .diabetic:
                        fastingSugar  = saved.fastingSugar  > 0 ? String(saved.fastingSugar)  : ""
                        postMealSugar = saved.postMealSugar > 0 ? String(saved.postMealSugar) : ""
                    case .heartCare:
                        bpSystolic  = saved.bloodPressureSystolic  > 0 ? String(saved.bloodPressureSystolic)  : ""
                        bpDiastolic = saved.bloodPressureDiastolic > 0 ? String(saved.bloodPressureDiastolic) : ""
                        cholesterol = saved.cholesterolMgdL        > 0 ? String(saved.cholesterolMgdL)        : ""
                    case .weightLoss, .weightGain:
                        targetWeight = saved.targetWeightKg > 0 ? String(saved.targetWeightKg) : ""
                    case .normal:
                        break
                    }
                }
            }
        }
    }

    // MARK: - Sections

    private var commonSection: some View {
        ProfileSection(title: "Personal Details", icon: "person.fill", color: theme.primaryColor) {
            VStack(spacing: 14) {
                ProfileFieldRow(label: "Age", placeholder: "Years", text: $age, keyboard: .numberPad, errorMessage: ageError)
                ProfileFieldRow(label: "Height", placeholder: "cm", text: $heightCm, keyboard: .decimalPad, errorMessage: heightError)
                ProfileFieldRow(label: "Weight", placeholder: "kg", text: $weightKg, keyboard: .decimalPad, errorMessage: weightError)

                // Inline BMI badge when both height+weight are valid
                if bmiValue > 0 && bmiLevel != .invalidValue {
                    HStack(spacing: 8) {
                        Image(systemName: bmiLevel.icon)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(bmiLevel.color)
                        Text("BMI: \(HealthAssessment.bmiLabel(bmiValue, level: bmiLevel))")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(bmiLevel.color)
                        Spacer()
                    }
                    .padding(.horizontal, 12).padding(.vertical, 8)
                    .background(bmiLevel.color.opacity(0.10), in: RoundedRectangle(cornerRadius: 10))
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
                    .animation(.spring(response: 0.35, dampingFraction: 0.75), value: bmiValue)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Gender").font(.system(size: 14, weight: .medium)).foregroundColor(.secondary)
                    HStack(spacing: 10) {
                        ForEach(HealthProfile.Gender.allCases, id: \.self) { g in
                            Button { gender = g } label: {
                                Text(g.rawValue)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(gender == g ? .white : theme.primaryColor)
                                    .padding(.horizontal, 16).padding(.vertical, 9)
                                    .background(gender == g ? theme.primaryColor : theme.primaryColor.opacity(0.10), in: Capsule())
                            }.buttonStyle(.plain)
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var modeSpecificSection: some View {
        switch mode {
        case .diabetic:
            ProfileSection(title: "Blood Sugar Levels", icon: "drop.fill", color: theme.primaryColor) {
                VStack(spacing: 14) {
                    ProfileFieldRow(
                        label: "Fasting Sugar", placeholder: "mg/dL", text: $fastingSugar, keyboard: .decimalPad,
                        levelBadge: fastingSugar.isEmpty ? nil : fastingSugarLvl,
                        errorMessage: fastingSugarLvl == .invalidValue && !fastingSugar.isEmpty ? HealthAssessment.fastingSugarAdvice(.invalidValue) : nil
                    )
                    ProfileFieldRow(
                        label: "Post-Meal Sugar", placeholder: "mg/dL", text: $postMealSugar, keyboard: .decimalPad,
                        levelBadge: postMealSugar.isEmpty ? nil : postMealSugarLvl,
                        errorMessage: postMealSugarLvl == .invalidValue && !postMealSugar.isEmpty ? HealthAssessment.postMealSugarAdvice(.invalidValue) : nil
                    )
                }
            }
        case .heartCare:
            ProfileSection(title: "Heart Health Metrics", icon: "heart.fill", color: theme.primaryColor) {
                VStack(spacing: 14) {
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 10) {
                            ProfileFieldRow(label: "Systolic BP", placeholder: "mmHg", text: $bpSystolic, keyboard: .numberPad)
                            ProfileFieldRow(label: "Diastolic BP", placeholder: "mmHg", text: $bpDiastolic, keyboard: .numberPad)
                        }
                        // BP level badge shown when both fields filled
                        if !bpSystolic.isEmpty && !bpDiastolic.isEmpty {
                            LevelBadgeView(level: bpLvl)
                                .transition(.opacity.combined(with: .scale(scale: 0.95)))
                        }
                    }
                    ProfileFieldRow(
                        label: "Cholesterol", placeholder: "mg/dL", text: $cholesterol, keyboard: .numberPad,
                        levelBadge: cholesterol.isEmpty ? nil : cholesterolLvl,
                        errorMessage: cholesterolLvl == .invalidValue && !cholesterol.isEmpty ? HealthAssessment.cholesterolAdvice(.invalidValue) : nil
                    )
                }
            }
        case .weightLoss:
            ProfileSection(title: "Weight Loss Goal", icon: "figure.walk", color: theme.primaryColor) {
                VStack(spacing: 10) {
                    ProfileFieldRow(label: "Target Weight", placeholder: "kg", text: $targetWeight, keyboard: .decimalPad,
                                   errorMessage: targetWeightAssessment.level == .invalidValue && !targetWeight.isEmpty ? targetWeightAssessment.message : nil)
                    if !targetWeight.isEmpty && targetWeightAssessment.level != .invalidValue && !targetWeightAssessment.message.isEmpty {
                        GoalMessageView(level: targetWeightAssessment.level, message: targetWeightAssessment.message, color: theme.primaryColor)
                            .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
            }
        case .weightGain:
            ProfileSection(title: "Weight Gain Goal", icon: "figure.strengthtraining.traditional", color: theme.primaryColor) {
                VStack(spacing: 10) {
                    ProfileFieldRow(label: "Target Weight", placeholder: "kg", text: $targetWeight, keyboard: .decimalPad,
                                   errorMessage: targetWeightAssessment.level == .invalidValue && !targetWeight.isEmpty ? targetWeightAssessment.message : nil)
                    if !targetWeight.isEmpty && targetWeightAssessment.level != .invalidValue && !targetWeightAssessment.message.isEmpty {
                        GoalMessageView(level: targetWeightAssessment.level, message: targetWeightAssessment.message, color: theme.primaryColor)
                            .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
            }
        case .normal:
            EmptyView()
        }
    }

    // MARK: - Health Assessment Panel

    @ViewBuilder
    private var healthAssessmentPanel: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8).fill(theme.primaryColor.opacity(0.12)).frame(width: 32, height: 32)
                    Image(systemName: "waveform.path.ecg").font(.system(size: 14, weight: .semibold)).foregroundColor(theme.primaryColor)
                }
                Text("Health Assessment").font(.system(size: 16, weight: .semibold)).foregroundColor(.primary)
                Spacer()
                Text("Live").font(.system(size: 11, weight: .bold))
                    .foregroundColor(theme.primaryColor)
                    .padding(.horizontal, 7).padding(.vertical, 3)
                    .background(theme.primaryColor.opacity(0.12), in: Capsule())
            }

            // Assessment rows based on mode
            switch mode {
            case .diabetic:
                assessmentDiabetic
            case .heartCare:
                assessmentHeartCare
            case .weightLoss, .weightGain:
                assessmentWeight
            case .normal:
                assessmentNormal
            }
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemBackground)).shadow(color: Color.black.opacity(0.05), radius: 12, x: 0, y: 3))
        .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(theme.primaryColor.opacity(0.15), lineWidth: 1))
    }

    @ViewBuilder
    private var assessmentDiabetic: some View {
        VStack(spacing: 12) {
            if !fastingSugar.isEmpty {
                AssessmentRow(
                    label: "Fasting Sugar",
                    value: "\(fastingSugar) mg/dL",
                    level: fastingSugarLvl,
                    advice: fastingSugarLvl == .invalidValue ? nil : HealthAssessment.fastingSugarAdvice(fastingSugarLvl)
                )
            }
            if !postMealSugar.isEmpty {
                AssessmentRow(
                    label: "Post-Meal Sugar",
                    value: "\(postMealSugar) mg/dL",
                    level: postMealSugarLvl,
                    advice: postMealSugarLvl == .invalidValue ? nil : HealthAssessment.postMealSugarAdvice(postMealSugarLvl)
                )
            }
            if bmiValue > 0 && bmiLevel != .invalidValue {
                AssessmentRow(
                    label: "BMI",
                    value: String(format: "%.1f", bmiValue),
                    level: bmiLevel,
                    advice: bmiAdviceForMode
                )
            }
            overallDiabeticSummary
        }
    }

    @ViewBuilder
    private var assessmentHeartCare: some View {
        VStack(spacing: 12) {
            if !bpSystolic.isEmpty && !bpDiastolic.isEmpty {
                AssessmentRow(
                    label: "Blood Pressure",
                    value: "\(bpSystolic)/\(bpDiastolic) mmHg",
                    level: bpLvl,
                    advice: bpLvl == .invalidValue ? HealthAssessment.bpAdvice(.invalidValue) : HealthAssessment.bpAdvice(bpLvl)
                )
            }
            if !cholesterol.isEmpty {
                AssessmentRow(
                    label: "Cholesterol",
                    value: "\(cholesterol) mg/dL",
                    level: cholesterolLvl,
                    advice: cholesterolLvl == .invalidValue ? nil : HealthAssessment.cholesterolAdvice(cholesterolLvl)
                )
            }
            if bmiValue > 0 && bmiLevel != .invalidValue {
                AssessmentRow(
                    label: "BMI",
                    value: String(format: "%.1f", bmiValue),
                    level: bmiLevel,
                    advice: bmiAdviceForMode
                )
            }
            overallHeartSummary
        }
    }

    @ViewBuilder
    private var assessmentWeight: some View {
        VStack(spacing: 12) {
            if bmiValue > 0 && bmiLevel != .invalidValue {
                AssessmentRow(
                    label: "Current BMI",
                    value: String(format: "%.1f", bmiValue),
                    level: bmiLevel,
                    advice: bmiAdviceForMode
                )
            }
            if !targetWeight.isEmpty && targetWeightAssessment.level != .invalidValue {
                AssessmentRow(
                    label: "Weight Goal",
                    value: "\(targetWeight) kg target",
                    level: targetWeightAssessment.level,
                    advice: targetWeightAssessment.message
                )
            }
            overallWeightSummary
        }
    }

    @ViewBuilder
    private var assessmentNormal: some View {
        if bmiValue > 0 && bmiLevel != .invalidValue {
            AssessmentRow(
                label: "BMI",
                value: String(format: "%.1f", bmiValue),
                level: bmiLevel,
                advice: bmiAdviceForMode
            )
        }
    }

    // MARK: Overall Summaries

    @ViewBuilder
    private var overallDiabeticSummary: some View {
        let levels = [fastingSugar.isEmpty ? nil : fastingSugarLvl,
                      postMealSugar.isEmpty ? nil : postMealSugarLvl].compactMap { $0 }
        let hasError = levels.contains(.invalidValue)
        let hasHigh  = levels.contains(.veryHigh) || levels.contains(.high)
        let hasElevated = levels.contains(.elevated)

        if !levels.isEmpty {
            Divider()
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: hasError ? "exclamationmark.circle.fill" : (hasHigh ? "exclamationmark.triangle.fill" : (hasElevated ? "exclamationmark.circle.fill" : "checkmark.seal.fill")))
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(hasError ? .red : (hasHigh ? Color(red:0.88,green:0.15,blue:0.15) : (hasElevated ? Color(red:0.95,green:0.72,blue:0.10) : Color(red:0.20,green:0.78,blue:0.35))))
                VStack(alignment: .leading, spacing: 4) {
                    Text(hasError ? "Invalid Values Detected" : (hasHigh ? "High Blood Sugar — Action Needed" : (hasElevated ? "Pre-Diabetic Range — Monitor Closely" : "Blood Sugar Under Control")))
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.primary)
                    Text(hasError ? "Please re-enter your blood sugar values within realistic ranges." :
                         (hasHigh ? "Your sugar levels indicate active diabetes. Follow a strict low-GI diet and consult your doctor." :
                         (hasElevated ? "Your readings are in the pre-diabetic range. Diet and lifestyle changes can reverse this." :
                         "Great job managing your sugar! Your Nourish plan will reinforce this with balanced, low-GI meals.")))
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }

    @ViewBuilder
    private var overallHeartSummary: some View {
        let hasBP  = !bpSystolic.isEmpty && !bpDiastolic.isEmpty
        let hasChl = !cholesterol.isEmpty

        if hasBP || hasChl {
            let bpBad  = hasBP  && (bpLvl == .high || bpLvl == .veryHigh || bpLvl == .invalidValue)
                let chlBad = hasChl && (cholesterolLvl == .high || cholesterolLvl == .invalidValue)
            let anyBad = bpBad || chlBad

            Divider()
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: anyBad ? "heart.slash.fill" : "heart.fill")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(anyBad ? Color(red:0.88,green:0.15,blue:0.15) : Color(red:0.20,green:0.78,blue:0.35))
                VStack(alignment: .leading, spacing: 4) {
                    Text(anyBad ? "Cardiovascular Risk — Attention Needed" : "Heart Metrics Look Manageable")
                        .font(.system(size: 13, weight: .bold)).foregroundColor(.primary)
                    Text(anyBad ? "Elevated BP or cholesterol increases heart risk. Your Nourish plan will focus on low-sodium, omega-3-rich, heart-friendly meals." :
                         "Your heart metrics are in an acceptable range. Keep it up with heart-healthy food choices.")
                        .font(.system(size: 12)).foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }

    @ViewBuilder
    private var overallWeightSummary: some View {
        let twa = targetWeightAssessment
        if !targetWeight.isEmpty && twa.level != .invalidValue {
            Divider()
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: mode == .weightLoss ? "figure.walk" : "figure.strengthtraining.traditional")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(theme.primaryColor)
                VStack(alignment: .leading, spacing: 4) {
                    Text(mode == .weightLoss ? "Weight Loss Plan Ready" : "Weight Gain Plan Ready")
                        .font(.system(size: 13, weight: .bold)).foregroundColor(.primary)
                    Text("Your Nourish \(mode == .weightLoss ? "low-calorie, high-fibre" : "high-calorie, high-protein") plan is tailored to help you reach your goal safely.")
                        .font(.system(size: 12)).foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }

    private var bmiAdviceForMode: String {
        switch bmiLevel {
        case .underweight: return mode == .weightGain ? "You're underweight — our high-calorie plan will help you build healthy mass." : "You're underweight. Consider consulting a nutritionist before aggressive calorie cutting."
        case .normal:      return "Your BMI is healthy. Our plan will help you maintain this balance."
        case .elevated:    return mode == .weightLoss ? "You're overweight — our low-calorie, high-fibre plan targets healthy fat loss." : "Your BMI is slightly high. Consider a weight loss plan before switching to weight gain."
        case .overweight:  return "BMI indicates obesity. A doctor-supervised low-calorie plan is strongly recommended."
        default:           return ""
        }
    }

    // MARK: - Save Button

    private var saveButton: some View {
        Button(action: saveProfile) {
            HStack(spacing: 10) {
                Image(systemName: "checkmark.circle.fill").font(.system(size: 18))
                Text("Save & Continue").font(.system(size: 17, weight: .semibold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity).padding(.vertical, 17)
            .background(
                LinearGradient(colors:[theme.primaryColor, theme.accentColor], startPoint:.leading, endPoint:.trailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: theme.primaryColor.opacity(0.35), radius: 12, x: 0, y: 6)
        }
        .buttonStyle(.plain)
    }

    private func saveProfile() {
        // Validate basic fields
        guard ageError == nil, heightError == nil, weightError == nil,
              let ageVal = Int(age), ageVal > 0,
              let hVal = Double(heightCm), hVal > 0,
              let wVal = Double(weightKg), wVal > 0
        else { showValidationError = true; return }

        // Validate mode-specific fields for errors
        switch mode {
        case .diabetic:
            if fastingSugarLvl == .invalidValue && !fastingSugar.isEmpty { showValidationError = true; return }
            if postMealSugarLvl == .invalidValue && !postMealSugar.isEmpty { showValidationError = true; return }
        case .heartCare:
            if bpLvl == .invalidValue && !bpSystolic.isEmpty && !bpDiastolic.isEmpty { showValidationError = true; return }
            if cholesterolLvl == .invalidValue && !cholesterol.isEmpty { showValidationError = true; return }
        case .weightLoss, .weightGain:
            if !targetWeight.isEmpty && targetWeightAssessment.level == .invalidValue { showValidationError = true; return }
        case .normal: break
        }

        var p = HealthProfile()
        p.age = ageVal; p.gender = gender; p.heightCm = hVal; p.weightKg = wVal
        switch mode {
        case .diabetic:
            p.fastingSugar = Double(fastingSugar) ?? 0
            p.postMealSugar = Double(postMealSugar) ?? 0
        case .heartCare:
            p.bloodPressureSystolic = Int(bpSystolic) ?? 0
            p.bloodPressureDiastolic = Int(bpDiastolic) ?? 0
            p.cholesterolMgdL = Int(cholesterol) ?? 0
        case .weightLoss, .weightGain:
            p.targetWeightKg = Double(targetWeight) ?? 0
        case .normal: break
        }
        profileStore.save(profile: p, for: mode)
        dismiss()
    }
}

// MARK: - Profile Section

struct ProfileSection<Content: View>: View {
    let title: String
    let icon: String
    let color: Color
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8).fill(color.opacity(0.12)).frame(width: 32, height: 32)
                    Image(systemName: icon).font(.system(size: 14, weight: .semibold)).foregroundColor(color)
                }
                Text(title).font(.system(size: 16, weight: .semibold)).foregroundColor(.primary)
            }
            content()
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemBackground)).shadow(color: Color.black.opacity(0.05), radius: 12, x: 0, y: 3))
    }
}

// MARK: - Profile Field Row (with inline level badge + error)

struct ProfileFieldRow: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboard: UIKeyboardType = .default
    var levelBadge: HealthLevel? = nil
    var errorMessage: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(label)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
                    .tracking(0.3)
                Spacer()
                if let level = levelBadge {
                    LevelBadgeView(level: level)
                        .transition(.opacity.combined(with: .scale(scale: 0.85)))
                }
            }
            TextField(placeholder, text: $text)
                .keyboardType(keyboard)
                .font(.system(size: 17, weight: .semibold))
                .padding(14)
                .background(
                    errorMessage != nil
                        ? Color(red: 1.0, green: 0.92, blue: 0.92)
                        : Color(.systemGray6),
                    in: RoundedRectangle(cornerRadius: 12)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(errorMessage != nil ? Color.red.opacity(0.45) : Color.clear, lineWidth: 1.5)
                )
                .animation(.easeInOut(duration: 0.2), value: errorMessage != nil)

            if let err = errorMessage {
                HStack(alignment: .top, spacing: 5) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                    Text(err)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.red)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.75), value: levelBadge?.label)
        .animation(.spring(response: 0.3, dampingFraction: 0.75), value: errorMessage)
    }
}

// MARK: - Level Badge View

struct LevelBadgeView: View {
    let level: HealthLevel

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: level.icon)
                .font(.system(size: 11, weight: .bold))
            Text(level.label)
                .font(.system(size: 11, weight: .bold))
        }
        .foregroundColor(level.color)
        .padding(.horizontal, 8).padding(.vertical, 4)
        .background(level.color.opacity(0.12), in: Capsule())
    }
}

// MARK: - Assessment Row

struct AssessmentRow: View {
    let label: String
    let value: String
    let level: HealthLevel
    let advice: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(label)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                        .tracking(0.2)
                    Text(value)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                }
                Spacer()
                LevelBadgeView(level: level)
            }

            // Meter bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(.systemGray5))
                        .frame(height: 6)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(level.color)
                        .frame(width: geo.size.width * meterFraction, height: 6)
                }
            }
            .frame(height: 6)

            if let advice = advice, !advice.isEmpty {
                Text(advice)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 2)
            }
        }
        .padding(14)
        .background(level.color.opacity(0.06), in: RoundedRectangle(cornerRadius: 14))
        .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(level.color.opacity(0.18), lineWidth: 1))
    }

    private var meterFraction: CGFloat {
        switch level {
        case .low:         return 0.15
        case .normal:      return 0.40
        case .elevated:    return 0.62
        case .high:        return 0.80
        case .veryHigh:    return 1.00
        case .underweight: return 0.15
        case .overweight:  return 0.85
        case .invalidValue:       return 0.0
        }
    }
}

// MARK: - Goal Message View

struct GoalMessageView: View {
    let level: HealthLevel
    let message: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: level == .elevated ? "exclamationmark.triangle.fill" : "flag.fill")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(level == .elevated ? Color(red:0.95,green:0.72,blue:0.10) : color)
            Text(message)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            (level == .elevated ? Color(red:0.95,green:0.72,blue:0.10) : color).opacity(0.09),
            in: RoundedRectangle(cornerRadius: 12)
        )
    }
}

#Preview {
    HealthProfileView(mode: .diabetic)
        .environmentObject(HealthProfileStore())
        .environmentObject(HealthModeManager())
}
