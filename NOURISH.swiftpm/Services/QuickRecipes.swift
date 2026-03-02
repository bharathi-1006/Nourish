import Foundation

// MARK: - Quick Recipe Model (1-Minute Recipes)

struct QuickRecipe: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let ingredients: [String]
    let steps: [String]  // Step-by-step instructions (pointwise)
    let prepTime: String
    let systemIcon: String  // SF Symbol name for clean Apple aesthetic
    let mode: HealthMode
    let nutrition: QuickRecipeNutrition
}

struct QuickRecipeNutrition: Codable {
    let calories: Int
    let protein: String
    let carbs: String
    let fat: String
}

// MARK: - Quick Recipes Data Provider

struct QuickRecipesProvider {
    static func recipes(for mode: HealthMode) -> [QuickRecipe] {
        switch mode {
        case .normal:
            return normalModeRecipes
        case .diabetic:
            return diabeticModeRecipes
        case .heartCare:
            return heartCareModeRecipes
        case .weightLoss:
            return weightLossModeRecipes
        case .weightGain:
            return weightGainModeRecipes
        }
    }
    
    // MARK: - Normal Mode Recipes
    
    private static let normalModeRecipes: [QuickRecipe] = [
        QuickRecipe(
            id: "quick_normal_1",
            title: "Quick Masala Omelette",
            description: "Simple, protein-rich breakfast",
            ingredients: ["2 Eggs", "1 Onion (chopped)", "1 Tomato (chopped)", "1 Green chili", "Salt & Pepper"],
            steps: [
                "Beat 2 eggs in a bowl with salt and pepper.",
                "Add chopped onion, tomato, and green chili to the egg mixture.",
                "Heat oil in a pan over medium heat.",
                "Pour the egg mixture into the hot pan.",
                "Cook for 2 minutes on each side until golden.",
                "Serve hot with bread or as is."
            ],
            prepTime: "5 mins",
            systemIcon: "takeoutbag.and.cup.and.straw.fill",
            mode: .normal,
            nutrition: QuickRecipeNutrition(calories: 180, protein: "14g", carbs: "6g", fat: "11g")
        ),
        QuickRecipe(
            id: "quick_normal_2",
            title: "Instant Curd Rice",
            description: "Cooling, comforting meal",
            ingredients: ["1 cup Cooked rice", "½ cup Curd", "¼ cup Cucumber (chopped)", "Curry leaves", "Mustard seeds"],
            steps: [
                "Mix cooked rice with fresh curd in a bowl.",
                "Add chopped cucumber and salt to taste.",
                "Heat oil in a small pan over medium heat.",
                "Add mustard seeds and curry leaves, let them splutter.",
                "Pour the tempering over the rice mixture.",
                "Mix well and serve chilled or at room temperature."
            ],
            prepTime: "3 mins",
            systemIcon: "leaf.fill",
            mode: .normal,
            nutrition: QuickRecipeNutrition(calories: 220, protein: "6g", carbs: "38g", fat: "4g")
        ),
        QuickRecipe(
            id: "quick_normal_3",
            title: "Quick Veggie Sandwich",
            description: "Fresh and filling",
            ingredients: ["4 Bread slices", "½ Cucumber (sliced)", "1 Tomato (sliced)", "2 tbsp Cheese", "Green chutney"],
            steps: [
                "Spread green chutney evenly on two bread slices.",
                "Layer cucumber and tomato slices on the chutney.",
                "Sprinkle grated cheese over the vegetables.",
                "Cover with the remaining bread slices.",
                "Optional: Grill in a sandwich maker for 2-3 minutes.",
                "Serve immediately while fresh."
            ],
            prepTime: "4 mins",
            systemIcon: "carrot.fill",
            mode: .normal,
            nutrition: QuickRecipeNutrition(calories: 240, protein: "9g", carbs: "32g", fat: "8g")
        ),
        QuickRecipe(
            id: "quick_normal_4",
            title: "Instant Maggi Noodles",
            description: "Quick comfort food",
            ingredients: ["1 pack Maggi", "2 cups Water", "Vegetables (optional)", "Maggi masala"],
            steps: [
                "Boil 2 cups of water in a pot.",
                "Add Maggi noodles to the boiling water.",
                "Add vegetables if using.",
                "Cook for 2 minutes, stirring occasionally.",
                "Add the masala pack and mix well.",
                "Serve hot in a bowl."
            ],
            prepTime: "3 mins",
            systemIcon: "flame.fill",
            mode: .normal,
            nutrition: QuickRecipeNutrition(calories: 310, protein: "8g", carbs: "52g", fat: "9g")
        ),
        QuickRecipe(
            id: "quick_normal_5",
            title: "Peanut Butter Toast",
            description: "Energy-packed snack",
            ingredients: ["2 Bread slices", "2 tbsp Peanut butter", "1 Banana (sliced)", "Honey (optional)"],
            steps: [
                "Toast the bread slices until golden brown.",
                "Spread peanut butter generously on both slices.",
                "Arrange banana slices evenly on top.",
                "Drizzle honey if desired for extra sweetness.",
                "Serve immediately for best taste."
            ],
            prepTime: "3 mins",
            systemIcon: "cup.and.saucer.fill",
            mode: .normal,
            nutrition: QuickRecipeNutrition(calories: 340, protein: "12g", carbs: "42g", fat: "14g")
        )
    ]
    
    // MARK: - Diabetic Mode Recipes
    
    private static let diabeticModeRecipes: [QuickRecipe] = [
        QuickRecipe(
            id: "quick_diabetic_1",
            title: "Methi Sprouts Salad",
            description: "Low GI, high fiber",
            ingredients: ["1 cup Sprouts (boiled)", "½ cup Methi leaves", "1 Lemon", "1 tsp Olive oil", "Black pepper"],
            steps: [
                "Boil sprouts until tender and drain well.",
                "Wash and chop fresh methi leaves finely.",
                "Mix sprouts and methi leaves in a bowl.",
                "Add lemon juice and olive oil.",
                "Season with salt and black pepper.",
                "Toss everything together and serve immediately."
            ],
            prepTime: "5 mins",
            systemIcon: "leaf.fill",
            mode: .diabetic,
            nutrition: QuickRecipeNutrition(calories: 120, protein: "9g", carbs: "15g", fat: "3g")
        ),
        QuickRecipe(
            id: "quick_diabetic_2",
            title: "Flaxseed Buttermilk",
            description: "Probiotic & omega-3 rich",
            ingredients: ["1 cup Buttermilk", "1 tbsp Roasted flaxseeds", "½ tsp Cumin powder", "Salt"],
            steps: [
                "Roast flaxseeds in a dry pan until fragrant.",
                "Grind the roasted flaxseeds into a fine powder.",
                "Add flaxseed powder to chilled buttermilk in a glass.",
                "Mix in cumin powder and salt to taste.",
                "Stir well until all ingredients are combined.",
                "Drink immediately for better digestion."
            ],
            prepTime: "2 mins",
            systemIcon: "drop.fill",
            mode: .diabetic,
            nutrition: QuickRecipeNutrition(calories: 90, protein: "5g", carbs: "8g", fat: "4g")
        ),
        QuickRecipe(
            id: "quick_diabetic_3",
            title: "Cucumber Raita Bowl",
            description: "Cooling, low-carb",
            ingredients: ["1 Cucumber (grated)", "1 cup Low-fat curd", "10 Mint leaves", "½ tsp Roasted cumin", "Salt"],
            steps: [
                "Grate cucumber and squeeze out excess water.",
                "Beat low-fat curd until smooth in a bowl.",
                "Mix the grated cucumber with the curd.",
                "Chop mint leaves finely and add to the mixture.",
                "Add roasted cumin powder and salt to taste.",
                "Chill for 2-3 minutes and serve as a refreshing side."
            ],
            prepTime: "4 mins",
            systemIcon: "drop.fill",
            mode: .diabetic,
            nutrition: QuickRecipeNutrition(calories: 80, protein: "6g", carbs: "10g", fat: "2g")
        ),
        QuickRecipe(
            id: "quick_diabetic_4",
            title: "Moong Dal Chilla",
            description: "Protein-rich, low GI",
            ingredients: ["½ cup Moong dal (soaked)", "1 Green chili", "Ginger", "Salt", "Oil"],
            steps: [
                "Soak moong dal for 2-3 hours or overnight.",
                "Drain and blend with green chili, ginger, and salt into a smooth batter.",
                "Heat a non-stick pan with minimal oil.",
                "Pour a ladle of batter and spread thin like a crepe.",
                "Cook for 2 minutes on each side until golden brown.",
                "Serve hot with mint chutney or curd."
            ],
            prepTime: "5 mins",
            systemIcon: "circle.grid.cross.fill",
            mode: .diabetic,
            nutrition: QuickRecipeNutrition(calories: 140, protein: "10g", carbs: "18g", fat: "3g")
        ),
        QuickRecipe(
            id: "quick_diabetic_5",
            title: "Cabbage Stir Fry",
            description: "Low-carb vegetable dish",
            ingredients: ["2 cups Cabbage (shredded)", "1 tsp Mustard seeds", "Curry leaves", "Turmeric", "Salt"],
            steps: [
                "Heat oil in a pan over medium-high heat.",
                "Add mustard seeds and let them splutter.",
                "Add curry leaves and sauté for a few seconds.",
                "Add shredded cabbage to the pan.",
                "Sprinkle turmeric powder and salt.",
                "Stir-fry on high heat for 3-4 minutes and serve."
            ],
            prepTime: "5 mins",
            systemIcon: "leaf.circle.fill",
            mode: .diabetic,
            nutrition: QuickRecipeNutrition(calories: 70, protein: "2g", carbs: "9g", fat: "3g")
        )
    ]
    
    // MARK: - Heart Care Mode Recipes
    
    private static let heartCareModeRecipes: [QuickRecipe] = [
        QuickRecipe(
            id: "quick_heart_1",
            title: "Oats & Berries Bowl",
            description: "Heart-healthy fiber boost",
            ingredients: ["½ cup Oats", "1 cup Almond milk", "¼ cup Mixed berries", "1 tbsp Walnuts", "Cinnamon"],
            steps: [
                "Heat almond milk in a microwave or on stove until warm.",
                "Soak oats in warm almond milk for 2-3 minutes.",
                "Top with fresh or frozen mixed berries.",
                "Add crushed walnuts for omega-3 fatty acids.",
                "Sprinkle cinnamon powder on top.",
                "Mix gently and serve immediately for a nutritious breakfast."
            ],
            prepTime: "3 mins",
            systemIcon: "heart.circle.fill",
            mode: .heartCare,
            nutrition: QuickRecipeNutrition(calories: 260, protein: "8g", carbs: "34g", fat: "10g")
        ),
        QuickRecipe(
            id: "quick_heart_2",
            title: "Tomato Basil Salad",
            description: "Antioxidant-rich",
            ingredients: ["2 Tomatoes (sliced)", "10 Fresh basil leaves", "1 tsp Olive oil", "1 Lemon", "Black pepper"],
            steps: [
                "Slice tomatoes evenly and arrange on a plate.",
                "Wash and tear fresh basil leaves by hand.",
                "Scatter basil leaves over the tomatoes.",
                "Drizzle extra virgin olive oil evenly.",
                "Squeeze fresh lemon juice on top.",
                "Season with freshly ground black pepper and serve."
            ],
            prepTime: "4 mins",
            systemIcon: "leaf.fill",
            mode: .heartCare,
            nutrition: QuickRecipeNutrition(calories: 90, protein: "2g", carbs: "10g", fat: "5g")
        ),
        QuickRecipe(
            id: "quick_heart_3",
            title: "Garlic Spinach Sauté",
            description: "Iron & heart-healthy fats",
            ingredients: ["2 cups Spinach", "3 Garlic cloves", "1 tsp Olive oil", "Lemon zest", "Pepper"],
            steps: [
                "Wash spinach thoroughly and drain excess water.",
                "Mince garlic cloves finely.",
                "Heat olive oil in a pan over medium heat.",
                "Add minced garlic and sauté for 30 seconds until fragrant.",
                "Add spinach and cook for 2 minutes until just wilted.",
                "Add lemon zest and black pepper, serve warm."
            ],
            prepTime: "5 mins",
            systemIcon: "circle.hexagongrid.fill",
            mode: .heartCare,
            nutrition: QuickRecipeNutrition(calories: 65, protein: "3g", carbs: "6g", fat: "4g")
        ),
        QuickRecipe(
            id: "quick_heart_4",
            title: "Avocado Toast",
            description: "Healthy fats for heart",
            ingredients: ["2 Whole grain bread", "1 Avocado", "Lemon juice", "Pepper", "Cherry tomatoes"],
            steps: [
                "Toast whole grain bread slices until golden.",
                "Mash ripe avocado in a bowl with lemon juice.",
                "Season mashed avocado with salt and black pepper.",
                "Spread the avocado mixture generously on toast.",
                "Top with halved cherry tomatoes.",
                "Serve immediately while toast is still warm."
            ],
            prepTime: "4 mins",
            systemIcon: "heart.fill",
            mode: .heartCare,
            nutrition: QuickRecipeNutrition(calories: 280, protein: "8g", carbs: "28g", fat: "16g")
        ),
        QuickRecipe(
            id: "quick_heart_5",
            title: "Quinoa Vegetable Mix",
            description: "Complete protein bowl",
            ingredients: ["1 cup Cooked quinoa", "½ cup Mixed vegetables", "Lemon", "Olive oil", "Herbs"],
            steps: [
                "Cook quinoa as per package instructions or use leftover quinoa.",
                "Steam or chop raw mixed vegetables (bell peppers, cucumber, carrots).",
                "Mix quinoa and vegetables in a bowl.",
                "Drizzle with olive oil and fresh lemon juice.",
                "Season with salt, pepper, and fresh herbs like parsley.",
                "Toss well and serve as a complete, balanced meal."
            ],
            prepTime: "5 mins",
            systemIcon: "circle.grid.3x3.fill",
            mode: .heartCare,
            nutrition: QuickRecipeNutrition(calories: 210, protein: "8g", carbs: "32g", fat: "6g")
        )
    ]
    
    // MARK: - Weight Loss Mode Recipes
    
    private static let weightLossModeRecipes: [QuickRecipe] = [
        QuickRecipe(
            id: "quick_wl_1",
            title: "Green Detox Smoothie",
            description: "Low-cal, nutrient-dense",
            ingredients: ["1 cup Spinach", "½ Cucumber", "1 Green apple", "½ Lemon juice", "5 Mint leaves"],
            steps: [
                "Wash all fresh ingredients thoroughly.",
                "Chop cucumber and green apple into small pieces.",
                "Add spinach, cucumber, apple, and mint leaves to a blender.",
                "Squeeze in fresh lemon juice.",
                "Add half cup of cold water.",
                "Blend until smooth and serve immediately without straining."
            ],
            prepTime: "3 mins",
            systemIcon: "drop.fill",
            mode: .weightLoss,
            nutrition: QuickRecipeNutrition(calories: 95, protein: "3g", carbs: "20g", fat: "0g")
        ),
        QuickRecipe(
            id: "quick_wl_2",
            title: "Cabbage Sprouts Salad",
            description: "Filling & low-calorie",
            ingredients: ["1 cup Cabbage (shredded)", "½ cup Sprouts", "1 Carrot (grated)", "Lemon", "Chat masala"],
            steps: [
                "Shred cabbage finely using a knife or grater.",
                "Grate carrot into thin strips.",
                "Boil sprouts for 2-3 minutes and drain.",
                "Mix cabbage, carrot, and sprouts in a bowl.",
                "Add fresh lemon juice, chat masala, and salt.",
                "Toss everything well and serve fresh as a crunchy snack."
            ],
            prepTime: "5 mins",
            systemIcon: "leaf.circle.fill",
            mode: .weightLoss,
            nutrition: QuickRecipeNutrition(calories: 85, protein: "5g", carbs: "16g", fat: "1g")
        ),
        QuickRecipe(
            id: "quick_wl_3",
            title: "Egg White Scramble",
            description: "High protein, low fat",
            ingredients: ["3 Egg whites", "½ cup Mushroom (chopped)", "¼ Bell pepper", "Pepper", "Herbs"],
            steps: [
                "Separate egg whites from yolks and whisk in a bowl.",
                "Chop mushrooms and bell pepper into small pieces.",
                "Heat a non-stick pan over medium heat (no oil needed).",
                "Pour whisked egg whites into the pan.",
                "Add mushrooms and bell pepper immediately.",
                "Scramble for 2-3 minutes, season with pepper and herbs, serve hot."
            ],
            prepTime: "4 mins",
            systemIcon: "circle.fill",
            mode: .weightLoss,
            nutrition: QuickRecipeNutrition(calories: 75, protein: "13g", carbs: "4g", fat: "0g")
        ),
        QuickRecipe(
            id: "quick_wl_4",
            title: "Cucumber Tomato Salad",
            description: "Hydrating & low-cal",
            ingredients: ["1 Cucumber", "2 Tomatoes", "1 Onion", "Lemon", "Salt"],
            steps: [
                "Wash cucumber, tomatoes, and onion thoroughly.",
                "Chop all vegetables into small, bite-sized pieces.",
                "Mix chopped vegetables in a bowl.",
                "Squeeze fresh lemon juice over the salad.",
                "Add salt to taste and toss well.",
                "Serve immediately as a refreshing, filling snack."
            ],
            prepTime: "3 mins",
            systemIcon: "drop.fill",
            mode: .weightLoss,
            nutrition: QuickRecipeNutrition(calories: 50, protein: "2g", carbs: "11g", fat: "0g")
        ),
        QuickRecipe(
            id: "quick_wl_5",
            title: "Lemon Mint Water",
            description: "Metabolism booster",
            ingredients: ["1 Lemon", "10 Mint leaves", "1 glass Water", "Black salt"],
            steps: [
                "Wash fresh mint leaves and lemon thoroughly.",
                "Squeeze juice from half the lemon into a glass of water.",
                "Add fresh mint leaves to the glass.",
                "Crush the mint leaves slightly to release flavor.",
                "Add a small pinch of black salt.",
                "Stir well and drink immediately for best results."
            ],
            prepTime: "2 mins",
            systemIcon: "drop.circle.fill",
            mode: .weightLoss,
            nutrition: QuickRecipeNutrition(calories: 10, protein: "0g", carbs: "3g", fat: "0g")
        )
    ]
    
    // MARK: - Weight Gain Mode Recipes
    
    private static let weightGainModeRecipes: [QuickRecipe] = [
        QuickRecipe(
            id: "quick_wg_1",
            title: "Banana Peanut Butter Shake",
            description: "High-calorie power drink",
            ingredients: ["2 Bananas", "2 tbsp Peanut butter", "1 cup Full-fat milk", "1 tbsp Honey", "2 tbsp Oats"],
            steps: [
                "Peel bananas and break into chunks.",
                "Add bananas, peanut butter, and oats to a blender.",
                "Pour in full-fat milk.",
                "Add honey for sweetness and extra calories.",
                "Blend on high speed until smooth and creamy.",
                "Pour into a large glass and drink immediately."
            ],
            prepTime: "3 mins",
            systemIcon: "cup.and.saucer.fill",
            mode: .weightGain,
            nutrition: QuickRecipeNutrition(calories: 520, protein: "16g", carbs: "68g", fat: "20g")
        ),
        QuickRecipe(
            id: "quick_wg_2",
            title: "Paneer Paratha Roll",
            description: "Protein & carb packed",
            ingredients: ["1 Paratha", "½ cup Paneer (crumbled)", "1 tsp Ghee", "1 Onion", "Spices"],
            steps: [
                "Heat a pan and add ghee.",
                "Warm paratha on the pan until crispy on both sides.",
                "In another pan, sauté chopped onion until golden.",
                "Add crumbled paneer and spices, cook for 2 minutes.",
                "Place the paneer filling in the center of the paratha.",
                "Roll tightly, apply extra ghee on top, and serve hot."
            ],
            prepTime: "5 mins",
            systemIcon: "takeoutbag.and.cup.and.straw.fill",
            mode: .weightGain,
            nutrition: QuickRecipeNutrition(calories: 420, protein: "18g", carbs: "42g", fat: "19g")
        ),
        QuickRecipe(
            id: "quick_wg_3",
            title: "Sweet Potato Mash",
            description: "Complex carbs & energy",
            ingredients: ["1 large Sweet potato", "1 tbsp Butter", "2 tbsp Milk", "½ tsp Cinnamon", "1 tsp Honey"],
            steps: [
                "Wash sweet potato and pierce with a fork.",
                "Microwave on high for 4-5 minutes until soft.",
                "Let cool slightly, then peel the skin.",
                "Mash the sweet potato with butter and milk.",
                "Add cinnamon powder and honey.",
                "Mix until creamy and serve warm as an energy-dense snack."
            ],
            prepTime: "5 mins",
            systemIcon: "flame.fill",
            mode: .weightGain,
            nutrition: QuickRecipeNutrition(calories: 280, protein: "4g", carbs: "48g", fat: "8g")
        ),
        QuickRecipe(
            id: "quick_wg_4",
            title: "Cheese Omelette",
            description: "High protein & fats",
            ingredients: ["3 Eggs", "¼ cup Cheese", "1 tbsp Butter", "Salt", "Pepper"],
            steps: [
                "Beat 3 eggs in a bowl with salt and pepper.",
                "Heat butter in a non-stick pan over medium heat.",
                "Pour beaten eggs into the pan.",
                "Cook for 1 minute until edges start to set.",
                "Add grated cheese on one half of the omelette.",
                "Fold the other half over the cheese, cook for another minute, serve hot."
            ],
            prepTime: "4 mins",
            systemIcon: "circle.hexagongrid.fill",
            mode: .weightGain,
            nutrition: QuickRecipeNutrition(calories: 380, protein: "24g", carbs: "2g", fat: "30g")
        ),
        QuickRecipe(
            id: "quick_wg_5",
            title: "Dry Fruit Smoothie",
            description: "Calorie-dense drink",
            ingredients: ["5 Dates", "10 Almonds", "5 Cashews", "1 cup Milk", "1 tbsp Honey"],
            steps: [
                "Soak dates, almonds, and cashews in warm water for 5 minutes.",
                "Drain and remove the pits from dates.",
                "Add soaked dry fruits to a blender.",
                "Pour in full-fat milk and honey.",
                "Blend on high until completely smooth.",
                "Pour into a glass and drink for high-calorie nutrition."
            ],
            prepTime: "5 mins",
            systemIcon: "drop.circle.fill",
            mode: .weightGain,
            nutrition: QuickRecipeNutrition(calories: 450, protein: "14g", carbs: "62g", fat: "16g")
        )
    ]
}
