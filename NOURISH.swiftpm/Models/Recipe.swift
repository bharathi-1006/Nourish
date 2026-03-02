import Foundation

struct Recipe: Codable, Identifiable, Hashable {
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (lhs: Recipe, rhs: Recipe) -> Bool { lhs.id == rhs.id }
    let id: String
    let title: String
    let description: String
    let heroImage: String // Base64 or system image name
    let cuisine: String
    let diet: String
    let category: String  // e.g. "Breakfast", "Lunch", "Dinner", "Dessert", "Snacks", "Beverages"
    let preparationTime: Int // minutes
    let cookingTime: Int // minutes
    let difficulty: String // Easy, Medium, Hard
    let servings: Int
    let ingredients: [Ingredient]
    let steps: [CookingStep]
    let nutrition: Nutrition
    let rating: Double
    let reviews: Int
    let mode: HealthMode // Mode this recipe belongs to
}

struct Ingredient: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let quantity: String
    let unit: String
}

struct CookingStep: Codable, Identifiable, Hashable {
    let id: String
    let stepNumber: Int
    let instruction: String
    let image: String?
    let duration: Int? // seconds
}

struct Nutrition: Codable, Hashable {
    let calories: Int
    let protein: String
    let carbs: String
    let fat: String
    let fiber: String
}

struct Category: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let icon: String
}
