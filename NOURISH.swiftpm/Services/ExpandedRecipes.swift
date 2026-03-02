import Foundation

// MARK: - Expanded Mode-Specific Recipes
// This file contains additional recipes for all health modes across all categories

extension LocalDatabaseManager {
    
    func loadExpandedRecipes() {
        var expandedRecipes: [Recipe] = []
        
        // MARK: - DIABETIC MODE RECIPES (15 recipes across all categories)
        
        // Diabetic Breakfast
        expandedRecipes.append(Recipe(
            id: "diabetic_6",
            title: "Almond Flour Waffles",
            description: "Low-carb crispy waffles made with almond flour",
            heroImage: "square.grid.3x3.fill",
            cuisine: "American",
            diet: "Keto-Friendly",
            category: "Breakfast",
            preparationTime: 10,
            cookingTime: 15,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Almond Flour", quantity: "200", unit: "g"),
                Ingredient(id: "2", name: "Eggs", quantity: "3", unit: "pcs"),
                Ingredient(id: "3", name: "Unsweetened Almond Milk", quantity: "120", unit: "ml"),
                Ingredient(id: "4", name: "Baking Powder", quantity: "2", unit: "tsp"),
                Ingredient(id: "5", name: "Stevia", quantity: "2", unit: "tsp"),
                Ingredient(id: "6", name: "Vanilla Extract", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Mix dry ingredients in a bowl", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Whisk eggs, milk and vanilla", image: nil, duration: 90),
                CookingStep(id: "3", stepNumber: 3, instruction: "Combine wet and dry ingredients", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Cook in preheated waffle iron", image: nil, duration: 600),
                CookingStep(id: "5", stepNumber: 5, instruction: "Serve with sugar-free syrup", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 195, protein: "9g", carbs: "8g", fat: "15g", fiber: "4g"),
            rating: 4.6,
            reviews: 142,
            mode: .diabetic
        ))
        
        expandedRecipes.append(Recipe(
            id: "diabetic_7",
            title: "Chia Seed Pudding",
            description: "Overnight chia pudding with berries and nuts",
            heroImage: "cup.and.saucer.fill",
            cuisine: "International",
            diet: "Vegan",
            category: "Breakfast",
            preparationTime: 480,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Chia Seeds", quantity: "60", unit: "g"),
                Ingredient(id: "2", name: "Unsweetened Almond Milk", quantity: "400", unit: "ml"),
                Ingredient(id: "3", name: "Vanilla Extract", quantity: "1", unit: "tsp"),
                Ingredient(id: "4", name: "Mixed Berries", quantity: "100", unit: "g"),
                Ingredient(id: "5", name: "Walnuts", quantity: "30", unit: "g"),
                Ingredient(id: "6", name: "Cinnamon", quantity: "0.5", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Mix chia seeds, milk, vanilla and cinnamon", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Stir well and refrigerate overnight", image: nil, duration: 28800),
                CookingStep(id: "3", stepNumber: 3, instruction: "Stir again before serving", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Top with berries and walnuts", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 245, protein: "9g", carbs: "20g", fat: "16g", fiber: "14g"),
            rating: 4.8,
            reviews: 218,
            mode: .diabetic
        ))
        
        // Diabetic Lunch
        expandedRecipes.append(Recipe(
            id: "diabetic_8",
            title: "Cauliflower Rice Stir Fry",
            description: "Low-carb vegetable stir fry with cauliflower rice",
            heroImage: "fork.knife",
            cuisine: "Asian",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 15,
            cookingTime: 12,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Cauliflower Rice", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Bell Peppers", quantity: "2", unit: "pcs"),
                Ingredient(id: "3", name: "Broccoli", quantity: "200", unit: "g"),
                Ingredient(id: "4", name: "Snap Peas", quantity: "150", unit: "g"),
                Ingredient(id: "5", name: "Tofu", quantity: "200", unit: "g"),
                Ingredient(id: "6", name: "Soy Sauce", quantity: "3", unit: "tbsp"),
                Ingredient(id: "7", name: "Ginger", quantity: "1", unit: "tbsp"),
                Ingredient(id: "8", name: "Garlic", quantity: "3", unit: "cloves")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Press and cube tofu", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Stir fry tofu until golden", image: nil, duration: 300),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add vegetables and stir fry", image: nil, duration: 240),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add cauliflower rice and seasonings", image: nil, duration: 180),
                CookingStep(id: "5", stepNumber: 5, instruction: "Toss everything together and serve", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 185, protein: "14g", carbs: "18g", fat: "7g", fiber: "8g"),
            rating: 4.5,
            reviews: 167,
            mode: .diabetic
        ))
        
        expandedRecipes.append(Recipe(
            id: "diabetic_9",
            title: "Lentil and Spinach Soup",
            description: "Hearty fiber-rich lentil soup with fresh spinach",
            heroImage: "cup.and.saucer.fill",
            cuisine: "Mediterranean",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 15,
            cookingTime: 35,
            difficulty: "Easy",
            servings: 6,
            ingredients: [
                Ingredient(id: "1", name: "Red Lentils", quantity: "300", unit: "g"),
                Ingredient(id: "2", name: "Fresh Spinach", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Onion", quantity: "1", unit: "pcs"),
                Ingredient(id: "4", name: "Tomatoes", quantity: "3", unit: "pcs"),
                Ingredient(id: "5", name: "Vegetable Broth", quantity: "1.5", unit: "l"),
                Ingredient(id: "6", name: "Cumin", quantity: "1", unit: "tsp"),
                Ingredient(id: "7", name: "Turmeric", quantity: "0.5", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Sauté onions until translucent", image: nil, duration: 240),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add spices and cook 1 minute", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add lentils, tomatoes and broth", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Simmer for 25 minutes", image: nil, duration: 1500),
                CookingStep(id: "5", stepNumber: 5, instruction: "Stir in spinach and cook 2 minutes", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 195, protein: "12g", carbs: "32g", fat: "2g", fiber: "10g"),
            rating: 4.7,
            reviews: 203,
            mode: .diabetic
        ))
        
        // Diabetic Dinner
        expandedRecipes.append(Recipe(
            id: "diabetic_10",
            title: "Baked Cod with Herbs",
            description: "Light and flavorful baked cod with Mediterranean herbs",
            heroImage: "fish.fill",
            cuisine: "Mediterranean",
            diet: "Gluten-Free",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Cod Fillets", quantity: "600", unit: "g"),
                Ingredient(id: "2", name: "Cherry Tomatoes", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Kalamata Olives", quantity: "50", unit: "g"),
                Ingredient(id: "4", name: "Fresh Parsley", quantity: "30", unit: "g"),
                Ingredient(id: "5", name: "Lemon", quantity: "1", unit: "pcs"),
                Ingredient(id: "6", name: "Olive Oil", quantity: "2", unit: "tbsp"),
                Ingredient(id: "7", name: "Garlic", quantity: "3", unit: "cloves")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Preheat oven to 200°C", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Place cod in baking dish", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add tomatoes, olives and garlic", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Drizzle with oil and lemon juice", image: nil, duration: 60),
                CookingStep(id: "5", stepNumber: 5, instruction: "Bake for 18-20 minutes", image: nil, duration: 1200),
                CookingStep(id: "6", stepNumber: 6, instruction: "Garnish with parsley and serve", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 210, protein: "32g", carbs: "6g", fat: "8g", fiber: "2g"),
            rating: 4.8,
            reviews: 189,
            mode: .diabetic
        ))
        
        expandedRecipes.append(Recipe(
            id: "diabetic_11",
            title: "Turkey Zucchini Boats",
            description: "Stuffed zucchini with lean ground turkey and vegetables",
            heroImage: "leaf.fill",
            cuisine: "Mediterranean",
            diet: "Gluten-Free",
            category: "Dinner",
            preparationTime: 20,
            cookingTime: 30,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Large Zucchini", quantity: "4", unit: "pcs"),
                Ingredient(id: "2", name: "Ground Turkey", quantity: "400", unit: "g"),
                Ingredient(id: "3", name: "Diced Tomatoes", quantity: "200", unit: "g"),
                Ingredient(id: "4", name: "Onion", quantity: "1", unit: "pcs"),
                Ingredient(id: "5", name: "Mushrooms", quantity: "150", unit: "g"),
                Ingredient(id: "6", name: "Italian Herbs", quantity: "1", unit: "tbsp"),
                Ingredient(id: "7", name: "Parmesan", quantity: "50", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Halve zucchini and scoop out centers", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Brown turkey with onions", image: nil, duration: 420),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add mushrooms, tomatoes and herbs", image: nil, duration: 240),
                CookingStep(id: "4", stepNumber: 4, instruction: "Fill zucchini boats with mixture", image: nil, duration: 180),
                CookingStep(id: "5", stepNumber: 5, instruction: "Top with parmesan and bake 25 min", image: nil, duration: 1500)
            ],
            nutrition: Nutrition(calories: 245, protein: "28g", carbs: "12g", fat: "10g", fiber: "4g"),
            rating: 4.6,
            reviews: 154,
            mode: .diabetic
        ))
        
        // Diabetic Snacks
        expandedRecipes.append(Recipe(
            id: "diabetic_12",
            title: "Roasted Chickpeas",
            description: "Crunchy roasted chickpeas with savory spices",
            heroImage: "circle.fill",
            cuisine: "Mediterranean",
            diet: "Vegan",
            category: "Snacks",
            preparationTime: 5,
            cookingTime: 30,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Chickpeas", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Olive Oil", quantity: "2", unit: "tbsp"),
                Ingredient(id: "3", name: "Paprika", quantity: "1", unit: "tsp"),
                Ingredient(id: "4", name: "Cumin", quantity: "1", unit: "tsp"),
                Ingredient(id: "5", name: "Garlic Powder", quantity: "0.5", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Drain and dry chickpeas thoroughly", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Toss with oil and spices", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Spread on baking sheet", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Roast at 200°C for 30 minutes", image: nil, duration: 1800)
            ],
            nutrition: Nutrition(calories: 165, protein: "8g", carbs: "24g", fat: "5g", fiber: "7g"),
            rating: 4.4,
            reviews: 312,
            mode: .diabetic
        ))
        
        expandedRecipes.append(Recipe(
            id: "diabetic_13",
            title: "Cucumber Hummus Rolls",
            description: "Refreshing cucumber slices with hummus and vegetables",
            heroImage: "leaf.circle.fill",
            cuisine: "Mediterranean",
            diet: "Vegan",
            category: "Snacks",
            preparationTime: 15,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "English Cucumber", quantity: "1", unit: "pcs"),
                Ingredient(id: "2", name: "Hummus", quantity: "150", unit: "g"),
                Ingredient(id: "3", name: "Cherry Tomatoes", quantity: "100", unit: "g"),
                Ingredient(id: "4", name: "Bell Pepper", quantity: "1", unit: "pcs"),
                Ingredient(id: "5", name: "Fresh Herbs", quantity: "20", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Slice cucumber lengthwise very thin", image: nil, duration: 240),
                CookingStep(id: "2", stepNumber: 2, instruction: "Spread hummus on each slice", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add vegetables and herbs", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Roll up and secure with toothpick", image: nil, duration: 180)
            ],
            nutrition: Nutrition(calories: 145, protein: "6g", carbs: "18g", fat: "6g", fiber: "5g"),
            rating: 4.3,
            reviews: 98,
            mode: .diabetic
        ))
        
        // Diabetic Dessert
        expandedRecipes.append(Recipe(
            id: "diabetic_14",
            title: "Sugar-Free Berry Parfait",
            description: "Layered Greek yogurt with fresh berries",
            heroImage: "birthday.cake.fill",
            cuisine: "International",
            diet: "Gluten-Free",
            category: "Dessert",
            preparationTime: 10,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Greek Yogurt", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Mixed Berries", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Almonds", quantity: "30", unit: "g"),
                Ingredient(id: "4", name: "Cinnamon", quantity: "0.5", unit: "tsp"),
                Ingredient(id: "5", name: "Vanilla Extract", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Mix yogurt with vanilla", image: nil, duration: 60),
                CookingStep(id: "2", stepNumber: 2, instruction: "Layer yogurt and berries in glass", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Top with crushed almonds", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Dust with cinnamon", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 215, protein: "18g", carbs: "22g", fat: "8g", fiber: "4g"),
            rating: 4.7,
            reviews: 176,
            mode: .diabetic
        ))
        
        expandedRecipes.append(Recipe(
            id: "diabetic_15",
            title: "Dark Chocolate Avocado Mousse",
            description: "Creamy sugar-free mousse made with avocado",
            heroImage: "birthday.cake.fill",
            cuisine: "International",
            diet: "Vegan",
            category: "Dessert",
            preparationTime: 10,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Ripe Avocados", quantity: "2", unit: "pcs"),
                Ingredient(id: "2", name: "Dark Cocoa Powder", quantity: "40", unit: "g"),
                Ingredient(id: "3", name: "Unsweetened Almond Milk", quantity: "100", unit: "ml"),
                Ingredient(id: "4", name: "Stevia", quantity: "3", unit: "tsp"),
                Ingredient(id: "5", name: "Vanilla Extract", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Blend all ingredients until smooth", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Taste and adjust sweetness", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Chill for 30 minutes", image: nil, duration: 1800),
                CookingStep(id: "4", stepNumber: 4, instruction: "Serve in dessert cups", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 180, protein: "3g", carbs: "15g", fat: "14g", fiber: "8g"),
            rating: 4.5,
            reviews: 142,
            mode: .diabetic
        ))
        
        // Diabetic Beverages
        expandedRecipes.append(Recipe(
            id: "diabetic_16",
            title: "Herbal Detox Tea",
            description: "Refreshing sugar-free herbal tea blend",
            heroImage: "cup.and.saucer.fill",
            cuisine: "International",
            diet: "Vegan",
            category: "Beverages",
            preparationTime: 5,
            cookingTime: 10,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Green Tea", quantity: "2", unit: "bags"),
                Ingredient(id: "2", name: "Fresh Mint", quantity: "10", unit: "leaves"),
                Ingredient(id: "3", name: "Ginger Slices", quantity: "5", unit: "pcs"),
                Ingredient(id: "4", name: "Lemon", quantity: "0.5", unit: "pcs"),
                Ingredient(id: "5", name: "Cinnamon Stick", quantity: "1", unit: "pcs")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Boil water", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add all ingredients", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Steep for 8 minutes", image: nil, duration: 480),
                CookingStep(id: "4", stepNumber: 4, instruction: "Strain and serve", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 5, protein: "0g", carbs: "1g", fat: "0g", fiber: "0g"),
            rating: 4.6,
            reviews: 234,
            mode: .diabetic
        ))
        
        // MARK: - HEART CARE MODE RECIPES (12 recipes)
        
        // Heart Care Breakfast
        expandedRecipes.append(Recipe(
            id: "heart_5",
            title: "Oatmeal with Berries",
            description: "Heart-healthy steel-cut oats with fresh berries",
            heroImage: "sunrise.fill",
            cuisine: "American",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 5,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Steel-Cut Oats", quantity: "100", unit: "g"),
                Ingredient(id: "2", name: "Water", quantity: "500", unit: "ml"),
                Ingredient(id: "3", name: "Mixed Berries", quantity: "150", unit: "g"),
                Ingredient(id: "4", name: "Walnuts", quantity: "30", unit: "g"),
                Ingredient(id: "5", name: "Flaxseeds", quantity: "2", unit: "tbsp"),
                Ingredient(id: "6", name: "Cinnamon", quantity: "0.5", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Bring water to boil", image: nil, duration: 240),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add oats and reduce heat", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Simmer for 15 minutes stirring occasionally", image: nil, duration: 900),
                CookingStep(id: "4", stepNumber: 4, instruction: "Top with berries, nuts and seeds", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 285, protein: "10g", carbs: "42g", fat: "10g", fiber: "9g"),
            rating: 4.7,
            reviews: 198,
            mode: .heartCare
        ))
        
        expandedRecipes.append(Recipe(
            id: "heart_6",
            title: "Egg White Veggie Scramble",
            description: "Low-cholesterol egg white scramble with vegetables",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "American",
            diet: "Gluten-Free",
            category: "Breakfast",
            preparationTime: 10,
            cookingTime: 8,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Egg Whites", quantity: "6", unit: "pcs"),
                Ingredient(id: "2", name: "Spinach", quantity: "100", unit: "g"),
                Ingredient(id: "3", name: "Tomatoes", quantity: "2", unit: "pcs"),
                Ingredient(id: "4", name: "Mushrooms", quantity: "100", unit: "g"),
                Ingredient(id: "5", name: "Bell Pepper", quantity: "1", unit: "pcs"),
                Ingredient(id: "6", name: "Herbs", quantity: "1", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Chop all vegetables", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Sauté vegetables in non-stick pan", image: nil, duration: 240),
                CookingStep(id: "3", stepNumber: 3, instruction: "Pour in egg whites", image: nil, duration: 30),
                CookingStep(id: "4", stepNumber: 4, instruction: "Scramble gently until cooked", image: nil, duration: 240),
                CookingStep(id: "5", stepNumber: 5, instruction: "Season with herbs", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 125, protein: "16g", carbs: "12g", fat: "1g", fiber: "3g"),
            rating: 4.5,
            reviews: 143,
            mode: .heartCare
        ))
        
        // Heart Care Lunch
        expandedRecipes.append(Recipe(
            id: "heart_7",
            title: "Quinoa Mediterranean Bowl",
            description: "Colorful quinoa bowl with olives and feta",
            heroImage: "leaf.fill",
            cuisine: "Mediterranean",
            diet: "Vegetarian",
            category: "Lunch",
            preparationTime: 15,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Quinoa", quantity: "200", unit: "g"),
                Ingredient(id: "2", name: "Cherry Tomatoes", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Cucumber", quantity: "1", unit: "pcs"),
                Ingredient(id: "4", name: "Kalamata Olives", quantity: "50", unit: "g"),
                Ingredient(id: "5", name: "Low-Fat Feta", quantity: "100", unit: "g"),
                Ingredient(id: "6", name: "Lemon", quantity: "1", unit: "pcs"),
                Ingredient(id: "7", name: "Fresh Herbs", quantity: "30", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cook quinoa per package instructions", image: nil, duration: 900),
                CookingStep(id: "2", stepNumber: 2, instruction: "Chop vegetables while quinoa cools", image: nil, duration: 300),
                CookingStep(id: "3", stepNumber: 3, instruction: "Combine all ingredients", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Dress with lemon juice", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 295, protein: "12g", carbs: "45g", fat: "8g", fiber: "7g"),
            rating: 4.8,
            reviews: 224,
            mode: .heartCare
        ))
        
        expandedRecipes.append(Recipe(
            id: "heart_8",
            title: "Lentil Vegetable Stew",
            description: "Hearty sodium-free lentil and vegetable stew",
            heroImage: "cup.and.saucer.fill",
            cuisine: "Mediterranean",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 15,
            cookingTime: 35,
            difficulty: "Easy",
            servings: 6,
            ingredients: [
                Ingredient(id: "1", name: "Brown Lentils", quantity: "300", unit: "g"),
                Ingredient(id: "2", name: "Carrots", quantity: "3", unit: "pcs"),
                Ingredient(id: "3", name: "Celery", quantity: "3", unit: "stalks"),
                Ingredient(id: "4", name: "Tomatoes", quantity: "400", unit: "g"),
                Ingredient(id: "5", name: "Low-Sodium Broth", quantity: "1", unit: "l"),
                Ingredient(id: "6", name: "Thyme", quantity: "1", unit: "tsp"),
                Ingredient(id: "7", name: "Bay Leaf", quantity: "2", unit: "pcs")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Sauté carrots and celery", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add lentils, tomatoes and broth", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add herbs and bring to boil", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Simmer for 30 minutes", image: nil, duration: 1800),
                CookingStep(id: "5", stepNumber: 5, instruction: "Remove bay leaves and serve", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 185, protein: "11g", carbs: "32g", fat: "1g", fiber: "10g"),
            rating: 4.6,
            reviews: 187,
            mode: .heartCare
        ))
        
        // Heart Care Dinner
        expandedRecipes.append(Recipe(
            id: "heart_9",
            title: "Baked Trout with Almonds",
            description: "Omega-3 rich trout with heart-healthy almonds",
            heroImage: "fish.fill",
            cuisine: "Mediterranean",
            diet: "Gluten-Free",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 18,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Rainbow Trout", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Sliced Almonds", quantity: "40", unit: "g"),
                Ingredient(id: "3", name: "Lemon", quantity: "1", unit: "pcs"),
                Ingredient(id: "4", name: "Fresh Dill", quantity: "20", unit: "g"),
                Ingredient(id: "5", name: "Garlic", quantity: "2", unit: "cloves")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Preheat oven to 200°C", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Season fish with herbs and garlic", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Top with almonds and lemon slices", image: nil, duration: 90),
                CookingStep(id: "4", stepNumber: 4, instruction: "Bake for 15-18 minutes", image: nil, duration: 1080)
            ],
            nutrition: Nutrition(calories: 275, protein: "34g", carbs: "4g", fat: "14g", fiber: "2g"),
            rating: 4.9,
            reviews: 167,
            mode: .heartCare
        ))
        
        expandedRecipes.append(Recipe(
            id: "heart_10",
            title: "Chickpea Spinach Curry",
            description: "Flavorful chickpea curry with spinach",
            heroImage: "leaf.circle.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 25,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Chickpeas", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Fresh Spinach", quantity: "300", unit: "g"),
                Ingredient(id: "3", name: "Tomatoes", quantity: "400", unit: "g"),
                Ingredient(id: "4", name: "Onion", quantity: "2", unit: "pcs"),
                Ingredient(id: "5", name: "Ginger", quantity: "2", unit: "tbsp"),
                Ingredient(id: "6", name: "Turmeric", quantity: "1", unit: "tsp"),
                Ingredient(id: "7", name: "Cumin", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Sauté onions and ginger", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add spices and cook 1 minute", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add tomatoes and chickpeas", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Simmer for 15 minutes", image: nil, duration: 900),
                CookingStep(id: "5", stepNumber: 5, instruction: "Stir in spinach until wilted", image: nil, duration: 180)
            ],
            nutrition: Nutrition(calories: 235, protein: "11g", carbs: "38g", fat: "4g", fiber: "11g"),
            rating: 4.7,
            reviews: 201,
            mode: .heartCare
        ))
        
        // Heart Care Snacks
        expandedRecipes.append(Recipe(
            id: "heart_11",
            title: "Apple Almond Slices",
            description: "Crisp apple slices with almond butter",
            heroImage: "leaf.fill",
            cuisine: "American",
            diet: "Vegan",
            category: "Snacks",
            preparationTime: 5,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 1,
            ingredients: [
                Ingredient(id: "1", name: "Green Apple", quantity: "1", unit: "pcs"),
                Ingredient(id: "2", name: "Almond Butter", quantity: "2", unit: "tbsp"),
                Ingredient(id: "3", name: "Cinnamon", quantity: "0.25", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Slice apple into rounds", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Spread almond butter on each slice", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Dust with cinnamon", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 195, protein: "5g", carbs: "24g", fat: "10g", fiber: "6g"),
            rating: 4.5,
            reviews: 143,
            mode: .heartCare
        ))
        
        expandedRecipes.append(Recipe(
            id: "heart_12",
            title: "Edamame Snack Bowl",
            description: "Protein-rich steamed edamame",
            heroImage: "circle.fill",
            cuisine: "Japanese",
            diet: "Vegan",
            category: "Snacks",
            preparationTime: 2,
            cookingTime: 8,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Edamame", quantity: "300", unit: "g"),
                Ingredient(id: "2", name: "Sea Salt", quantity: "0.5", unit: "tsp"),
                Ingredient(id: "3", name: "Chili Flakes", quantity: "0.25", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Boil water", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add edamame and cook 5 minutes", image: nil, duration: 300),
                CookingStep(id: "3", stepNumber: 3, instruction: "Drain and toss with salt", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Sprinkle chili flakes if desired", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 135, protein: "12g", carbs: "10g", fat: "6g", fiber: "5g"),
            rating: 4.6,
            reviews: 189,
            mode: .heartCare
        ))
        
        // Heart Care Dessert
        expandedRecipes.append(Recipe(
            id: "heart_13",
            title: "Baked Pears with Walnuts",
            description: "Naturally sweet baked pears with crunchy walnuts",
            heroImage: "birthday.cake.fill",
            cuisine: "French",
            diet: "Vegetarian",
            category: "Dessert",
            preparationTime: 10,
            cookingTime: 25,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Ripe Pears", quantity: "4", unit: "pcs"),
                Ingredient(id: "2", name: "Walnuts", quantity: "60", unit: "g"),
                Ingredient(id: "3", name: "Cinnamon", quantity: "1", unit: "tsp"),
                Ingredient(id: "4", name: "Vanilla Extract", quantity: "1", unit: "tsp"),
                Ingredient(id: "5", name: "Lemon Juice", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Halve pears and remove cores", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Fill with chopped walnuts", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Drizzle with lemon and vanilla", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Bake at 180°C for 25 minutes", image: nil, duration: 1500)
            ],
            nutrition: Nutrition(calories: 165, protein: "3g", carbs: "24g", fat: "8g", fiber: "5g"),
            rating: 4.8,
            reviews: 156,
            mode: .heartCare
        ))
        
        // Heart Care Beverages
        expandedRecipes.append(Recipe(
            id: "heart_14",
            title: "Hibiscus Iced Tea",
            description: "Antioxidant-rich hibiscus tea served cold",
            heroImage: "cup.and.saucer.fill",
            cuisine: "Mexican",
            diet: "Vegan",
            category: "Beverages",
            preparationTime: 5,
            cookingTime: 10,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Dried Hibiscus", quantity: "60", unit: "g"),
                Ingredient(id: "2", name: "Water", quantity: "1", unit: "l"),
                Ingredient(id: "3", name: "Fresh Mint", quantity: "10", unit: "leaves"),
                Ingredient(id: "4", name: "Lime", quantity: "1", unit: "pcs")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Boil water", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add hibiscus and steep 10 minutes", image: nil, duration: 600),
                CookingStep(id: "3", stepNumber: 3, instruction: "Strain and chill", image: nil, duration: 3600),
                CookingStep(id: "4", stepNumber: 4, instruction: "Serve over ice with mint and lime", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 8, protein: "0g", carbs: "2g", fat: "0g", fiber: "0g"),
            rating: 4.7,
            reviews: 198,
            mode: .heartCare
        ))
        
        // MARK: - WEIGHT LOSS MODE RECIPES (12 recipes)
        
        // Weight Loss Breakfast
        expandedRecipes.append(Recipe(
            id: "weightloss_5",
            title: "Green Smoothie Bowl",
            description: "Nutrient-dense low-calorie smoothie bowl",
            heroImage: "leaf.circle.fill",
            cuisine: "International",
            diet: "Vegan",
            category: "Breakfast",
            preparationTime: 10,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 1,
            ingredients: [
                Ingredient(id: "1", name: "Spinach", quantity: "80", unit: "g"),
                Ingredient(id: "2", name: "Frozen Banana", quantity: "1", unit: "pcs"),
                Ingredient(id: "3", name: "Cucumber", quantity: "100", unit: "g"),
                Ingredient(id: "4", name: "Unsweetened Almond Milk", quantity: "150", unit: "ml"),
                Ingredient(id: "5", name: "Chia Seeds", quantity: "1", unit: "tbsp"),
                Ingredient(id: "6", name: "Fresh Berries", quantity: "50", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Blend spinach, banana, cucumber and milk", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Pour into bowl", image: nil, duration: 30),
                CookingStep(id: "3", stepNumber: 3, instruction: "Top with berries and chia seeds", image: nil, duration: 90)
            ],
            nutrition: Nutrition(calories: 175, protein: "5g", carbs: "32g", fat: "4g", fiber: "10g"),
            rating: 4.6,
            reviews: 234,
            mode: .weightLoss
        ))
        
        expandedRecipes.append(Recipe(
            id: "weightloss_6",
            title: "Veggie Egg White Muffins",
            description: "Portable low-calorie egg white breakfast muffins",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "American",
            diet: "Gluten-Free",
            category: "Breakfast",
            preparationTime: 15,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 6,
            ingredients: [
                Ingredient(id: "1", name: "Egg Whites", quantity: "10", unit: "pcs"),
                Ingredient(id: "2", name: "Cherry Tomatoes", quantity: "150", unit: "g"),
                Ingredient(id: "3", name: "Bell Pepper", quantity: "1", unit: "pcs"),
                Ingredient(id: "4", name: "Spinach", quantity: "100", unit: "g"),
                Ingredient(id: "5", name: "Herbs", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Chop vegetables finely", image: nil, duration: 240),
                CookingStep(id: "2", stepNumber: 2, instruction: "Whisk egg whites with herbs", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Divide vegetables into muffin cups", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Pour egg whites over vegetables", image: nil, duration: 90),
                CookingStep(id: "5", stepNumber: 5, instruction: "Bake at 180°C for 20 minutes", image: nil, duration: 1200)
            ],
            nutrition: Nutrition(calories: 65, protein: "11g", carbs: "5g", fat: "0g", fiber: "1g"),
            rating: 4.4,
            reviews: 178,
            mode: .weightLoss
        ))
        
        // Weight Loss Lunch
        expandedRecipes.append(Recipe(
            id: "weightloss_7",
            title: "Zucchini Noodle Primavera",
            description: "Light zucchini noodles with colorful vegetables",
            heroImage: "fork.knife",
            cuisine: "Italian",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 15,
            cookingTime: 10,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Zucchini", quantity: "3", unit: "pcs"),
                Ingredient(id: "2", name: "Cherry Tomatoes", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Bell Peppers", quantity: "2", unit: "pcs"),
                Ingredient(id: "4", name: "Garlic", quantity: "3", unit: "cloves"),
                Ingredient(id: "5", name: "Fresh Basil", quantity: "20", unit: "g"),
                Ingredient(id: "6", name: "Lemon", quantity: "1", unit: "pcs")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Spiralize zucchini into noodles", image: nil, duration: 240),
                CookingStep(id: "2", stepNumber: 2, instruction: "Sauté garlic in pan", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add vegetables and cook 5 minutes", image: nil, duration: 300),
                CookingStep(id: "4", stepNumber: 4, instruction: "Toss in zoodles for 2 minutes", image: nil, duration: 120),
                CookingStep(id: "5", stepNumber: 5, instruction: "Finish with basil and lemon", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 95, protein: "4g", carbs: "18g", fat: "2g", fiber: "6g"),
            rating: 4.5,
            reviews: 189,
            mode: .weightLoss
        ))
        
        expandedRecipes.append(Recipe(
            id: "weightloss_8",
            title: "Thai Shrimp Lettuce Wraps",
            description: "Low-carb protein-rich lettuce wraps",
            heroImage: "leaf.fill",
            cuisine: "Thai",
            diet: "Gluten-Free",
            category: "Lunch",
            preparationTime: 20,
            cookingTime: 8,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Shrimp", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Butter Lettuce", quantity: "12", unit: "leaves"),
                Ingredient(id: "3", name: "Cucumber", quantity: "1", unit: "pcs"),
                Ingredient(id: "4", name: "Carrots", quantity: "2", unit: "pcs"),
                Ingredient(id: "5", name: "Fresh Herbs", quantity: "40", unit: "g"),
                Ingredient(id: "6", name: "Lime", quantity: "2", unit: "pcs"),
                Ingredient(id: "7", name: "Chili", quantity: "1", unit: "pcs")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cook shrimp until pink", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Julienne vegetables", image: nil, duration: 360),
                CookingStep(id: "3", stepNumber: 3, instruction: "Prepare lettuce cups", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Fill with shrimp and vegetables", image: nil, duration: 180),
                CookingStep(id: "5", stepNumber: 5, instruction: "Top with herbs and lime", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 145, protein: "22g", carbs: "8g", fat: "3g", fiber: "3g"),
            rating: 4.8,
            reviews: 267,
            mode: .weightLoss
        ))
        
        // Weight Loss Dinner
        expandedRecipes.append(Recipe(
            id: "weightloss_9",
            title: "Grilled Chicken with Asparagus",
            description: "Lean grilled chicken breast with roasted asparagus",
            heroImage: "fork.knife",
            cuisine: "Mediterranean",
            diet: "Gluten-Free",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Chicken Breast", quantity: "300", unit: "g"),
                Ingredient(id: "2", name: "Asparagus", quantity: "300", unit: "g"),
                Ingredient(id: "3", name: "Lemon", quantity: "1", unit: "pcs"),
                Ingredient(id: "4", name: "Garlic", quantity: "3", unit: "cloves"),
                Ingredient(id: "5", name: "Fresh Herbs", quantity: "20", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Marinate chicken with herbs and garlic", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Grill chicken 6 minutes per side", image: nil, duration: 720),
                CookingStep(id: "3", stepNumber: 3, instruction: "Roast asparagus at 200°C for 12 minutes", image: nil, duration: 720),
                CookingStep(id: "4", stepNumber: 4, instruction: "Serve with lemon wedges", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 215, protein: "38g", carbs: "8g", fat: "4g", fiber: "4g"),
            rating: 4.7,
            reviews: 198,
            mode: .weightLoss
        ))
        
        expandedRecipes.append(Recipe(
            id: "weightloss_10",
            title: "Cauliflower Steaks with Herbs",
            description: "Satisfying roasted cauliflower steaks",
            heroImage: "leaf.circle.fill",
            cuisine: "Mediterranean",
            diet: "Vegan",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 25,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Cauliflower", quantity: "1", unit: "head"),
                Ingredient(id: "2", name: "Cherry Tomatoes", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Kalamata Olives", quantity: "40", unit: "g"),
                Ingredient(id: "4", name: "Capers", quantity: "1", unit: "tbsp"),
                Ingredient(id: "5", name: "Fresh Parsley", quantity: "20", unit: "g"),
                Ingredient(id: "6", name: "Lemon", quantity: "1", unit: "pcs")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Slice cauliflower into thick steaks", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Roast at 220°C for 20 minutes", image: nil, duration: 1200),
                CookingStep(id: "3", stepNumber: 3, instruction: "Sauté tomatoes and olives", image: nil, duration: 240),
                CookingStep(id: "4", stepNumber: 4, instruction: "Top cauliflower with mixture", image: nil, duration: 120),
                CookingStep(id: "5", stepNumber: 5, instruction: "Garnish with parsley and lemon", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 125, protein: "5g", carbs: "18g", fat: "4g", fiber: "8g"),
            rating: 4.6,
            reviews: 176,
            mode: .weightLoss
        ))
        
        // Weight Loss Snacks
        expandedRecipes.append(Recipe(
            id: "weightloss_11",
            title: "Celery with Almond Butter",
            description: "Crunchy celery sticks with protein-rich almond butter",
            heroImage: "leaf.fill",
            cuisine: "American",
            diet: "Vegan",
            category: "Snacks",
            preparationTime: 5,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 1,
            ingredients: [
                Ingredient(id: "1", name: "Celery", quantity: "4", unit: "stalks"),
                Ingredient(id: "2", name: "Almond Butter", quantity: "2", unit: "tbsp"),
                Ingredient(id: "3", name: "Chia Seeds", quantity: "0.5", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Wash and cut celery", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Fill with almond butter", image: nil, duration: 90),
                CookingStep(id: "3", stepNumber: 3, instruction: "Sprinkle chia seeds", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 105, protein: "4g", carbs: "6g", fat: "9g", fiber: "3g"),
            rating: 4.3,
            reviews: 124,
            mode: .weightLoss
        ))
        
        expandedRecipes.append(Recipe(
            id: "weightloss_12",
            title: "Air-Popped Popcorn",
            description: "Light and filling air-popped popcorn",
            heroImage: "circle.fill",
            cuisine: "American",
            diet: "Vegan",
            category: "Snacks",
            preparationTime: 2,
            cookingTime: 5,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Popcorn Kernels", quantity: "60", unit: "g"),
                Ingredient(id: "2", name: "Nutritional Yeast", quantity: "1", unit: "tbsp"),
                Ingredient(id: "3", name: "Garlic Powder", quantity: "0.5", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Pop kernels in air popper", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Toss with nutritional yeast", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Season with garlic powder", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 95, protein: "4g", carbs: "18g", fat: "2g", fiber: "4g"),
            rating: 4.2,
            reviews: 156,
            mode: .weightLoss
        ))
        
        // Weight Loss Dessert
        expandedRecipes.append(Recipe(
            id: "weightloss_13",
            title: "Frozen Yogurt Berry Bites",
            description: "Low-calorie frozen yogurt treats",
            heroImage: "birthday.cake.fill",
            cuisine: "International",
            diet: "Gluten-Free",
            category: "Dessert",
            preparationTime: 10,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 8,
            ingredients: [
                Ingredient(id: "1", name: "Greek Yogurt", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Mixed Berries", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Vanilla Extract", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Mix yogurt with vanilla", image: nil, duration: 60),
                CookingStep(id: "2", stepNumber: 2, instruction: "Fold in chopped berries", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Spoon into mini muffin cups", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Freeze for 2 hours", image: nil, duration: 7200)
            ],
            nutrition: Nutrition(calories: 45, protein: "5g", carbs: "6g", fat: "1g", fiber: "1g"),
            rating: 4.6,
            reviews: 189,
            mode: .weightLoss
        ))
        
        // Weight Loss Beverages
        expandedRecipes.append(Recipe(
            id: "weightloss_14",
            title: "Lemon Ginger Water",
            description: "Metabolism-boosting infused water",
            heroImage: "cup.and.saucer.fill",
            cuisine: "International",
            diet: "Vegan",
            category: "Beverages",
            preparationTime: 5,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Lemon", quantity: "2", unit: "pcs"),
                Ingredient(id: "2", name: "Fresh Ginger", quantity: "3", unit: "slices"),
                Ingredient(id: "3", name: "Fresh Mint", quantity: "10", unit: "leaves"),
                Ingredient(id: "4", name: "Water", quantity: "1", unit: "l")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Slice lemons thinly", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add all ingredients to pitcher", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Refrigerate for 2 hours", image: nil, duration: 7200),
                CookingStep(id: "4", stepNumber: 4, instruction: "Serve cold", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 8, protein: "0g", carbs: "2g", fat: "0g", fiber: "0g"),
            rating: 4.5,
            reviews: 234,
            mode: .weightLoss
        ))
        
        // MARK: - WEIGHT GAIN MODE RECIPES (12 recipes)
        
        // Weight Gain Breakfast
        expandedRecipes.append(Recipe(
            id: "weightgain_6",
            title: "Protein Banana Pancakes",
            description: "High-calorie protein-packed banana pancakes",
            heroImage: "sunrise.fill",
            cuisine: "American",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 10,
            cookingTime: 15,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Oats", quantity: "150", unit: "g"),
                Ingredient(id: "2", name: "Bananas", quantity: "2", unit: "pcs"),
                Ingredient(id: "3", name: "Eggs", quantity: "3", unit: "pcs"),
                Ingredient(id: "4", name: "Protein Powder", quantity: "40", unit: "g"),
                Ingredient(id: "5", name: "Peanut Butter", quantity: "4", unit: "tbsp"),
                Ingredient(id: "6", name: "Whole Milk", quantity: "100", unit: "ml"),
                Ingredient(id: "7", name: "Honey", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Blend oats, bananas, eggs, protein powder and milk", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Let batter rest 5 minutes", image: nil, duration: 300),
                CookingStep(id: "3", stepNumber: 3, instruction: "Cook pancakes on buttered griddle", image: nil, duration: 480),
                CookingStep(id: "4", stepNumber: 4, instruction: "Top with peanut butter and honey", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 585, protein: "32g", carbs: "68g", fat: "20g", fiber: "8g"),
            rating: 4.8,
            reviews: 245,
            mode: .weightGain
        ))
        
        expandedRecipes.append(Recipe(
            id: "weightgain_7",
            title: "Loaded Breakfast Burrito",
            description: "Calorie-dense breakfast burrito with eggs and cheese",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "Mexican",
            diet: "None",
            category: "Breakfast",
            preparationTime: 15,
            cookingTime: 10,
            difficulty: "Medium",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Large Tortillas", quantity: "2", unit: "pcs"),
                Ingredient(id: "2", name: "Eggs", quantity: "4", unit: "pcs"),
                Ingredient(id: "3", name: "Cheddar Cheese", quantity: "100", unit: "g"),
                Ingredient(id: "4", name: "Breakfast Sausage", quantity: "150", unit: "g"),
                Ingredient(id: "5", name: "Avocado", quantity: "1", unit: "pcs"),
                Ingredient(id: "6", name: "Sour Cream", quantity: "4", unit: "tbsp"),
                Ingredient(id: "7", name: "Hash Browns", quantity: "150", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cook sausage and hash browns", image: nil, duration: 360),
                CookingStep(id: "2", stepNumber: 2, instruction: "Scramble eggs with cheese", image: nil, duration: 240),
                CookingStep(id: "3", stepNumber: 3, instruction: "Warm tortillas", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Fill with all ingredients", image: nil, duration: 180),
                CookingStep(id: "5", stepNumber: 5, instruction: "Roll burrito and serve with sour cream", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 725, protein: "35g", carbs: "52g", fat: "40g", fiber: "6g"),
            rating: 4.9,
            reviews: 312,
            mode: .weightGain
        ))
        
        // Weight Gain Lunch
        expandedRecipes.append(Recipe(
            id: "weightgain_8",
            title: "Loaded Chicken Quesadilla",
            description: "High-protein quesadilla with chicken and cheese",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "Mexican",
            diet: "None",
            category: "Lunch",
            preparationTime: 15,
            cookingTime: 12,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Large Flour Tortillas", quantity: "4", unit: "pcs"),
                Ingredient(id: "2", name: "Cooked Chicken Breast", quantity: "300", unit: "g"),
                Ingredient(id: "3", name: "Mixed Cheese", quantity: "200", unit: "g"),
                Ingredient(id: "4", name: "Bell Peppers", quantity: "1", unit: "pcs"),
                Ingredient(id: "5", name: "Onion", quantity: "1", unit: "pcs"),
                Ingredient(id: "6", name: "Sour Cream", quantity: "100", unit: "g"),
                Ingredient(id: "7", name: "Guacamole", quantity: "100", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Sauté peppers and onions", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Layer tortilla with cheese, chicken and vegetables", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Top with another tortilla", image: nil, duration: 30),
                CookingStep(id: "4", stepNumber: 4, instruction: "Cook on griddle until golden", image: nil, duration: 360),
                CookingStep(id: "5", stepNumber: 5, instruction: "Serve with sour cream and guacamole", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 695, protein: "45g", carbs: "58g", fat: "30g", fiber: "6g"),
            rating: 4.8,
            reviews: 276,
            mode: .weightGain
        ))
        
        expandedRecipes.append(Recipe(
            id: "weightgain_9",
            title: "Beef and Rice Bowl",
            description: "Hearty ground beef with rice and vegetables",
            heroImage: "fork.knife",
            cuisine: "Asian",
            diet: "None",
            category: "Lunch",
            preparationTime: 10,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Ground Beef", quantity: "500", unit: "g"),
                Ingredient(id: "2", name: "White Rice", quantity: "300", unit: "g"),
                Ingredient(id: "3", name: "Broccoli", quantity: "200", unit: "g"),
                Ingredient(id: "4", name: "Carrots", quantity: "2", unit: "pcs"),
                Ingredient(id: "5", name: "Soy Sauce", quantity: "3", unit: "tbsp"),
                Ingredient(id: "6", name: "Sesame Oil", quantity: "2", unit: "tbsp"),
                Ingredient(id: "7", name: "Garlic", quantity: "4", unit: "cloves")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cook rice according to package", image: nil, duration: 900),
                CookingStep(id: "2", stepNumber: 2, instruction: "Brown ground beef with garlic", image: nil, duration: 480),
                CookingStep(id: "3", stepNumber: 3, instruction: "Steam broccoli and carrots", image: nil, duration: 360),
                CookingStep(id: "4", stepNumber: 4, instruction: "Combine everything with sauce", image: nil, duration: 180),
                CookingStep(id: "5", stepNumber: 5, instruction: "Drizzle with sesame oil", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 625, protein: "38g", carbs: "65g", fat: "22g", fiber: "5g"),
            rating: 4.7,
            reviews: 198,
            mode: .weightGain
        ))
        
        // Weight Gain Dinner
        expandedRecipes.append(Recipe(
            id: "weightgain_10",
            title: "Creamy Pasta Carbonara",
            description: "Rich and creamy bacon carbonara",
            heroImage: "fork.knife",
            cuisine: "Italian",
            diet: "None",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 20,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Spaghetti", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Bacon", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Eggs", quantity: "4", unit: "pcs"),
                Ingredient(id: "4", name: "Parmesan", quantity: "150", unit: "g"),
                Ingredient(id: "5", name: "Heavy Cream", quantity: "200", unit: "ml"),
                Ingredient(id: "6", name: "Garlic", quantity: "4", unit: "cloves")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cook pasta in salted water", image: nil, duration: 600),
                CookingStep(id: "2", stepNumber: 2, instruction: "Fry bacon until crispy", image: nil, duration: 360),
                CookingStep(id: "3", stepNumber: 3, instruction: "Whisk eggs, cream and parmesan", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Toss hot pasta with egg mixture", image: nil, duration: 120),
                CookingStep(id: "5", stepNumber: 5, instruction: "Add bacon and serve immediately", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 685, protein: "32g", carbs: "72g", fat: "28g", fiber: "3g"),
            rating: 4.9,
            reviews: 345,
            mode: .weightGain
        ))
        
        expandedRecipes.append(Recipe(
            id: "weightgain_11",
            title: "Salmon with Sweet Potato",
            description: "Omega-rich salmon with roasted sweet potato",
            heroImage: "fish.fill",
            cuisine: "American",
            diet: "Gluten-Free",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 25,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Salmon Fillets", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Sweet Potatoes", quantity: "400", unit: "g"),
                Ingredient(id: "3", name: "Butter", quantity: "40", unit: "g"),
                Ingredient(id: "4", name: "Brown Sugar", quantity: "2", unit: "tbsp"),
                Ingredient(id: "5", name: "Pecans", quantity: "50", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cube sweet potatoes and roast", image: nil, duration: 1500),
                CookingStep(id: "2", stepNumber: 2, instruction: "Season salmon with herbs", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Pan-sear salmon with butter", image: nil, duration: 480),
                CookingStep(id: "4", stepNumber: 4, instruction: "Toss potatoes with brown sugar and pecans", image: nil, duration: 180)
            ],
            nutrition: Nutrition(calories: 615, protein: "42g", carbs: "52g", fat: "27g", fiber: "7g"),
            rating: 4.8,
            reviews: 234,
            mode: .weightGain
        ))
        
        // Weight Gain Snacks
        expandedRecipes.append(Recipe(
            id: "weightgain_12",
            title: "Trail Mix Energy Balls",
            description: "Calorie-dense energy balls with nuts and dates",
            heroImage: "circle.fill",
            cuisine: "International",
            diet: "Vegan",
            category: "Snacks",
            preparationTime: 15,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 12,
            ingredients: [
                Ingredient(id: "1", name: "Dates", quantity: "200", unit: "g"),
                Ingredient(id: "2", name: "Almonds", quantity: "100", unit: "g"),
                Ingredient(id: "3", name: "Cashews", quantity: "100", unit: "g"),
                Ingredient(id: "4", name: "Peanut Butter", quantity: "80", unit: "g"),
                Ingredient(id: "5", name: "Oats", quantity: "100", unit: "g"),
                Ingredient(id: "6", name: "Chocolate Chips", quantity: "80", unit: "g"),
                Ingredient(id: "7", name: "Chia Seeds", quantity: "3", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Process dates until sticky", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add nuts, oats, peanut butter", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Mix in chocolate chips and chia", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Roll into balls and refrigerate", image: nil, duration: 360)
            ],
            nutrition: Nutrition(calories: 185, protein: "5g", carbs: "22g", fat: "10g", fiber: "3g"),
            rating: 4.7,
            reviews: 289,
            mode: .weightGain
        ))
        
        expandedRecipes.append(Recipe(
            id: "weightgain_13",
            title: "Cheese and Crackers Plate",
            description: "High-calorie cheese board with crackers and nuts",
            heroImage: "square.grid.3x3.fill",
            cuisine: "French",
            diet: "Vegetarian",
            category: "Snacks",
            preparationTime: 10,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Aged Cheddar", quantity: "100", unit: "g"),
                Ingredient(id: "2", name: "Brie", quantity: "100", unit: "g"),
                Ingredient(id: "3", name: "Whole Grain Crackers", quantity: "100", unit: "g"),
                Ingredient(id: "4", name: "Mixed Nuts", quantity: "80", unit: "g"),
                Ingredient(id: "5", name: "Honey", quantity: "3", unit: "tbsp"),
                Ingredient(id: "6", name: "Dried Fruit", quantity: "60", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Arrange cheeses on board", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add crackers and nuts", image: nil, duration: 90),
                CookingStep(id: "3", stepNumber: 3, instruction: "Drizzle honey over cheese", image: nil, duration: 30),
                CookingStep(id: "4", stepNumber: 4, instruction: "Garnish with dried fruit", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 565, protein: "22g", carbs: "45g", fat: "35g", fiber: "5g"),
            rating: 4.6,
            reviews: 178,
            mode: .weightGain
        ))
        
        // Weight Gain Dessert
        expandedRecipes.append(Recipe(
            id: "weightgain_14",
            title: "Chocolate Peanut Butter Shake",
            description: "Ultra high-calorie protein shake",
            heroImage: "cup.and.saucer.fill",
            cuisine: "American",
            diet: "Vegetarian",
            category: "Beverages",
            preparationTime: 5,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 1,
            ingredients: [
                Ingredient(id: "1", name: "Whole Milk", quantity: "400", unit: "ml"),
                Ingredient(id: "2", name: "Peanut Butter", quantity: "4", unit: "tbsp"),
                Ingredient(id: "3", name: "Chocolate Protein Powder", quantity: "60", unit: "g"),
                Ingredient(id: "4", name: "Banana", quantity: "1", unit: "pcs"),
                Ingredient(id: "5", name: "Oats", quantity: "50", unit: "g"),
                Ingredient(id: "6", name: "Honey", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Add all ingredients to blender", image: nil, duration: 60),
                CookingStep(id: "2", stepNumber: 2, instruction: "Blend on high until smooth", image: nil, duration: 90),
                CookingStep(id: "3", stepNumber: 3, instruction: "Pour into large glass", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 825, protein: "48g", carbs: "92g", fat: "32g", fiber: "10g"),
            rating: 4.9,
            reviews: 412,
            mode: .weightGain
        ))
        
        expandedRecipes.append(Recipe(
            id: "weightgain_15",
            title: "Tiramisu",
            description: "Classic Italian tiramisu dessert",
            heroImage: "birthday.cake.fill",
            cuisine: "Italian",
            diet: "Vegetarian",
            category: "Dessert",
            preparationTime: 30,
            cookingTime: 0,
            difficulty: "Medium",
            servings: 8,
            ingredients: [
                Ingredient(id: "1", name: "Ladyfinger Cookies", quantity: "300", unit: "g"),
                Ingredient(id: "2", name: "Mascarpone", quantity: "500", unit: "g"),
                Ingredient(id: "3", name: "Eggs", quantity: "4", unit: "pcs"),
                Ingredient(id: "4", name: "Sugar", quantity: "150", unit: "g"),
                Ingredient(id: "5", name: "Strong Coffee", quantity: "300", unit: "ml"),
                Ingredient(id: "6", name: "Cocoa Powder", quantity: "3", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Separate eggs and beat yolks with sugar", image: nil, duration: 240),
                CookingStep(id: "2", stepNumber: 2, instruction: "Fold in mascarpone", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Whip egg whites and fold in", image: nil, duration: 300),
                CookingStep(id: "4", stepNumber: 4, instruction: "Dip ladyfingers in coffee", image: nil, duration: 360),
                CookingStep(id: "5", stepNumber: 5, instruction: "Layer cookies and cream", image: nil, duration: 420),
                CookingStep(id: "6", stepNumber: 6, instruction: "Dust with cocoa and chill 4 hours", image: nil, duration: 14400)
            ],
            nutrition: Nutrition(calories: 445, protein: "9g", carbs: "42g", fat: "27g", fiber: "1g"),
            rating: 4.9,
            reviews: 387,
            mode: .weightGain
        ))
        
        // Add all expanded recipes to the main recipes array
        self.recipes.append(contentsOf: expandedRecipes)
        saveRecipes()
    }
}
