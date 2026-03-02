import Foundation

// MARK: - Not Recommended Item Model

struct NotRecommendedItem: Identifiable, Codable {
    let id: String
    let name: String
    let reason: String
    let icon: String
    let category: NotRecommendedCategory
}

enum NotRecommendedCategory: String, Codable {
    case foods = "Foods"
    case ingredients = "Ingredients"
}

// MARK: - Not Recommended Data Provider

struct NotRecommendedProvider {
    static func items(for mode: HealthMode) -> [NotRecommendedItem] {
        switch mode {
        case .normal:
            return [] // Normal mode shows no restrictions
        case .diabetic:
            return diabeticModeItems
        case .heartCare:
            return heartCareModeItems
        case .weightLoss:
            return weightLossModeItems
        case .weightGain:
            return weightGainModeItems
        }
    }
    
    static func foods(for mode: HealthMode) -> [NotRecommendedItem] {
        items(for: mode).filter { $0.category == .foods }
    }
    
    static func ingredients(for mode: HealthMode) -> [NotRecommendedItem] {
        items(for: mode).filter { $0.category == .ingredients }
    }
    
    // MARK: - Diabetic Mode - Not Recommended
    
    private static let diabeticModeItems: [NotRecommendedItem] = [
        NotRecommendedItem(
            id: "ni_diabetic_1",
            name: "White Rice",
            reason: "High glycemic index causes rapid blood sugar spikes",
            icon: "🍚",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_diabetic_2",
            name: "White Bread",
            reason: "Refined carbs with low fiber content, high GI",
            icon: "🍞",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_diabetic_3",
            name: "Sugary Drinks",
            reason: "Direct sugar absorption with no fiber to slow digestion",
            icon: "🥤",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_diabetic_4",
            name: "Packaged Fruit Juices",
            reason: "High sugar content, no fiber, concentrated calories",
            icon: "🧃",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_diabetic_5",
            name: "Fried Foods",
            reason: "High calories and unhealthy fats can worsen insulin resistance",
            icon: "🍟",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_diabetic_6",
            name: "Pastries & Cakes",
            reason: "Refined flour and sugar combination spikes blood glucose",
            icon: "🧁",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_diabetic_7",
            name: "Candy & Sweets",
            reason: "Pure sugar causes immediate glucose spike",
            icon: "🍬",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_diabetic_8",
            name: "White Sugar",
            reason: "Rapid glucose spike with no nutritional value",
            icon: "🧂",
            category: .ingredients
        ),
        NotRecommendedItem(
            id: "ni_diabetic_9",
            name: "Honey",
            reason: "Still high in simple sugars and calories despite being natural",
            icon: "🍯",
            category: .ingredients
        ),
        NotRecommendedItem(
            id: "ni_diabetic_10",
            name: "Jaggery",
            reason: "High glycemic load despite being unrefined",
            icon: "🟫",
            category: .ingredients
        ),
        NotRecommendedItem(
            id: "ni_diabetic_11",
            name: "Potato",
            reason: "High starch content raises blood sugar quickly",
            icon: "🥔",
            category: .ingredients
        ),
        NotRecommendedItem(
            id: "ni_diabetic_12",
            name: "Maida (All-Purpose Flour)",
            reason: "Refined, high GI, virtually no fiber",
            icon: "🌾",
            category: .ingredients
        ),
        NotRecommendedItem(
            id: "ni_diabetic_13",
            name: "Corn Syrup",
            reason: "Extremely high in concentrated sugars",
            icon: "🫙",
            category: .ingredients
        )
    ]
    
    // MARK: - Heart Care Mode - Not Recommended
    
    private static let heartCareModeItems: [NotRecommendedItem] = [
        NotRecommendedItem(
            id: "ni_heart_1",
            name: "Fried Foods",
            reason: "High in trans fats that damage arteries and raise cholesterol",
            icon: "🍟",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_heart_2",
            name: "Processed Meats",
            reason: "Extremely high sodium and saturated fats",
            icon: "🥓",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_heart_3",
            name: "Fast Food",
            reason: "Excessive salt, unhealthy fats, and empty calories",
            icon: "🍔",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_heart_4",
            name: "Pastries & Cakes",
            reason: "Trans fats, refined sugars, and cholesterol",
            icon: "🍰",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_heart_5",
            name: "Red Meat (Frequent)",
            reason: "High saturated fat raises LDL cholesterol levels",
            icon: "🥩",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_heart_6",
            name: "Pizza",
            reason: "High in saturated fats, sodium, and refined carbs",
            icon: "🍕",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_heart_7",
            name: "Ice Cream",
            reason: "High in saturated fats and added sugars",
            icon: "🍦",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_heart_8",
            name: "Butter",
            reason: "High in saturated fat, raises LDL cholesterol",
            icon: "🧈",
            category: .ingredients
        ),
        NotRecommendedItem(
            id: "ni_heart_9",
            name: "Ghee (Excess)",
            reason: "Saturated fat can increase cholesterol levels",
            icon: "🫙",
            category: .ingredients
        ),
        NotRecommendedItem(
            id: "ni_heart_10",
            name: "Coconut Oil (Excess)",
            reason: "Very high in saturated fat content",
            icon: "🥥",
            category: .ingredients
        ),
        NotRecommendedItem(
            id: "ni_heart_11",
            name: "Excess Salt",
            reason: "Raises blood pressure and strains the heart",
            icon: "🧂",
            category: .ingredients
        ),
        NotRecommendedItem(
            id: "ni_heart_12",
            name: "Heavy Cream",
            reason: "Extremely high in saturated fats",
            icon: "🥛",
            category: .ingredients
        ),
        NotRecommendedItem(
            id: "ni_heart_13",
            name: "Lard",
            reason: "Animal fat high in saturated fatty acids",
            icon: "🫙",
            category: .ingredients
        )
    ]
    
    // MARK: - Weight Loss Mode - Not Recommended
    
    private static let weightLossModeItems: [NotRecommendedItem] = [
        NotRecommendedItem(
            id: "ni_wl_1",
            name: "Sugary Snacks",
            reason: "Empty calories with no satiety, causes sugar crashes",
            icon: "🍬",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_wl_2",
            name: "Chips & Fried Snacks",
            reason: "High calories, unhealthy fats, minimal nutrition",
            icon: "🍿",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_wl_3",
            name: "Ice Cream",
            reason: "High sugar and fat content, calorie-dense",
            icon: "🍦",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_wl_4",
            name: "Soft Drinks",
            reason: "Liquid calories with no nutrients or fiber",
            icon: "🥤",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_wl_5",
            name: "White Bread",
            reason: "Low fiber doesn't keep you full, causes hunger",
            icon: "🍞",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_wl_6",
            name: "Fast Food",
            reason: "Calorie-dense with poor nutritional value",
            icon: "🍔",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_wl_7",
            name: "Pastries",
            reason: "High in refined flour, sugar, and fats",
            icon: "🥐",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_wl_8",
            name: "Alcohol",
            reason: "Empty calories and increases appetite",
            icon: "🍺",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_wl_9",
            name: "Sweetened Cereals",
            reason: "High sugar, low protein, digests quickly",
            icon: "🥣",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_wl_10",
            name: "Refined Oil (Excess)",
            reason: "Calorie-dense with minimal nutritional benefit",
            icon: "🛢️",
            category: .ingredients
        ),
        NotRecommendedItem(
            id: "ni_wl_11",
            name: "Mayonnaise",
            reason: "Very high in calories and fats",
            icon: "🥫",
            category: .ingredients
        ),
        NotRecommendedItem(
            id: "ni_wl_12",
            name: "Cheese (Excess)",
            reason: "Calorie-dense with high fat content",
            icon: "🧀",
            category: .ingredients
        ),
        NotRecommendedItem(
            id: "ni_wl_13",
            name: "Butter",
            reason: "High calorie density, easy to over-consume",
            icon: "🧈",
            category: .ingredients
        )
    ]
    
    // MARK: - Weight Gain Mode - Not Recommended
    
    private static let weightGainModeItems: [NotRecommendedItem] = [
        NotRecommendedItem(
            id: "ni_wg_1",
            name: "Low-Calorie Salads (Only)",
            reason: "Insufficient calories for weight gain goals",
            icon: "🥗",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_wg_2",
            name: "Diet Sodas",
            reason: "Zero calories, doesn't support calorie surplus",
            icon: "🥤",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_wg_3",
            name: "Rice Cakes",
            reason: "Very low calories and minimal nutrition",
            icon: "🍘",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_wg_4",
            name: "Plain Black Coffee (Excess)",
            reason: "Acts as appetite suppressant, reduces calorie intake",
            icon: "☕",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_wg_5",
            name: "Water-Based Soups (Only)",
            reason: "High volume but low calories, fills stomach unnecessarily",
            icon: "🍲",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_wg_6",
            name: "Plain Vegetables (Only)",
            reason: "Too low in calories for weight gain",
            icon: "🥦",
            category: .foods
        ),
        NotRecommendedItem(
            id: "ni_wg_7",
            name: "Artificial Sweeteners",
            reason: "Zero calories, doesn't help achieve calorie surplus",
            icon: "🧪",
            category: .ingredients
        ),
        NotRecommendedItem(
            id: "ni_wg_8",
            name: "Low-Fat Products",
            reason: "Lower calorie density than full-fat versions",
            icon: "🥛",
            category: .ingredients
        ),
        NotRecommendedItem(
            id: "ni_wg_9",
            name: "Excessive Fiber Supplements",
            reason: "Increases satiety, makes it harder to eat enough calories",
            icon: "💊",
            category: .ingredients
        )
    ]
}
