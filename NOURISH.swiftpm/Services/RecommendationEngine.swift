import Foundation

// MARK: - Recipe Nutrition Profile

struct RecipeNutritionProfile {
    let calories:  Int
    let proteinG:  Double
    let carbsG:    Double
    let fatG:      Double
    let fiberG:    Double
    let sugarG:    Double
    let sodiumMg:  Double
    let isHighGI:  Bool

    init(recipe: Recipe) {
        calories = recipe.nutrition.calories
        proteinG = Self.parse(recipe.nutrition.protein)
        carbsG   = Self.parse(recipe.nutrition.carbs)
        fatG     = Self.parse(recipe.nutrition.fat)
        fiberG   = Self.parse(recipe.nutrition.fiber)

        let sweetWords = ["sugar", "honey", "jaggery", "syrup", "jam", "condensed", "sweet"]
        let hasSweet   = recipe.ingredients.contains { ing in
            sweetWords.contains { ing.name.localizedCaseInsensitiveContains($0) }
        }
        sugarG = hasSweet ? carbsG * 0.4 : carbsG * 0.1

        let saltyWords = ["salt", "soy sauce", "pickle", "preserved", "sodium", "brine", "pappad"]
        let saltyCount = recipe.ingredients.filter { ing in
            saltyWords.contains { ing.name.localizedCaseInsensitiveContains($0) }
        }.count
        sodiumMg = Double(saltyCount) * 300 + Double(calories) * 0.5

        let highGIWords = ["white rice", "white bread", "maida", "refined", "potato", "watermelon"]
        isHighGI = recipe.ingredients.contains { ing in
            highGIWords.contains { ing.name.localizedCaseInsensitiveContains($0) }
        }
    }

    private static func parse(_ value: String) -> Double {
        let chars = value.unicodeScalars.filter {
            CharacterSet.decimalDigits.union(CharacterSet(charactersIn: ".")).contains($0)
        }
        return Double(String(chars.map(Character.init))) ?? 0
    }
}

// MARK: - Recommendation Engine

/// Pure stateless engine. All public methods are thread-safe.
/// ARCHITECTURE RULE: This engine NEVER accesses recipes without a mode filter.
/// All filtering is delegated to ModeContext to guarantee mode isolation.
enum RecommendationEngine {

    // MARK: - Scoring

    static func score(recipe: Recipe, mode: HealthMode, profile: HealthProfile) -> Double {
        let np     = RecipeNutritionProfile(recipe: recipe)
        let target = profile.targetCalories(for: mode)
        switch mode {
        case .normal:     return scoreNormal(np: np, target: target)
        case .diabetic:   return scoreDiabetic(np: np, profile: profile)
        case .heartCare:  return scoreHeartCare(np: np, profile: profile)
        case .weightLoss: return scoreWeightLoss(np: np, target: target)
        case .weightGain: return scoreWeightGain(np: np, target: target)
        }
    }

    private static func scoreNormal(np: RecipeNutritionProfile, target: Int) -> Double {
        let calDiff   = abs(Double(np.calories) - Double(target) / 3.0)
        let calScore  = max(0, 1.0 - calDiff / 400)
        let protScore = min(np.proteinG / 25.0, 1.0)
        return calScore * 0.5 + protScore * 0.5
    }

    private static func scoreDiabetic(np: RecipeNutritionProfile, profile: HealthProfile) -> Double {
        let sugarPenalty  = np.sugarG > 10 ? -0.4 : (np.sugarG > 5 ? -0.2 : 0.0)
        let giPenalty     = np.isHighGI ? -0.3 : 0.1
        let carbMatch     = np.carbsG < 30 ? 0.3 : (np.carbsG < 45 ? 0.1 : -0.2)
        let fiberBonus    = min(np.fiberG / 10.0, 1.0) * 0.3
        let proteinBonus  = min(np.proteinG / 20.0, 1.0) * 0.2
        let sugarSeverity = (profile.fastingSugar > 180 || profile.postMealSugar > 250) ? -0.2 : 0.0
        return max(0, 0.5 + sugarPenalty + giPenalty + carbMatch + fiberBonus + proteinBonus + sugarSeverity)
    }

    private static func scoreHeartCare(np: RecipeNutritionProfile, profile: HealthProfile) -> Double {
        let sodiumPenalty = np.sodiumMg > 600 ? -0.4 : (np.sodiumMg > 400 ? -0.2 : 0.1)
        let fatPenalty    = np.fatG > 20 ? -0.3 : (np.fatG > 12 ? -0.1 : 0.1)
        let fiberBonus    = min(np.fiberG / 8.0, 1.0) * 0.3
        let calBonus      = np.calories < 350 ? 0.2 : (np.calories < 500 ? 0.1 : -0.1)
        let bpSeverity    = profile.bloodPressureSystolic > 160
            ? (np.sodiumMg > 300 ? -0.2 : 0.1) : 0.0
        return max(0, 0.5 + sodiumPenalty + fatPenalty + fiberBonus + calBonus + bpSeverity)
    }

    private static func scoreWeightLoss(np: RecipeNutritionProfile, target: Int) -> Double {
        let perMeal      = Double(target) / 3.0
        let calMatch     = max(0, 1.0 - abs(Double(np.calories) - perMeal) / 300) * 0.3
        let proteinBonus = min(np.proteinG / 25.0, 1.0) * 0.3
        let fiberBonus   = min(np.fiberG / 8.0, 1.0) * 0.2
        let lowCalBonus  = np.calories < 300 ? 0.2 : (np.calories < 400 ? 0.1 : -0.1)
        return max(0, calMatch + proteinBonus + fiberBonus + lowCalBonus)
    }

    private static func scoreWeightGain(np: RecipeNutritionProfile, target: Int) -> Double {
        let perMeal      = Double(target) / 3.0
        let calMatch     = max(0, 1.0 - abs(Double(np.calories) - perMeal) / 400) * 0.3
        let proteinBonus = min(np.proteinG / 30.0, 1.0) * 0.3
        let fatBonus     = np.fatG > 10 ? 0.2 : 0.0
        let highCalBonus = np.calories > 400 ? 0.2 : (np.calories > 300 ? 0.1 : -0.1)
        return max(0, calMatch + proteinBonus + fatBonus + highCalBonus)
    }

    // MARK: - Plan Generation

    /// Generates a 7-day plan (Mon->Sun) covering ALL five meal slots per day:
    /// breakfast, lunch, dinner, snack, beverage.
    ///
    /// ISOLATION GUARANTEE: Only recipes whose `mode` == `mode` parameter are used.
    /// All filtering is performed via ModeContext - never from a global pool.
    ///
    /// Safe to call from a background thread.
    static func generatePlanSync(
        recipes: [Recipe],
        mode: HealthMode,
        profile: HealthProfile
    ) -> [[String: Recipe]] {
        // Step 1: Hard mode filter via ModeContext - zero cross-mode leakage
        let modeRecipes = ModeContext.recipes(for: mode, from: recipes)
        guard !modeRecipes.isEmpty else {
            return Array(repeating: [:], count: 7)
        }

        // Step 2: Score all mode-specific recipes
        let scored    = modeRecipes
            .map { ($0, score(recipe: $0, mode: mode, profile: profile)) }
            .sorted { $0.1 > $1.1 }
        let allSorted = scored.map { $0.0 }

        // Step 3: Build per-slot pools using MealSlot canonical mapping
        // ALL five slots are included - breakfast, lunch, dinner, snack, beverage
        var pools: [MealSlot: [Recipe]] = [:]
        for slot in MealSlot.allCases {
            var pool = scored
                .filter { $0.0.category == slot.recipeCategory }
                .map { $0.0 }
            // If a slot has fewer than 7 mode-recipes, pad with highest-scored
            // same-mode recipes so we never run dry across 7 days
            if pool.count < 7 {
                let existing = Set(pool.map { $0.id })
                pool += allSorted.filter { !existing.contains($0.id) }
            }
            pools[slot] = pool
        }

        // Step 4: Build 7-day plan with per-slot uniqueness tracking
        var used: [MealSlot: Set<String>] = Dictionary(
            uniqueKeysWithValues: MealSlot.allCases.map { ($0, Set<String>()) }
        )
        var plan: [[String: Recipe]] = []

        for _ in 0..<7 {
            var day: [String: Recipe] = [:]
            for slot in MealSlot.allCases {
                guard let pool = pools[slot] else { continue }
                if let recipe = pickUnique(from: pool, used: &used[slot, default: []]) {
                    day[slot.rawValue] = recipe
                }
            }
            plan.append(day)
        }

        return plan
    }

    // MARK: - Helpers

    private static func pickUnique(from pool: [Recipe], used: inout Set<String>) -> Recipe? {
        for recipe in pool where !used.contains(recipe.id) {
            used.insert(recipe.id)
            return recipe
        }
        return pool.first
    }
}
