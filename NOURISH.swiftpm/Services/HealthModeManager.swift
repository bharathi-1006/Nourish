import SwiftUI

// MARK: - Health Mode Manager

/// Owns the active HealthMode and exposes theme/suggestions.
/// Recipe filtering is delegated to ModeContext - never done ad-hoc in views.
final class HealthModeManager: ObservableObject {

    @Published var currentMode: HealthMode {
        didSet { saveMode() }
    }

    private let modeKey = "selectedHealthMode"

    init() {
        if let raw  = UserDefaults.standard.string(forKey: modeKey),
           let mode = HealthMode(rawValue: raw) {
            self.currentMode = mode
        } else {
            self.currentMode = .normal
        }
    }

    private func saveMode() {
        UserDefaults.standard.set(currentMode.rawValue, forKey: modeKey)
    }

    // MARK: - Theme

    var theme: HealthModeTheme {
        HealthModeTheme.theme(for: currentMode)
    }

    // MARK: - Ingredient Suggestions

    var ingredientSuggestions: [String] {
        IngredientSuggestions.suggestions(for: currentMode)
    }

    // MARK: - Recipe Filtering (delegate to ModeContext)

    /// Returns only recipes that belong to the current mode.
    /// All callers must use this method - never filter recipes manually in views.
    func filteredRecipes(from recipes: [Recipe]) -> [Recipe] {
        ModeContext.recipes(for: currentMode, from: recipes)
    }

    /// Returns mode-filtered recipes for a specific meal slot.
    func recipes(for slot: MealSlot, from all: [Recipe]) -> [Recipe] {
        ModeContext.recipes(for: currentMode, slot: slot, from: all)
    }

    /// Returns true only when the recipe belongs to the current mode.
    func isSuitableForCurrentMode(_ recipe: Recipe) -> Bool {
        recipe.mode == currentMode
    }
}
