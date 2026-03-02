import SwiftUI

// MARK: - Not Recommended Page

struct NotRecommendedView: View {
    @EnvironmentObject var modeManager: HealthModeManager
    @Environment(\.dismiss) var dismiss
    
    private var foods: [NotRecommendedItem] {
        NotRecommendedProvider.foods(for: modeManager.currentMode)
    }
    
    private var ingredients: [NotRecommendedItem] {
        NotRecommendedProvider.ingredients(for: modeManager.currentMode)
    }
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            modeManager.theme.backgroundGradient.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    // Header - Apple style
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 12) {
                            Image(systemName: "exclamationmark.shield.fill")
                                .font(.system(size: 34, weight: .medium))
                                .foregroundColor(.orange)
                            Text("Not Recommended")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(.primary)
                        }
                        
                        Text("Foods to avoid for \(modeManager.currentMode.displayName) mode")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.secondary)
                            .padding(.top, 2)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    
                    // Not Recommended Foods
                    if !foods.isEmpty {
                        VStack(alignment: .leading, spacing: 14) {
                            HStack(spacing: 8) {
                                Image(systemName: "x.circle.fill")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.red)
                                Text("Not Recommended Foods")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.primary)
                            }
                            .padding(.horizontal, 20)
                            
                            VStack(spacing: 10) {
                                ForEach(foods) { item in
                                    NotRecommendedCard(item: item)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    // Not Recommended Ingredients
                    if !ingredients.isEmpty {
                        VStack(alignment: .leading, spacing: 14) {
                            HStack(spacing: 8) {
                                Image(systemName: "exclamationmark.circle.fill")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.orange)
                                Text("Not Recommended Ingredients")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.primary)
                            }
                            .padding(.horizontal, 20)
                            
                            VStack(spacing: 10) {
                                ForEach(ingredients) { item in
                                    NotRecommendedCard(item: item)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    // Info Box - Apple style
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 8) {
                            Image(systemName: "info.circle.fill")
                                .font(.system(size: 18))
                                .foregroundColor(modeManager.theme.primaryColor)
                            Text("Why These Restrictions?")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.primary)
                        }
                        
                        Text(getModeSpecificInfo())
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.secondary)
                            .lineSpacing(5)
                    }
                    .padding(18)
                    .background(modeManager.theme.primaryColor.opacity(0.06))
                    .cornerRadius(14)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                }
            }
        }
        .navigationTitle("Not Recommended")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func getModeSpecificInfo() -> String {
        switch modeManager.currentMode {
        case .normal:
            return "No specific restrictions for normal mode."
        case .diabetic:
            return "These items can cause rapid blood sugar spikes or worsen insulin resistance. Focus on low-glycemic, high-fiber alternatives."
        case .heartCare:
            return "These items are high in saturated fats, trans fats, or sodium which can negatively impact heart health and cholesterol levels."
        case .weightLoss:
            return "These items are calorie-dense with poor satiety value, making it harder to maintain a calorie deficit for weight loss."
        case .weightGain:
            return "These items are too low in calories or act as appetite suppressants, making it difficult to achieve the calorie surplus needed for weight gain."
        }
    }
}

// MARK: - Not Recommended Card

struct NotRecommendedCard: View {
    @EnvironmentObject var modeManager: HealthModeManager
    let item: NotRecommendedItem
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: 11)
                    .fill(Color.red.opacity(0.08))
                    .frame(width: 54, height: 54)
                
                Text(item.icon)
                    .font(.system(size: 28))
            }
            
            // Content
            VStack(alignment: .leading, spacing: 5) {
                Text(item.name)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text(item.reason)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.secondary)
                    .lineSpacing(4)
            }
            
            Spacer(minLength: 0)
        }
        .padding(14)
        .background(Color(.systemGray6).opacity(0.5))
        .cornerRadius(13)
        .overlay(
            RoundedRectangle(cornerRadius: 13)
                .strokeBorder(Color.red.opacity(0.15), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.02), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    NavigationStack {
        NotRecommendedView()
            .environmentObject(HealthModeManager())
    }
}
