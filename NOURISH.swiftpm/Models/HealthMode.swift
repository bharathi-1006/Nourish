import SwiftUI

// MARK: - Health Mode Enum

enum HealthMode: String, Codable, CaseIterable, Identifiable {
    case normal = "Normal"
    case diabetic = "Diabetic"
    case heartCare = "Heart Care"
    case weightLoss = "Weight Loss"
    case weightGain = "Weight Gain"
    
    var id: String { rawValue }
    
    var displayName: String {
        rawValue
    }
    
    var icon: String {
        switch self {
        case .normal: return "heart.fill"
        case .diabetic: return "drop.fill"
        case .heartCare: return "heart.circle.fill"
        case .weightLoss: return "figure.walk"
        case .weightGain: return "figure.strengthtraining.traditional"
        }
    }
    
    var description: String {
        switch self {
        case .normal: return "All recipes"
        case .diabetic: return "Low sugar & glycemic index"
        case .heartCare: return "Low sodium & fat"
        case .weightLoss: return "Low calorie & high fiber"
        case .weightGain: return "High calorie & protein"
        }
    }
}

// MARK: - Health Mode Theme (MODERNIZED)

struct HealthModeTheme {
    let primaryColor: Color
    let accentColor: Color
    let backgroundGradient: LinearGradient
    let cardBackground: Color
    
    static func theme(for mode: HealthMode) -> HealthModeTheme {
        switch mode {
        case .normal:
            // Rich caramel-gold — warm, calm, premium first impression.
            // Warm family (like weightGain) but clearly distinct: deeper, richer, more golden.
            // weightGain = bright tangerine (R0.95 G0.58 B0.15) → this is a warm caramel-gold shifted
            // toward brown-gold, lower brightness, far more subdued and premium-feeling.
            let normalPrimary = Color(red: 0.78, green: 0.50, blue: 0.16)   // rich caramel gold
            let normalMid     = Color(red: 0.92, green: 0.74, blue: 0.42)   // warm golden highlight
            return HealthModeTheme(
                primaryColor: normalPrimary,
                accentColor:  Color(red: 0.66, green: 0.40, blue: 0.10),
                backgroundGradient: LinearGradient(
                    colors: [
                        normalPrimary.opacity(0.10),
                        normalMid.opacity(0.05),
                        Color.clear
                    ],
                    startPoint: .top,
                    endPoint: .center
                ),
                cardBackground: Color(red: 0.99, green: 0.97, blue: 0.92)
            )
            
        case .diabetic:
            // Medical teal/cyan - professional, distinct, trustworthy
            return HealthModeTheme(
                primaryColor: Color(red: 0.20, green: 0.68, blue: 0.78),  // Distinct medical teal
                accentColor: Color(red: 0.15, green: 0.62, blue: 0.72),
                backgroundGradient: LinearGradient(
                    colors: [
                        Color(red: 0.20, green: 0.68, blue: 0.78).opacity(0.06),
                        Color.clear
                    ],
                    startPoint: .top,
                    endPoint: .center
                ),
                cardBackground: Color(red: 0.96, green: 0.99, blue: 0.99)
            )
            
        case .heartCare:
            // Soft warm red - caring, gentle
            return HealthModeTheme(
                primaryColor: Color(red: 0.95, green: 0.38, blue: 0.38),
                accentColor: Color(red: 0.88, green: 0.32, blue: 0.32),
                backgroundGradient: LinearGradient(
                    colors: [
                        Color(red: 0.95, green: 0.38, blue: 0.38).opacity(0.05),
                        Color.clear
                    ],
                    startPoint: .top,
                    endPoint: .center
                ),
                cardBackground: Color(red: 0.99, green: 0.97, blue: 0.97)
            )
            
        case .weightLoss:
            // Fresh green - energetic, healthy
            return HealthModeTheme(
                primaryColor: Color(red: 0.20, green: 0.78, blue: 0.35),
                accentColor: Color(red: 0.15, green: 0.68, blue: 0.30),
                backgroundGradient: LinearGradient(
                    colors: [
                        Color(red: 0.20, green: 0.78, blue: 0.35).opacity(0.05),
                        Color.clear
                    ],
                    startPoint: .top,
                    endPoint: .center
                ),
                cardBackground: Color(red: 0.97, green: 0.99, blue: 0.97)
            )
            
        case .weightGain:
            // Warm orange - energizing, nourishing
            return HealthModeTheme(
                primaryColor: Color(red: 0.95, green: 0.58, blue: 0.15),
                accentColor: Color(red: 0.88, green: 0.52, blue: 0.12),
                backgroundGradient: LinearGradient(
                    colors: [
                        Color(red: 0.95, green: 0.58, blue: 0.15).opacity(0.05),
                        Color.clear
                    ],
                    startPoint: .top,
                    endPoint: .center
                ),
                cardBackground: Color(red: 0.99, green: 0.98, blue: 0.97)
            )
        }
    }
}

// MARK: - Recipe Health Tag

enum RecipeHealthTag: String, Codable {
    case diabeticFriendly = "Diabetic Friendly"
    case heartHealthy = "Heart Healthy"
    case lowCalorie = "Low Calorie"
    case highProtein = "High Protein"
    case highCalorie = "High Calorie"
    case regular = "Regular"
    
    // ML-based classification logic (offline, rule-based)
    static func classify(recipe: Recipe) -> Set<RecipeHealthTag> {
        var tags: Set<RecipeHealthTag> = [.regular]
        
        let calories = recipe.nutrition.calories
        let protein = parseNutritionValue(recipe.nutrition.protein)
        let carbs = parseNutritionValue(recipe.nutrition.carbs)
        let fat = parseNutritionValue(recipe.nutrition.fat)
        let fiber = parseNutritionValue(recipe.nutrition.fiber)
        
        // Diabetic Friendly: Low carbs, high fiber, low sugar ingredients
        let diabeticKeywords = ["sugar", "honey", "jaggery", "sweet"]
        let hasHighSugar = recipe.ingredients.contains { ingredient in
            diabeticKeywords.contains { ingredient.name.localizedCaseInsensitiveContains($0) }
        }
        
        if carbs < 40 && fiber > 5 && !hasHighSugar {
            tags.insert(.diabeticFriendly)
        }
        
        // Heart Healthy: Low sodium, low saturated fat
        let heartHealthyKeywords = ["salt", "sodium", "butter", "cream", "ghee"]
        let hasHighSodium = recipe.ingredients.contains { ingredient in
            heartHealthyKeywords.contains { ingredient.name.localizedCaseInsensitiveContains($0) }
        }
        
        if fat < 15 && !hasHighSodium {
            tags.insert(.heartHealthy)
        }
        
        // Low Calorie: < 300 calories
        if calories < 300 {
            tags.insert(.lowCalorie)
        }
        
        // High Protein: > 20g protein
        if protein > 20 {
            tags.insert(.highProtein)
        }
        
        // High Calorie: > 450 calories
        if calories > 450 {
            tags.insert(.highCalorie)
        }
        
        return tags
    }
    
    private static func parseNutritionValue(_ value: String) -> Double {
        // Extract numeric value from strings like "15g", "20.5g"
        let numbers = value.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return Double(numbers) ?? 0
    }
}

// MARK: - Ingredient Suggestions

struct IngredientSuggestions {
    static func suggestions(for mode: HealthMode) -> [String] {
        switch mode {
        case .normal:
            return [
                "Onion", "Tomato", "Potato", "Paneer", "Chicken",
                "Rice", "Egg", "Spinach", "Lentils", "Curd"
            ]
            
        case .diabetic:
            return [
                "Spinach", "Broccoli", "Cabbage", "Cauliflower", "Bitter Gourd",
                "Moong Dal", "Chickpeas", "Quinoa", "Brown Rice", "Oats",
                "Ragi", "Almonds", "Walnuts", "Flaxseeds", "Chia Seeds"
            ]
            
        case .heartCare:
            return [
                "Tomato", "Spinach", "Broccoli", "Avocado", "Olive Oil",
                "Garlic", "Onion", "Lentils", "Quinoa", "Salmon",
                "Walnuts", "Almonds", "Oats", "Berries", "Green Tea"
            ]
            
        case .weightLoss:
            return [
                "Cucumber", "Lettuce", "Celery", "Zucchini", "Mushroom",
                "Egg White", "Tofu", "Sprouts", "Lentils", "Quinoa",
                "Apple", "Berries", "Green Tea", "Lemon", "Mint"
            ]
            
        case .weightGain:
            return [
                "Peanut Butter", "Almonds", "Cashews", "Paneer", "Chicken",
                "Egg", "Potato", "Sweet Potato", "Rice", "Oats",
                "Banana", "Avocado", "Milk", "Curd", "Ghee"
            ]
        }
    }
}
