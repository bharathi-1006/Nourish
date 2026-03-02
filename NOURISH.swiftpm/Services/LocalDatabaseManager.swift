import Foundation

class LocalDatabaseManager: ObservableObject {
    @Published var recipes: [Recipe] = [] {
        didSet { _recipeIndex = nil }
    }
    @Published var categories: [Category] = []
    @Published var favorites: [FavoriteRecipe] = []
    @Published var shoppingList: [ShoppingListItem] = []
    @Published var mealPlan: [MealPlanItem] = []
    /// IDs of recipes created by the user — stored separately so the Recipe model is unchanged
    @Published var customRecipeIds: Set<String> = []
    // MARK: Fixed Plan Template
    @Published var fixedPlan: [FixedPlanEntry] = []

    // MARK: - O(1) Recipe Lookup
    private var _recipeIndex: [String: Recipe]?
    var recipeIndex: [String: Recipe] {
        if let cached = _recipeIndex { return cached }
        let idx = Dictionary(uniqueKeysWithValues: recipes.map { ($0.id, $0) })
        _recipeIndex = idx
        return idx
    }

    private let recipesKey = "recipes"
    private let categoriesKey = "categories"
    private let favoritesKey = "favorites"
    private let shoppingListKey = "shoppingList"
    private let mealPlanKey = "mealPlan"
    private let customRecipeIdsKey = "customRecipeIds"
    private let fixedPlanKey = "fixedPlan"
    
    init() {
        loadLocalData()
    }
    
    // MARK: - Load Sample Data
    private func loadLocalData() {
        // Version bump → forces fresh sample data when the schema changes
        let dataVersion = "v10_extra_health_recipes"
        if UserDefaults.standard.string(forKey: "dataVersion") != dataVersion {
            loadSampleRecipes()
            loadHealthModeRecipes() // Load health mode specific recipes
            loadExpandedRecipes() // Load expanded mode-specific recipes
            loadMassiveRecipeExpansion() // Load 150+ new recipes across all modes
            loadExtraHealthRecipes() // Load extra affordable health mode recipes
            loadSampleCategories()
            loadDemoData()
            UserDefaults.standard.set(dataVersion, forKey: "dataVersion")
        } else {
            loadFromUserDefaults()
        }
    }
    
    private func loadSampleRecipes() {
        let sampleRecipes = [
            // MARK: - Normal Mode Recipes
            Recipe(
                id: "1",
                title: "Classic Margherita Pizza",
                description: "Traditional Italian pizza with fresh mozzarella and basil",
                heroImage: "circle.hexagongrid.circle.fill",
                cuisine: "Italian",
                diet: "Vegetarian",
                category: "Dinner",
                preparationTime: 30,
                cookingTime: 20,
                difficulty: "Medium",
                servings: 4,
                ingredients: [
                    Ingredient(id: "1", name: "Pizza Dough", quantity: "500", unit: "g"),
                    Ingredient(id: "2", name: "Tomato Sauce", quantity: "200", unit: "ml"),
                    Ingredient(id: "3", name: "Mozzarella", quantity: "300", unit: "g"),
                    Ingredient(id: "4", name: "Fresh Basil", quantity: "1", unit: "bunch")
                ],
                steps: [
                    CookingStep(id: "1", stepNumber: 1, instruction: "Preheat oven to 220°C", image: nil, duration: 600),
                    CookingStep(id: "2", stepNumber: 2, instruction: "Roll out pizza dough on floured surface", image: nil, duration: 300),
                    CookingStep(id: "3", stepNumber: 3, instruction: "Spread tomato sauce evenly", image: nil, duration: 120),
                    CookingStep(id: "4", stepNumber: 4, instruction: "Add mozzarella cheese", image: nil, duration: 120),
                    CookingStep(id: "5", stepNumber: 5, instruction: "Bake for 20 minutes until crust is golden", image: nil, duration: 1200),
                    CookingStep(id: "6", stepNumber: 6, instruction: "Top with fresh basil and serve", image: nil, duration: 60)
                ],
                nutrition: Nutrition(calories: 285, protein: "12g", carbs: "35g", fat: "8g", fiber: "2g"),
                rating: 4.8,
                reviews: 245,
                mode: .normal
            ),
            Recipe(
                id: "2",
                title: "Grilled Salmon with Lemon",
                description: "Healthy grilled salmon fillet with fresh lemon and herbs",
                heroImage: "fish.fill",
                cuisine: "Mediterranean",
                diet: "Gluten-Free",
                category: "Dinner",
                preparationTime: 15,
                cookingTime: 15,
                difficulty: "Easy",
                servings: 2,
                ingredients: [
                    Ingredient(id: "1", name: "Salmon Fillet", quantity: "400", unit: "g"),
                    Ingredient(id: "2", name: "Lemon", quantity: "2", unit: "pcs"),
                    Ingredient(id: "3", name: "Olive Oil", quantity: "3", unit: "tbsp"),
                    Ingredient(id: "4", name: "Fresh Dill", quantity: "1", unit: "tbsp")
                ],
                steps: [
                    CookingStep(id: "1", stepNumber: 1, instruction: "Preheat grill to medium-high heat", image: nil, duration: 300),
                    CookingStep(id: "2", stepNumber: 2, instruction: "Pat salmon dry and brush with olive oil", image: nil, duration: 120),
                    CookingStep(id: "3", stepNumber: 3, instruction: "Season with salt, pepper, and dill", image: nil, duration: 120),
                    CookingStep(id: "4", stepNumber: 4, instruction: "Grill for 6-7 minutes per side", image: nil, duration: 840),
                    CookingStep(id: "5", stepNumber: 5, instruction: "Squeeze fresh lemon juice and serve", image: nil, duration: 120)
                ],
                nutrition: Nutrition(calories: 320, protein: "35g", carbs: "2g", fat: "18g", fiber: "0g"),
                rating: 4.9,
                reviews: 189,
                mode: .normal
            ),
            Recipe(
                id: "3",
                title: "Buddha Bowl",
                description: "Colorful vegan Buddha bowl with quinoa and roasted vegetables",
                heroImage: "leaf.fill",
                cuisine: "International",
                diet: "Vegan",
                category: "Lunch",
                preparationTime: 20,
                cookingTime: 25,
                difficulty: "Easy",
                servings: 1,
                ingredients: [
                    Ingredient(id: "1", name: "Quinoa", quantity: "100", unit: "g"),
                    Ingredient(id: "2", name: "Chickpeas", quantity: "200", unit: "g"),
                    Ingredient(id: "3", name: "Broccoli", quantity: "200", unit: "g"),
                    Ingredient(id: "4", name: "Sweet Potato", quantity: "150", unit: "g"),
                    Ingredient(id: "5", name: "Avocado", quantity: "1", unit: "pcs")
                ],
                steps: [
                    CookingStep(id: "1", stepNumber: 1, instruction: "Cook quinoa according to package instructions", image: nil, duration: 900),
                    CookingStep(id: "2", stepNumber: 2, instruction: "Chop vegetables into bite-sized pieces", image: nil, duration: 300),
                    CookingStep(id: "3", stepNumber: 3, instruction: "Roast in oven at 200°C for 25 minutes", image: nil, duration: 1500),
                    CookingStep(id: "4", stepNumber: 4, instruction: "Arrange in bowl with quinoa and chickpeas", image: nil, duration: 300),
                    CookingStep(id: "5", stepNumber: 5, instruction: "Top with fresh avocado and serve", image: nil, duration: 120)
                ],
                nutrition: Nutrition(calories: 450, protein: "18g", carbs: "62g", fat: "12g", fiber: "15g"),
                rating: 4.7,
                reviews: 312,
                mode: .normal
            ),
            Recipe(
                id: "4",
                title: "Chocolate Chip Cookies",
                description: "Classic soft and chewy chocolate chip cookies",
                heroImage: "birthday.cake.fill",
                cuisine: "American",
                diet: "Vegetarian",
                category: "Dessert",
                preparationTime: 15,
                cookingTime: 12,
                difficulty: "Easy",
                servings: 24,
                ingredients: [
                    Ingredient(id: "1", name: "Butter", quantity: "200", unit: "g"),
                    Ingredient(id: "2", name: "Sugar", quantity: "150", unit: "g"),
                    Ingredient(id: "3", name: "Brown Sugar", quantity: "150", unit: "g"),
                    Ingredient(id: "4", name: "Eggs", quantity: "2", unit: "pcs"),
                    Ingredient(id: "5", name: "Flour", quantity: "280", unit: "g"),
                    Ingredient(id: "6", name: "Chocolate Chips", quantity: "300", unit: "g")
                ],
                steps: [
                    CookingStep(id: "1", stepNumber: 1, instruction: "Preheat oven to 190°C", image: nil, duration: 300),
                    CookingStep(id: "2", stepNumber: 2, instruction: "Cream butter and sugars", image: nil, duration: 180),
                    CookingStep(id: "3", stepNumber: 3, instruction: "Beat in eggs one at a time", image: nil, duration: 120),
                    CookingStep(id: "4", stepNumber: 4, instruction: "Mix in flour gradually", image: nil, duration: 180),
                    CookingStep(id: "5", stepNumber: 5, instruction: "Fold in chocolate chips", image: nil, duration: 120),
                    CookingStep(id: "6", stepNumber: 6, instruction: "Drop onto baking sheet and bake 12 minutes", image: nil, duration: 720)
                ],
                nutrition: Nutrition(calories: 180, protein: "2g", carbs: "24g", fat: "9g", fiber: "0g"),
                rating: 4.9,
                reviews: 1205,
                mode: .normal
            ),
            Recipe(
                id: "5",
                title: "Fluffy Pancakes",
                description: "Light and airy pancakes with maple syrup and fresh berries",
                heroImage: "sunrise.fill",
                cuisine: "American",
                diet: "Vegetarian",
                category: "Breakfast",
                preparationTime: 10,
                cookingTime: 20,
                difficulty: "Easy",
                servings: 4,
                ingredients: [
                    Ingredient(id: "1", name: "All-Purpose Flour", quantity: "200", unit: "g"),
                    Ingredient(id: "2", name: "Milk", quantity: "250", unit: "ml"),
                    Ingredient(id: "3", name: "Eggs", quantity: "2", unit: "pcs"),
                    Ingredient(id: "4", name: "Baking Powder", quantity: "2", unit: "tsp"),
                    Ingredient(id: "5", name: "Maple Syrup", quantity: "4", unit: "tbsp")
                ],
                steps: [
                    CookingStep(id: "1", stepNumber: 1, instruction: "Mix dry ingredients in a bowl", image: nil, duration: 120),
                    CookingStep(id: "2", stepNumber: 2, instruction: "Whisk wet ingredients separately", image: nil, duration: 120),
                    CookingStep(id: "3", stepNumber: 3, instruction: "Combine wet and dry, don't overmix", image: nil, duration: 60),
                    CookingStep(id: "4", stepNumber: 4, instruction: "Cook on buttered skillet, 2 min per side", image: nil, duration: 240),
                    CookingStep(id: "5", stepNumber: 5, instruction: "Serve with maple syrup and berries", image: nil, duration: 60)
                ],
                nutrition: Nutrition(calories: 220, protein: "7g", carbs: "38g", fat: "5g", fiber: "1g"),
                rating: 4.7,
                reviews: 892,
                mode: .normal
            ),
            Recipe(
                id: "6",
                title: "Avocado Toast",
                description: "Creamy smashed avocado on toasted sourdough with a poached egg",
                heroImage: "leaf.fill",
                cuisine: "Modern",
                diet: "Vegetarian",
                category: "Breakfast",
                preparationTime: 5,
                cookingTime: 10,
                difficulty: "Easy",
                servings: 1,
                ingredients: [
                    Ingredient(id: "1", name: "Sourdough Bread", quantity: "2", unit: "pcs"),
                    Ingredient(id: "2", name: "Avocado", quantity: "1", unit: "pcs"),
                    Ingredient(id: "3", name: "Egg", quantity: "1", unit: "pcs"),
                    Ingredient(id: "4", name: "Lemon Juice", quantity: "1", unit: "tsp"),
                    Ingredient(id: "5", name: "Red Chili Flakes", quantity: "1", unit: "pinch")
                ],
                steps: [
                    CookingStep(id: "1", stepNumber: 1, instruction: "Toast sourdough bread until golden", image: nil, duration: 180),
                    CookingStep(id: "2", stepNumber: 2, instruction: "Mash avocado with lemon, salt, and pepper", image: nil, duration: 60),
                    CookingStep(id: "3", stepNumber: 3, instruction: "Poach egg in simmering water for 3 minutes", image: nil, duration: 180),
                    CookingStep(id: "4", stepNumber: 4, instruction: "Spread avocado on toast, top with egg", image: nil, duration: 60),
                    CookingStep(id: "5", stepNumber: 5, instruction: "Sprinkle chili flakes and serve", image: nil, duration: 30)
                ],
                nutrition: Nutrition(calories: 310, protein: "12g", carbs: "28g", fat: "18g", fiber: "8g"),
                rating: 4.8,
                reviews: 654,
                mode: .normal
            ),
            Recipe(
                id: "7",
                title: "Greek Yogurt Parfait",
                description: "Layered yogurt with granola, honey, and seasonal fruits",
                heroImage: "cup.and.saucer.fill",
                cuisine: "Mediterranean",
                diet: "Gluten-Free",
                category: "Breakfast",
                preparationTime: 5,
                cookingTime: 0,
                difficulty: "Easy",
                servings: 1,
                ingredients: [
                    Ingredient(id: "1", name: "Greek Yogurt", quantity: "200", unit: "g"),
                    Ingredient(id: "2", name: "Granola", quantity: "50", unit: "g"),
                    Ingredient(id: "3", name: "Mixed Berries", quantity: "100", unit: "g"),
                    Ingredient(id: "4", name: "Honey", quantity: "2", unit: "tbsp")
                ],
                steps: [
                    CookingStep(id: "1", stepNumber: 1, instruction: "Spoon half the yogurt into a glass", image: nil, duration: 30),
                    CookingStep(id: "2", stepNumber: 2, instruction: "Add a layer of granola", image: nil, duration: 30),
                    CookingStep(id: "3", stepNumber: 3, instruction: "Add a layer of fresh berries", image: nil, duration: 30),
                    CookingStep(id: "4", stepNumber: 4, instruction: "Repeat layers and drizzle honey on top", image: nil, duration: 30)
                ],
                nutrition: Nutrition(calories: 290, protein: "15g", carbs: "42g", fat: "6g", fiber: "4g"),
                rating: 4.6,
                reviews: 421,
                mode: .normal
            ),
            // MARK: - Lunch recipes
            Recipe(
                id: "8",
                title: "Caesar Salad",
                description: "Crisp romaine lettuce with Caesar dressing, croutons and parmesan",
                heroImage: "leaf.fill",
                cuisine: "American",
                diet: "Vegetarian",
                category: "Lunch",
                preparationTime: 15,
                cookingTime: 10,
                difficulty: "Easy",
                servings: 2,
                ingredients: [
                    Ingredient(id: "1", name: "Romaine Lettuce", quantity: "1", unit: "pcs"),
                    Ingredient(id: "2", name: "Parmesan", quantity: "50", unit: "g"),
                    Ingredient(id: "3", name: "Croutons", quantity: "100", unit: "g"),
                    Ingredient(id: "4", name: "Caesar Dressing", quantity: "4", unit: "tbsp"),
                    Ingredient(id: "5", name: "Lemon", quantity: "1", unit: "pcs")
                ],
                steps: [
                    CookingStep(id: "1", stepNumber: 1, instruction: "Wash and chop romaine lettuce", image: nil, duration: 180),
                    CookingStep(id: "2", stepNumber: 2, instruction: "Toast bread cubes in oven for croutons", image: nil, duration: 600),
                    CookingStep(id: "3", stepNumber: 3, instruction: "Toss lettuce with Caesar dressing", image: nil, duration: 60),
                    CookingStep(id: "4", stepNumber: 4, instruction: "Top with parmesan, croutons, and lemon", image: nil, duration: 60)
                ],
                nutrition: Nutrition(calories: 320, protein: "10g", carbs: "22g", fat: "22g", fiber: "3g"),
                rating: 4.5,
                reviews: 567,
                mode: .normal
            ),
            Recipe(
                id: "9",
                title: "Chicken Wrap",
                description: "Grilled chicken with fresh veggies and tzatziki in a warm tortilla",
                heroImage: "fork.knife.circle.fill",
                cuisine: "Mediterranean",
                diet: "Gluten-Free",
                category: "Lunch",
                preparationTime: 15,
                cookingTime: 15,
                difficulty: "Easy",
                servings: 2,
                ingredients: [
                    Ingredient(id: "1", name: "Chicken Breast", quantity: "300", unit: "g"),
                    Ingredient(id: "2", name: "Tortilla Wrap", quantity: "2", unit: "pcs"),
                    Ingredient(id: "3", name: "Tzatziki", quantity: "4", unit: "tbsp"),
                    Ingredient(id: "4", name: "Mixed Greens", quantity: "60", unit: "g"),
                    Ingredient(id: "5", name: "Cherry Tomatoes", quantity: "100", unit: "g")
                ],
                steps: [
                    CookingStep(id: "1", stepNumber: 1, instruction: "Season and grill chicken until cooked through", image: nil, duration: 900),
                    CookingStep(id: "2", stepNumber: 2, instruction: "Slice chicken and prepare vegetables", image: nil, duration: 180),
                    CookingStep(id: "3", stepNumber: 3, instruction: "Warm tortilla on skillet for 1 minute", image: nil, duration: 60),
                    CookingStep(id: "4", stepNumber: 4, instruction: "Spread tzatziki, layer greens and chicken", image: nil, duration: 60),
                    CookingStep(id: "5", stepNumber: 5, instruction: "Roll tightly and slice in half to serve", image: nil, duration: 60)
                ],
                nutrition: Nutrition(calories: 410, protein: "38g", carbs: "30g", fat: "12g", fiber: "4g"),
                rating: 4.7,
                reviews: 389,
                mode: .normal
            ),
            // MARK: - Dinner recipes
            Recipe(
                id: "10",
                title: "Beef Stir Fry",
                description: "Tender beef strips with colorful vegetables in a savory soy sauce",
                heroImage: "flame.fill",
                cuisine: "Asian",
                diet: "Gluten-Free",
                category: "Dinner",
                preparationTime: 20,
                cookingTime: 15,
                difficulty: "Medium",
                servings: 3,
                ingredients: [
                    Ingredient(id: "1", name: "Beef Sirloin", quantity: "400", unit: "g"),
                    Ingredient(id: "2", name: "Bell Peppers", quantity: "2", unit: "pcs"),
                    Ingredient(id: "3", name: "Soy Sauce", quantity: "3", unit: "tbsp"),
                    Ingredient(id: "4", name: "Garlic", quantity: "3", unit: "cloves"),
                    Ingredient(id: "5", name: "Ginger", quantity: "1", unit: "tbsp"),
                    Ingredient(id: "6", name: "Sesame Oil", quantity: "1", unit: "tbsp")
                ],
                steps: [
                    CookingStep(id: "1", stepNumber: 1, instruction: "Slice beef thinly against the grain", image: nil, duration: 300),
                    CookingStep(id: "2", stepNumber: 2, instruction: "Marinate with soy sauce and cornstarch for 15 min", image: nil, duration: 900),
                    CookingStep(id: "3", stepNumber: 3, instruction: "Stir-fry beef in hot wok for 3 minutes", image: nil, duration: 180),
                    CookingStep(id: "4", stepNumber: 4, instruction: "Add garlic, ginger, and vegetables", image: nil, duration: 300),
                    CookingStep(id: "5", stepNumber: 5, instruction: "Add sauce, toss and serve over rice", image: nil, duration: 120)
                ],
                nutrition: Nutrition(calories: 380, protein: "32g", carbs: "18g", fat: "20g", fiber: "3g"),
                rating: 4.6,
                reviews: 478,
                mode: .normal
            ),
            // MARK: - Dessert recipes
            Recipe(
                id: "11",
                title: "Tiramisu",
                description: "Classic Italian dessert with espresso-soaked ladyfingers and mascarpone cream",
                heroImage: "birthday.cake.fill",
                cuisine: "Italian",
                diet: "Vegetarian",
                category: "Dessert",
                preparationTime: 30,
                cookingTime: 0,
                difficulty: "Medium",
                servings: 8,
                ingredients: [
                    Ingredient(id: "1", name: "Mascarpone", quantity: "500", unit: "g"),
                    Ingredient(id: "2", name: "Ladyfinger Biscuits", quantity: "300", unit: "g"),
                    Ingredient(id: "3", name: "Espresso", quantity: "200", unit: "ml"),
                    Ingredient(id: "4", name: "Eggs", quantity: "4", unit: "pcs"),
                    Ingredient(id: "5", name: "Sugar", quantity: "100", unit: "g"),
                    Ingredient(id: "6", name: "Cocoa Powder", quantity: "3", unit: "tbsp")
                ],
                steps: [
                    CookingStep(id: "1", stepNumber: 1, instruction: "Whisk egg yolks with sugar until pale", image: nil, duration: 300),
                    CookingStep(id: "2", stepNumber: 2, instruction: "Fold mascarpone into egg mixture", image: nil, duration: 180),
                    CookingStep(id: "3", stepNumber: 3, instruction: "Whip egg whites to stiff peaks and fold in", image: nil, duration: 300),
                    CookingStep(id: "4", stepNumber: 4, instruction: "Dip ladyfingers in espresso and layer in dish", image: nil, duration: 300),
                    CookingStep(id: "5", stepNumber: 5, instruction: "Spread cream, repeat layers, chill 4 hours", image: nil, duration: 14400),
                    CookingStep(id: "6", stepNumber: 6, instruction: "Dust with cocoa powder before serving", image: nil, duration: 60)
                ],
                nutrition: Nutrition(calories: 380, protein: "8g", carbs: "32g", fat: "24g", fiber: "0g"),
                rating: 4.9,
                reviews: 2103,
                mode: .normal
            ),
            Recipe(
                id: "12",
                title: "Mango Sorbet",
                description: "Refreshing dairy-free mango sorbet with a hint of lime",
                heroImage: "snowflake",
                cuisine: "International",
                diet: "Vegan",
                category: "Dessert",
                preparationTime: 10,
                cookingTime: 0,
                difficulty: "Easy",
                servings: 4,
                ingredients: [
                    Ingredient(id: "1", name: "Frozen Mango", quantity: "500", unit: "g"),
                    Ingredient(id: "2", name: "Lime Juice", quantity: "2", unit: "tbsp"),
                    Ingredient(id: "3", name: "Honey", quantity: "2", unit: "tbsp"),
                    Ingredient(id: "4", name: "Coconut Water", quantity: "60", unit: "ml")
                ],
                steps: [
                    CookingStep(id: "1", stepNumber: 1, instruction: "Let frozen mango sit for 5 minutes", image: nil, duration: 300),
                    CookingStep(id: "2", stepNumber: 2, instruction: "Blend all ingredients until smooth", image: nil, duration: 120),
                    CookingStep(id: "3", stepNumber: 3, instruction: "Pour into freezer container and freeze 2 hours", image: nil, duration: 7200),
                    CookingStep(id: "4", stepNumber: 4, instruction: "Scoop into bowls and serve immediately", image: nil, duration: 60)
                ],
                nutrition: Nutrition(calories: 120, protein: "1g", carbs: "30g", fat: "0g", fiber: "2g"),
                rating: 4.5,
                reviews: 298,
                mode: .normal
            ),
            // MARK: - Snacks
            Recipe(
                id: "13",
                title: "Hummus & Veggie Sticks",
                description: "Smooth homemade hummus with colorful crunchy vegetable sticks",
                heroImage: "carrot.fill",
                cuisine: "Middle Eastern",
                diet: "Vegan",
                category: "Snacks",
                preparationTime: 10,
                cookingTime: 0,
                difficulty: "Easy",
                servings: 4,
                ingredients: [
                    Ingredient(id: "1", name: "Canned Chickpeas", quantity: "400", unit: "g"),
                    Ingredient(id: "2", name: "Tahini", quantity: "3", unit: "tbsp"),
                    Ingredient(id: "3", name: "Lemon Juice", quantity: "2", unit: "tbsp"),
                    Ingredient(id: "4", name: "Garlic", quantity: "2", unit: "cloves"),
                    Ingredient(id: "5", name: "Carrots & Celery", quantity: "300", unit: "g")
                ],
                steps: [
                    CookingStep(id: "1", stepNumber: 1, instruction: "Drain and rinse chickpeas", image: nil, duration: 60),
                    CookingStep(id: "2", stepNumber: 2, instruction: "Blend chickpeas, tahini, lemon, garlic", image: nil, duration: 120),
                    CookingStep(id: "3", stepNumber: 3, instruction: "Add olive oil and blend until smooth", image: nil, duration: 60),
                    CookingStep(id: "4", stepNumber: 4, instruction: "Cut vegetables into sticks and serve", image: nil, duration: 180)
                ],
                nutrition: Nutrition(calories: 180, protein: "8g", carbs: "22g", fat: "8g", fiber: "6g"),
                rating: 4.6,
                reviews: 512,
                mode: .normal
            ),
            Recipe(
                id: "14",
                title: "Trail Mix Energy Bites",
                description: "No-bake energy balls packed with oats, nut butter, and dark chocolate",
                heroImage: "circle.grid.2x2.fill",
                cuisine: "American",
                diet: "Vegan",
                category: "Snacks",
                preparationTime: 15,
                cookingTime: 0,
                difficulty: "Easy",
                servings: 12,
                ingredients: [
                    Ingredient(id: "1", name: "Rolled Oats", quantity: "200", unit: "g"),
                    Ingredient(id: "2", name: "Peanut Butter", quantity: "100", unit: "g"),
                    Ingredient(id: "3", name: "Honey", quantity: "60", unit: "ml"),
                    Ingredient(id: "4", name: "Dark Chocolate Chips", quantity: "80", unit: "g"),
                    Ingredient(id: "5", name: "Chia Seeds", quantity: "2", unit: "tbsp")
                ],
                steps: [
                    CookingStep(id: "1", stepNumber: 1, instruction: "Mix all ingredients in a large bowl", image: nil, duration: 120),
                    CookingStep(id: "2", stepNumber: 2, instruction: "Refrigerate mixture for 30 minutes", image: nil, duration: 1800),
                    CookingStep(id: "3", stepNumber: 3, instruction: "Roll into 1-inch balls with your hands", image: nil, duration: 300),
                    CookingStep(id: "4", stepNumber: 4, instruction: "Store in fridge up to 1 week", image: nil, duration: 60)
                ],
                nutrition: Nutrition(calories: 150, protein: "5g", carbs: "18g", fat: "7g", fiber: "2g"),
                rating: 4.7,
                reviews: 763,
                mode: .normal
            ),
            // MARK: - Beverages
            Recipe(
                id: "15",
                title: "Mango Lassi",
                description: "Creamy Indian yogurt-based mango drink with cardamom",
                heroImage: "cup.and.saucer.fill",
                cuisine: "Indian",
                diet: "Vegetarian",
                category: "Beverages",
                preparationTime: 5,
                cookingTime: 0,
                difficulty: "Easy",
                servings: 2,
                ingredients: [
                    Ingredient(id: "1", name: "Mango Pulp", quantity: "200", unit: "ml"),
                    Ingredient(id: "2", name: "Plain Yogurt", quantity: "200", unit: "g"),
                    Ingredient(id: "3", name: "Milk", quantity: "100", unit: "ml"),
                    Ingredient(id: "4", name: "Cardamom Powder", quantity: "0.5", unit: "tsp"),
                    Ingredient(id: "5", name: "Sugar", quantity: "2", unit: "tbsp")
                ],
                steps: [
                    CookingStep(id: "1", stepNumber: 1, instruction: "Add all ingredients to a blender", image: nil, duration: 60),
                    CookingStep(id: "2", stepNumber: 2, instruction: "Blend on high until smooth and frothy", image: nil, duration: 60),
                    CookingStep(id: "3", stepNumber: 3, instruction: "Taste and adjust sweetness if needed", image: nil, duration: 30),
                    CookingStep(id: "4", stepNumber: 4, instruction: "Pour over ice and serve chilled", image: nil, duration: 30)
                ],
                nutrition: Nutrition(calories: 210, protein: "7g", carbs: "38g", fat: "4g", fiber: "1g"),
                rating: 4.8,
                reviews: 634,
                mode: .normal
            ),
            Recipe(
                id: "16",
                title: "Green Detox Smoothie",
                description: "Energizing green smoothie with spinach, banana, and ginger",
                heroImage: "leaf.circle.fill",
                cuisine: "International",
                diet: "Vegan",
                category: "Beverages",
                preparationTime: 5,
                cookingTime: 0,
                difficulty: "Easy",
                servings: 1,
                ingredients: [
                    Ingredient(id: "1", name: "Baby Spinach", quantity: "60", unit: "g"),
                    Ingredient(id: "2", name: "Banana", quantity: "1", unit: "pcs"),
                    Ingredient(id: "3", name: "Green Apple", quantity: "1", unit: "pcs"),
                    Ingredient(id: "4", name: "Fresh Ginger", quantity: "1", unit: "tsp"),
                    Ingredient(id: "5", name: "Coconut Water", quantity: "200", unit: "ml")
                ],
                steps: [
                    CookingStep(id: "1", stepNumber: 1, instruction: "Wash and roughly chop all produce", image: nil, duration: 120),
                    CookingStep(id: "2", stepNumber: 2, instruction: "Add coconut water to blender first", image: nil, duration: 30),
                    CookingStep(id: "3", stepNumber: 3, instruction: "Add remaining ingredients and blend smooth", image: nil, duration: 60),
                    CookingStep(id: "4", stepNumber: 4, instruction: "Pour into a glass and enjoy immediately", image: nil, duration: 30)
                ],
                nutrition: Nutrition(calories: 160, protein: "3g", carbs: "36g", fat: "1g", fiber: "5g"),
                rating: 4.4,
                reviews: 289,
                mode: .normal
            )
        ]
        
        recipes = sampleRecipes
        saveRecipes()
    }
    
    // MARK: - Demo Data for Reviewer Experience
    private func loadDemoData() {
        // ── 2 New Recipes ──────────────────────────────────────────────────────
        let demoRecipe1 = Recipe(
            id: "demo_r1",
            title: "Avocado Toast with Poached Egg",
            description: "A trendy brunch staple — creamy avocado on sourdough topped with a perfectly poached egg and chilli flakes.",
            heroImage: "leaf.fill",
            cuisine: "Modern Australian",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 10,
            cookingTime: 8,
            difficulty: "Easy",
            servings: 1,
            ingredients: [
                Ingredient(id: "d1i1", name: "Sourdough Bread", quantity: "2", unit: "slices"),
                Ingredient(id: "d1i2", name: "Ripe Avocado", quantity: "1", unit: "pcs"),
                Ingredient(id: "d1i3", name: "Egg", quantity: "1", unit: "pcs"),
                Ingredient(id: "d1i4", name: "Lemon Juice", quantity: "1", unit: "tsp"),
                Ingredient(id: "d1i5", name: "Chilli Flakes", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "d1i6", name: "Salt & Pepper", quantity: "1", unit: "pinch")
            ],
            steps: [
                CookingStep(id: "d1s1", stepNumber: 1, instruction: "Toast sourdough slices until golden and crispy.", image: nil, duration: 180),
                CookingStep(id: "d1s2", stepNumber: 2, instruction: "Mash avocado with lemon juice, salt, and pepper.", image: nil, duration: 120),
                CookingStep(id: "d1s3", stepNumber: 3, instruction: "Bring a pot of water to a gentle simmer. Add a splash of vinegar. Crack egg into a cup and gently slide into water. Poach for 3 minutes.", image: nil, duration: 180),
                CookingStep(id: "d1s4", stepNumber: 4, instruction: "Spread avocado over toast, top with poached egg and chilli flakes. Serve immediately.", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 310, protein: "14g", carbs: "28g", fat: "16g", fiber: "7g"),
            rating: 4.9,
            reviews: 512,
            mode: .normal
        )

        let demoRecipe2 = Recipe(
            id: "demo_r2",
            title: "Mango Chia Pudding",
            description: "A refreshing overnight chia pudding layered with fresh mango purée — perfect for breakfast or a healthy dessert.",
            heroImage: "cloud.fill",
            cuisine: "International",
            diet: "Vegan",
            category: "Dessert",
            preparationTime: 10,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "d2i1", name: "Chia Seeds", quantity: "4", unit: "tbsp"),
                Ingredient(id: "d2i2", name: "Coconut Milk", quantity: "300", unit: "ml"),
                Ingredient(id: "d2i3", name: "Ripe Mango", quantity: "1", unit: "pcs"),
                Ingredient(id: "d2i4", name: "Maple Syrup", quantity: "1", unit: "tbsp"),
                Ingredient(id: "d2i5", name: "Vanilla Extract", quantity: "1/2", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "d2s1", stepNumber: 1, instruction: "Mix chia seeds with coconut milk, maple syrup and vanilla. Stir well.", image: nil, duration: 120),
                CookingStep(id: "d2s2", stepNumber: 2, instruction: "Cover and refrigerate overnight (or at least 4 hours) until thick.", image: nil, duration: 14400),
                CookingStep(id: "d2s3", stepNumber: 3, instruction: "Blend mango flesh into a smooth purée.", image: nil, duration: 120),
                CookingStep(id: "d2s4", stepNumber: 4, instruction: "Layer chia pudding and mango purée in glasses. Serve chilled.", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 245, protein: "6g", carbs: "28g", fat: "12g", fiber: "10g"),
            rating: 4.8,
            reviews: 387,
            mode: .normal
        )

        // Append demo recipes only if not already present
        if !recipes.contains(where: { $0.id == demoRecipe1.id }) {
            recipes.append(demoRecipe1)
        }
        if !recipes.contains(where: { $0.id == demoRecipe2.id }) {
            recipes.append(demoRecipe2)
        }
        // Register as custom (user-created) so they appear in My Recipes section
        customRecipeIds.insert(demoRecipe1.id)
        customRecipeIds.insert(demoRecipe2.id)
        saveRecipes()
        if let encoded = try? JSONEncoder().encode(Array(customRecipeIds)) {
            UserDefaults.standard.set(encoded, forKey: customRecipeIdsKey)
        }

        // ── Demo Favorites (Saved section) ─────────────────────────────────────
        let favRecipeIds = ["1", "2", "3", "demo_r1", "demo_r2"]
        for recipeId in favRecipeIds {
            if !favorites.contains(where: { $0.recipeId == recipeId }) {
                let fav = FavoriteRecipe(id: "demo_fav_\(recipeId)", recipeId: recipeId, savedDate: Date())
                favorites.append(fav)
            }
        }
        saveFavorites()

        // ── Demo Shopping List (Lists section) ─────────────────────────────────
        let demoItems: [(String, String, String)] = [
            ("Avocado", "3", "pcs"),
            ("Sourdough Bread", "1", "loaf"),
            ("Chia Seeds", "200", "g"),
            ("Coconut Milk", "400", "ml"),
            ("Mango", "2", "pcs"),
            ("Salmon Fillet", "400", "g"),
            ("Lemon", "3", "pcs"),
            ("Olive Oil", "250", "ml")
        ]
        let existingItems = Set(shoppingList.map { $0.ingredient.lowercased() })
        for (ingredient, quantity, unit) in demoItems {
            if !existingItems.contains(ingredient.lowercased()) {
                let item = ShoppingListItem(
                    id: "demo_shop_\(ingredient.replacingOccurrences(of: " ", with: "_"))",
                    ingredient: ingredient,
                    quantity: quantity,
                    unit: unit,
                    isChecked: false,
                    category: nil
                )
                shoppingList.append(item)
            }
        }
        saveShoppingList()

        // ── Fixed Plan (Normal Mode) — Mon, Tue, Wed, Thu ──────────────────────
        // weekday: 2=Mon, 3=Tue, 4=Wed, 5=Thu (Calendar.weekday values)
        let fixedMeals: [(weekday: Int, meal: String, recipeId: String)] = [
            (2, "breakfast", "demo_r1"),   // Mon Breakfast: Avocado Toast
            (2, "lunch",     "3"),         // Mon Lunch:     Buddha Bowl
            (2, "dinner",    "2"),         // Mon Dinner:    Grilled Salmon
            (3, "breakfast", "demo_r2"),   // Tue Breakfast: Mango Chia Pudding
            (3, "lunch",     "1"),         // Tue Lunch:     Margherita Pizza (quick)
            (3, "dinner",    "2"),         // Tue Dinner:    Grilled Salmon
            (4, "breakfast", "demo_r1"),   // Wed Breakfast: Avocado Toast
            (4, "lunch",     "3"),         // Wed Lunch:     Buddha Bowl
            (4, "dinner",    "1"),         // Wed Dinner:    Classic Margherita Pizza
            (5, "breakfast", "demo_r2"),   // Thu Breakfast: Mango Chia Pudding
            (5, "lunch",     "3"),         // Thu Lunch:     Buddha Bowl
            (5, "dinner",    "2"),         // Thu Dinner:    Grilled Salmon
        ]
        for entry in fixedMeals {
            let alreadySet = fixedPlan.contains {
                $0.weekday == entry.weekday && $0.meal == entry.meal && $0.mode == "normal"
            }
            if !alreadySet {
                setFixedPlanEntry(weekday: entry.weekday, meal: entry.meal, recipeId: entry.recipeId, mode: "normal")
            }
        }
    }

    private func loadSampleCategories() {
        let sampleCategories = [
            Category(id: "1", name: "Breakfast", icon: "☀️"),
            Category(id: "2", name: "Lunch", icon: "🥗"),
            Category(id: "3", name: "Dinner", icon: "🍽️"),
            Category(id: "4", name: "Dessert", icon: "🍰"),
            Category(id: "5", name: "Snacks", icon: "🥜"),
            Category(id: "6", name: "Beverages", icon: "☕")
        ]
        
        categories = sampleCategories
        saveCategories()
    }
    
    // MARK: - Save Methods
    func saveRecipes() {
        if let encoded = try? JSONEncoder().encode(recipes) {
            UserDefaults.standard.set(encoded, forKey: recipesKey)
        }
    }
    
    func saveCategories() {
        if let encoded = try? JSONEncoder().encode(categories) {
            UserDefaults.standard.set(encoded, forKey: categoriesKey)
        }
    }
    
    func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
    
    func saveShoppingList() {
        if let encoded = try? JSONEncoder().encode(shoppingList) {
            UserDefaults.standard.set(encoded, forKey: shoppingListKey)
        }
    }
    
    func saveMealPlan() {
        if let encoded = try? JSONEncoder().encode(mealPlan) {
            UserDefaults.standard.set(encoded, forKey: mealPlanKey)
        }
    }
    
    // MARK: - Load Methods
    private func loadFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: recipesKey),
           let decoded = try? JSONDecoder().decode([Recipe].self, from: data) {
            recipes = decoded
        }
        
        if let data = UserDefaults.standard.data(forKey: categoriesKey),
           let decoded = try? JSONDecoder().decode([Category].self, from: data) {
            categories = decoded
        }
        
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let decoded = try? JSONDecoder().decode([FavoriteRecipe].self, from: data) {
            favorites = decoded
        }
        
        if let data = UserDefaults.standard.data(forKey: shoppingListKey),
           let decoded = try? JSONDecoder().decode([ShoppingListItem].self, from: data) {
            shoppingList = decoded
        }
        
        if let data = UserDefaults.standard.data(forKey: mealPlanKey),
           let decoded = try? JSONDecoder().decode([MealPlanItem].self, from: data) {
            mealPlan = decoded
        }

        if let data = UserDefaults.standard.data(forKey: customRecipeIdsKey),
           let decoded = try? JSONDecoder().decode([String].self, from: data) {
            customRecipeIds = Set(decoded)
        }

        // Fixed Plan template
        if let data = UserDefaults.standard.data(forKey: fixedPlanKey),
           let decoded = try? JSONDecoder().decode([FixedPlanEntry].self, from: data) {
            fixedPlan = decoded
        }
    }
    
    // MARK: - Favorites Management
    func addToFavorites(_ recipe: Recipe) {
        let favorite = FavoriteRecipe(id: UUID().uuidString, recipeId: recipe.id, savedDate: Date())
        favorites.append(favorite)
        saveFavorites()
    }
    
    func removeFromFavorites(_ recipeId: String) {
        favorites.removeAll { $0.recipeId == recipeId }
        saveFavorites()
    }
    
    func isFavorite(_ recipeId: String) -> Bool {
        favorites.contains { $0.recipeId == recipeId }
    }
    
    // MARK: - Shopping List Management
    func addIngredientsToShoppingList(_ ingredients: [Ingredient]) {
        for ingredient in ingredients {
            let item = ShoppingListItem(
                id: UUID().uuidString,
                ingredient: ingredient.name,
                quantity: ingredient.quantity,
                unit: ingredient.unit,
                isChecked: false,
                category: nil
            )
            shoppingList.append(item)
        }
        saveShoppingList()
    }

    /// Returns ingredient names that already exist in the shopping list (case-insensitive).
    func duplicateIngredientNames(in ingredients: [Ingredient]) -> [String] {
        let existingNames = Set(shoppingList.map { $0.ingredient.lowercased() })
        return ingredients
            .map { $0.name }
            .filter { existingNames.contains($0.lowercased()) }
    }
    
    func toggleShoppingItem(_ itemId: String) {
        if let index = shoppingList.firstIndex(where: { $0.id == itemId }) {
            let item = shoppingList[index]
            let updatedItem = ShoppingListItem(
                id: item.id,
                ingredient: item.ingredient,
                quantity: item.quantity,
                unit: item.unit,
                isChecked: !item.isChecked,
                category: item.category
            )
            shoppingList[index] = updatedItem
            saveShoppingList()
        }
    }
    
    func removeShoppingItem(_ itemId: String) {
        shoppingList.removeAll { $0.id == itemId }
        saveShoppingList()
    }
    
    func clearShoppingList() {
        shoppingList.removeAll()
        saveShoppingList()
    }
    
    // MARK: - Meal Plan Management
    func addMealPlan(_ recipeId: String, date: Date, meal: String, source: String = "regular") {
        // Prevent duplicates for the same source+slot+date
        let existing = getMealPlanForDate(date)
        if existing.contains(where: { $0.meal == meal && $0.source == source && $0.recipeId == recipeId }) { return }
        let item = MealPlanItem(id: UUID().uuidString, date: date, meal: meal, recipeId: recipeId, source: source)
        mealPlan.append(item)
        saveMealPlan()
    }

    /// Returns meals for a date filtered by source tag (plan mode).
    func getMealPlanForDate(_ date: Date, source: String) -> [MealPlanItem] {
        mealPlan.filter {
            Calendar.current.isDate($0.date, inSameDayAs: date) && $0.source == source
        }
    }
    
    func removeMealPlan(_ itemId: String) {
        mealPlan.removeAll { $0.id == itemId }
        saveMealPlan()
    }
    
    func getMealPlanForDate(_ date: Date) -> [MealPlanItem] {
        mealPlan.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }
    
    // MARK: - Category
    func recipes(for category: String) -> [Recipe] {
        recipes.filter { $0.category == category }
    }
    
    // MARK: - Search
    func searchRecipes(query: String, cuisine: String? = nil, diet: String? = nil, maxTime: Int? = nil, maxCalories: Int? = nil) -> [Recipe] {
        recipes.filter { recipe in
            let matchesQuery = query.isEmpty ||
            recipe.title.localizedCaseInsensitiveContains(query) ||
            recipe.description.localizedCaseInsensitiveContains(query)
            
            let matchesCuisine = cuisine == nil || recipe.cuisine == cuisine
            let matchesDiet = diet == nil || recipe.diet == diet
            let matchesTime = maxTime == nil || (recipe.preparationTime + recipe.cookingTime) <= (maxTime ?? 0)
            let matchesCalories = maxCalories == nil || recipe.nutrition.calories <= (maxCalories ?? 0)
            
            return matchesQuery && matchesCuisine && matchesDiet && matchesTime && matchesCalories
        }
    }
    
    // MARK: - Ingredient-Based Filtering
    func recipesContaining(ingredient: String) -> [Recipe] {
        recipes.filter { recipe in
            recipe.ingredients.contains { ing in
                ing.name.localizedCaseInsensitiveContains(ingredient)
            }
        }
    }

    // MARK: - Custom Recipe Management

    /// Adds a user-created recipe to the main recipes array and tags its ID as custom.
    func addCustomRecipe(_ recipe: Recipe) {
        recipes.append(recipe)
        customRecipeIds.insert(recipe.id)
        saveRecipes()
        saveCustomRecipeIds()
    }

    /// Removes a custom recipe and cleans up all references (favorites, meal plan, shopping list).
    func deleteCustomRecipe(_ recipeId: String) {
        guard customRecipeIds.contains(recipeId) else { return }
        recipes.removeAll { $0.id == recipeId }
        customRecipeIds.remove(recipeId)
        favorites.removeAll { $0.recipeId == recipeId }
        mealPlan.removeAll { $0.recipeId == recipeId }
        saveRecipes()
        saveCustomRecipeIds()
        saveFavorites()
        saveMealPlan()
    }

    /// Updates an existing user-created recipe in place and persists to local storage.
    func updateCustomRecipe(_ updated: Recipe) {
        guard customRecipeIds.contains(updated.id) else { return }
        if let index = recipes.firstIndex(where: { $0.id == updated.id }) {
            recipes[index] = updated
            saveRecipes()
        }
    }

    /// Returns true when the given recipe was created by the user.
    func isCustomRecipe(_ recipeId: String) -> Bool {
        customRecipeIds.contains(recipeId)
    }

    private func saveCustomRecipeIds() {
        if let encoded = try? JSONEncoder().encode(Array(customRecipeIds)) {
            UserDefaults.standard.set(encoded, forKey: customRecipeIdsKey)
        }
    }
    
    // MARK: - Load Massive Recipe Expansion
    private func loadMassiveRecipeExpansion() {
        let newRecipes = MassiveRecipeExpansion.getAllRecipes()
        recipes.append(contentsOf: newRecipes)
        saveRecipes()
    }

    // MARK: - Fixed Plan Template Management

    /// Returns all fixed plan entries for a given Calendar.weekday value (1=Sun, 2=Mon…7=Sat).
    func fixedPlanEntries(for weekday: Int, mode: String = "normal") -> [FixedPlanEntry] {
        fixedPlan.filter { $0.weekday == weekday && $0.mode == mode }
    }

    /// Sets a recipe for a specific weekday + meal slot for the given mode, replacing any existing entry.
    func setFixedPlanEntry(weekday: Int, meal: String, recipeId: String, mode: String = "normal") {
        fixedPlan.removeAll { $0.weekday == weekday && $0.meal == meal && $0.mode == mode }
        let entry = FixedPlanEntry(
            id: UUID().uuidString,
            weekday: weekday,
            meal: meal,
            recipeId: recipeId,
            mode: mode
        )
        fixedPlan.append(entry)
        saveFixedPlan()
    }

    /// Removes the entry for a specific weekday + meal slot for the given mode.
    func removeFixedPlanEntry(weekday: Int, meal: String, mode: String = "normal") {
        fixedPlan.removeAll { $0.weekday == weekday && $0.meal == meal && $0.mode == mode }
        saveFixedPlan()
    }

    /// Returns true if the fixed plan has at least one entry for the given weekday + mode.
    func hasFixedPlan(for weekday: Int, mode: String = "normal") -> Bool {
        fixedPlan.contains { $0.weekday == weekday && $0.mode == mode }
    }

    /// Applies fixed plan entries for the given weekday + mode to a calendar date.
    /// Skips entries already scheduled (same source) to prevent duplicates.
    func applyFixedPlan(for weekday: Int, to date: Date, mode: String = "normal") {
        let entries = fixedPlanEntries(for: weekday, mode: mode)
        let existingItems = getMealPlanForDate(date, source: "fixed")
        for entry in entries {
            let alreadyScheduled = existingItems.contains {
                $0.meal == entry.meal && $0.recipeId == entry.recipeId
            }
            guard !alreadyScheduled else { continue }
            addMealPlan(entry.recipeId, date: date, meal: entry.meal, source: "fixed")
        }
    }

    private func saveFixedPlan() {
        if let encoded = try? JSONEncoder().encode(fixedPlan) {
            UserDefaults.standard.set(encoded, forKey: fixedPlanKey)
        }
    }
}
