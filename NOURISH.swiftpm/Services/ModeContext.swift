import Foundation

// MARK: - MealSlot
// Single canonical definition of every meal slot supported by the planner.
// All features (Smart, Fixed, Regular) must use these constants — never raw strings.

enum MealSlot: String, CaseIterable, Identifiable {
    case breakfast = "breakfast"
    case lunch     = "lunch"
    case dinner    = "dinner"
    case snack     = "snack"
    case beverage  = "beverage"

    var id: String { rawValue }

    /// The Recipe.category string that maps to this slot.
    var recipeCategory: String {
        switch self {
        case .breakfast: return "Breakfast"
        case .lunch:     return "Lunch"
        case .dinner:    return "Dinner"
        case .snack:     return "Snacks"
        case .beverage:  return "Beverages"
        }
    }

    var displayName: String { rawValue.capitalized }

    var icon: String {
        switch self {
        case .breakfast: return "☀️"
        case .lunch:     return "🥗"
        case .dinner:    return "🍽️"
        case .snack:     return "🥜"
        case .beverage:  return "🥤"
        }
    }

    var systemIcon: String {
        switch self {
        case .breakfast: return "sunrise.fill"
        case .lunch:     return "sun.max.fill"
        case .dinner:    return "moon.stars.fill"
        case .snack:     return "leaf.fill"
        case .beverage:  return "cup.and.saucer.fill"
        }
    }
}

// MARK: - ModeContext
// Stateless namespace — pure functions, no stored state.
// Every call site that needs mode-filtered recipes must go through here.
// This is the SINGLE enforcement point for mode isolation.

enum ModeContext {

    // MARK: - Core Filtering

    /// Returns only recipes that belong to `mode`. Zero cross-mode leakage.
    static func recipes(for mode: HealthMode, from all: [Recipe]) -> [Recipe] {
        all.filter { $0.mode == mode }
    }

    /// Returns mode-filtered recipes for a specific meal slot.
    static func recipes(
        for mode: HealthMode,
        slot: MealSlot,
        from all: [Recipe]
    ) -> [Recipe] {
        all.filter { $0.mode == mode && $0.category == slot.recipeCategory }
    }

    /// Returns mode-filtered recipes for a category string.
    static func recipes(
        for mode: HealthMode,
        category: String,
        from all: [Recipe]
    ) -> [Recipe] {
        all.filter { $0.mode == mode && $0.category == category }
    }

    // MARK: - Slot Resolution

    /// Canonical mapping from a raw slot string to a MealSlot enum.
    /// Falls back to `.breakfast` so nothing is silently discarded.
    static func slot(from rawValue: String) -> MealSlot {
        MealSlot(rawValue: rawValue.lowercased()) ?? .breakfast
    }

    // MARK: - Coverage Check

    /// Returns all slots that have at least one recipe for the given mode.
    static func coveredSlots(for mode: HealthMode, from all: [Recipe]) -> Set<MealSlot> {
        let modeRecipes = recipes(for: mode, from: all)
        return Set(MealSlot.allCases.filter { slot in
            modeRecipes.contains { $0.category == slot.recipeCategory }
        })
    }
}
