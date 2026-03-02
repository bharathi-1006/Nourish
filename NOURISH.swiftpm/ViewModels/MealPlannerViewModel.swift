import Foundation
import SwiftUI

// MARK: - Plan Mode

enum PlanMode: String {
    case regular = "Regular"
    case fixed   = "Fixed"
    case smart   = "Smart"
}

// MARK: - Weekly Plan

typealias WeeklyPlan = [[String: Recipe]]

// MARK: - Meal Planner ViewModel

@MainActor
final class MealPlannerViewModel: ObservableObject {

    // MARK: - Published State

    @Published private(set) var isGenerating: Bool = false

    // MARK: - Per-mode smart plan cache
    // Each mode stores its own 7-day plan independently.
    // Switching modes never touches another mode's plan.
    private var smartPlans: [String: WeeklyPlan] = [:]
    private var generationTask: Task<Void, Never>?

    // MARK: - Plan Mode (persisted)

    var planMode: PlanMode {
        get {
            let raw = UserDefaults.standard.string(forKey: "mealPlannerMode") ?? "Regular"
            return PlanMode(rawValue: raw) ?? .regular
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "mealPlannerMode")
        }
    }

    // MARK: - Smart Plan for current mode (read-only)

    func smartWeeklyPlan(for mode: HealthMode) -> WeeklyPlan {
        smartPlans[mode.rawValue] ?? []
    }

    func hasSmartPlan(for mode: HealthMode) -> Bool {
        let plan = smartPlans[mode.rawValue] ?? []
        return !plan.isEmpty
    }

    // MARK: - Generate Smart Plan (mode-isolated, background)

    func generateSmartPlan(
        allRecipes: [Recipe],
        mode: HealthMode,
        profile: HealthProfile,
        force: Bool = false
    ) {
        let key = mode.rawValue
        guard force || !hasSmartPlan(for: mode) else { return }
        guard !isGenerating else { return }
        // GUARD: Do not generate suggestions without a completed health profile.
        // profile.isCompleted(for:) validates that real data was entered.
        guard profile.isCompleted(for: mode) else { return }

        isGenerating = true
        generationTask?.cancel()

        generationTask = Task {
            // Hard mode filter BEFORE passing to engine
            let modeRecipes = ModeContext.recipes(for: mode, from: allRecipes)

            let plan = await Task.detached(priority: .userInitiated) {
                RecommendationEngine.generatePlanSync(
                    recipes: modeRecipes,
                    mode: mode,
                    profile: profile
                )
            }.value

            guard !Task.isCancelled else {
                self.isGenerating = false
                return
            }

            self.smartPlans[key] = plan
            self.isGenerating = false
        }
    }

    func invalidateSmartPlan(for mode: HealthMode) {
        smartPlans.removeValue(forKey: mode.rawValue)
    }

    // MARK: - Fill ALL visible dates with smart meals

    /// Called once after profile is saved for a mode.
    /// Fills every date in `dates` with mode-specific meals for any empty slot.
    /// Uses the generated weekly plan (7-day rotation) to assign meals per date.
    /// Never overwrites existing smart meals.
    func fillSmartMealsForAllDates(
        dates: [Date],
        mode: HealthMode,
        profile: HealthProfile,
        allRecipes: [Recipe],
        existingMealPlan: [MealPlanItem],   // entire mealPlan array
        onAdd: @escaping (String, Date, String) -> Void  // (recipeId, date, slotRaw)
    ) {
        // Require a generated plan first
        guard let weekPlan = smartPlans[mode.rawValue], !weekPlan.isEmpty else { return }

        let modeRecipes    = ModeContext.recipes(for: mode, from: allRecipes)
        let targetPerMeal  = max(1, profile.targetCalories(for: mode) / MealSlot.allCases.count)
        let calendar       = Calendar.current

        Task.detached(priority: .userInitiated) { [modeRecipes, dates, existingMealPlan, weekPlan] in
            // Build a set of already-filled (date+slot) keys for fast lookup
            let alreadyFilled: Set<String> = Set(
                existingMealPlan
                    .filter { $0.source == "smart" }
                    .map { "\(calendar.startOfDay(for: $0.date).timeIntervalSince1970)_\($0.meal)" }
            )

            // Use immutable let + flatMap to avoid captured 'var' across concurrency boundary
            let picks: [(recipeId: String, date: Date, slotRaw: String)] =
                dates.enumerated().flatMap { (dateIdx, date)
                    -> [(recipeId: String, date: Date, slotRaw: String)] in
                let dayPlan = weekPlan[dateIdx % weekPlan.count]
                let dateKey = calendar.startOfDay(for: date).timeIntervalSince1970
                return MealSlot.allCases.compactMap { slot
                    -> (recipeId: String, date: Date, slotRaw: String)? in
                    let fillKey = "\(dateKey)_\(slot.rawValue)"
                    guard !alreadyFilled.contains(fillKey) else { return nil }
                    // Prefer the pre-scored recipe from the weekly plan for this slot
                    if let planRecipe = dayPlan[slot.rawValue], planRecipe.mode == mode {
                        return (planRecipe.id, date, slot.rawValue)
                    }
                    // Fallback: pick the best-calorie-matched recipe from the mode pool
                    let pool = modeRecipes.filter {
                        $0.category == slot.recipeCategory && $0.mode == mode
                    }
                    if let recipe = pool.min(by: {
                        abs($0.nutrition.calories - targetPerMeal) <
                        abs($1.nutrition.calories - targetPerMeal)
                    }) ?? pool.randomElement() {
                        return (recipe.id, date, slot.rawValue)
                    }
                    return nil
                }
            }

            await MainActor.run {
                picks.forEach { onAdd($0.recipeId, $0.date, $0.slotRaw) }
            }
        }
    }

    // MARK: - Clear smart meals for a mode

    /// Removes ALL smart-sourced meal plan items for a specific mode.
    /// Called when switching away from smart mode or switching health modes.
    func clearSmartMeals(
        mode: HealthMode,
        allRecipes: [Recipe],
        mealPlan: [MealPlanItem],
        onRemove: @escaping (String) -> Void  // (itemId)
    ) {
        // Remove smart meals whose recipe belongs to this mode
        let modeRecipeIds = Set(ModeContext.recipes(for: mode, from: allRecipes).map { $0.id })
        let toRemove = mealPlan.filter {
            $0.source == "smart" && modeRecipeIds.contains($0.recipeId)
        }
        toRemove.forEach { onRemove($0.id) }
    }

    // MARK: - Nutrition Helpers

    func parseNutritionValue(_ value: String) -> Double {
        let digits = value.components(separatedBy:
            CharacterSet.decimalDigits.union(CharacterSet(charactersIn: ".")).inverted
        ).joined()
        return Double(digits) ?? 0
    }

    func wellnessMessage(
        calories: Int,
        protein: Double,
        plannedCount: Int
    ) -> (icon: String, text: String, color: Color) {
        guard plannedCount > 0 else {
            return ("calendar.badge.plus", "Start planning your day", Color.secondary)
        }
        switch calories {
        case 0..<1200:
            return ("arrow.up.heart.fill", "Add more meals for energy",
                    Color(red: 0.95, green: 0.58, blue: 0.15))
        case 1200..<1600:
            return ("leaf.fill", "Light & balanced day",
                    Color(red: 0.20, green: 0.78, blue: 0.35))
        case 1600..<2200:
            if protein >= 50 {
                return ("figure.strengthtraining.traditional", "Protein balance achieved",
                        Color(red: 0.42, green: 0.34, blue: 0.85))
            }
            return ("checkmark.seal.fill", "Balanced intake today",
                    Color(red: 0.20, green: 0.78, blue: 0.35))
        case 2200..<2800:
            return ("bolt.heart.fill", "Good energy level",
                    Color(red: 0.95, green: 0.38, blue: 0.38))
        default:
            return ("exclamationmark.triangle.fill", "High calorie day",
                    Color(red: 0.95, green: 0.38, blue: 0.38))
        }
    }
}
