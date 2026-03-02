import Foundation

// MARK: - Health Mode Recipes

extension LocalDatabaseManager {
    
    // Load health mode specific recipes
    func loadHealthModeRecipes() {
        var modeRecipes: [Recipe] = []
        
        // MARK: - Diabetic Mode Recipes
        
        modeRecipes.append(Recipe(
            id: "diabetic_1",
            title: "Oats Vegetable Upma",
            description: "Nutritious savory oats with vegetables, perfect for diabetics",
            heroImage: "leaf.circle.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 10,
            cookingTime: 15,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Oats", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "medium"),
                Ingredient(id: "3", name: "Carrot", quantity: "1", unit: "small"),
                Ingredient(id: "4", name: "Green Peas", quantity: "1/4", unit: "cup"),
                Ingredient(id: "5", name: "Curry Leaves", quantity: "8-10", unit: "leaves"),
                Ingredient(id: "6", name: "Mustard Seeds", quantity: "1/2", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Dry roast oats until aromatic", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat oil, add mustard seeds and curry leaves", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add chopped vegetables and sauté", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add water and bring to boil", image: nil, duration: 180),
                CookingStep(id: "5", stepNumber: 5, instruction: "Add roasted oats and cook until done", image: nil, duration: 420)
            ],
            nutrition: Nutrition(calories: 180, protein: "8g", carbs: "28g", fat: "4g", fiber: "6g"),
            rating: 4.5,
            reviews: 89,
            mode: .diabetic
        ))
        
        modeRecipes.append(Recipe(
            id: "diabetic_2",
            title: "Ragi Dosa",
            description: "Healthy finger millet dosa, low glycemic index",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Breakfast",
            preparationTime: 480,
            cookingTime: 20,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Ragi Flour", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Rice Flour", quantity: "1/2", unit: "cup"),
                Ingredient(id: "3", name: "Curd", quantity: "1/2", unit: "cup"),
                Ingredient(id: "4", name: "Onion", quantity: "1", unit: "small"),
                Ingredient(id: "5", name: "Green Chili", quantity: "2", unit: "pcs")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Mix ragi flour, rice flour, and curd", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Ferment for 8 hours", image: nil, duration: 28800),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add chopped onions and chilies", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Make thin dosas on hot griddle", image: nil, duration: 720)
            ],
            nutrition: Nutrition(calories: 165, protein: "6g", carbs: "32g", fat: "2g", fiber: "4g"),
            rating: 4.7,
            reviews: 124,
            mode: .diabetic
        ))
        
        modeRecipes.append(Recipe(
            id: "diabetic_3",
            title: "Sprouts Salad",
            description: "Fresh mixed sprouts with lemon dressing",
            heroImage: "leaf.fill",
            cuisine: "International",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 10,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Mixed Sprouts", quantity: "2", unit: "cups"),
                Ingredient(id: "2", name: "Cucumber", quantity: "1", unit: "medium"),
                Ingredient(id: "3", name: "Tomato", quantity: "1", unit: "medium"),
                Ingredient(id: "4", name: "Lemon Juice", quantity: "2", unit: "tbsp"),
                Ingredient(id: "5", name: "Mint Leaves", quantity: "10", unit: "leaves")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Steam sprouts lightly", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Chop vegetables", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Mix all ingredients", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add lemon juice and serve", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 120, protein: "9g", carbs: "18g", fat: "1g", fiber: "7g"),
            rating: 4.6,
            reviews: 78,
            mode: .diabetic
        ))
        
        modeRecipes.append(Recipe(
            id: "diabetic_4",
            title: "Bitter Gourd Stir Fry",
            description: "Traditional Indian bitter gourd preparation",
            heroImage: "leaf.circle",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 20,
            difficulty: "Medium",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Bitter Gourd", quantity: "250", unit: "g"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "medium"),
                Ingredient(id: "3", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "4", name: "Cumin Seeds", quantity: "1/2", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Slice bitter gourd and soak in salt water", image: nil, duration: 600),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat oil and add cumin seeds", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add bitter gourd and cook covered", image: nil, duration: 900),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add spices and cook until crispy", image: nil, duration: 300)
            ],
            nutrition: Nutrition(calories: 85, protein: "3g", carbs: "12g", fat: "3g", fiber: "5g"),
            rating: 4.2,
            reviews: 56,
            mode: .diabetic
        ))
        
        modeRecipes.append(Recipe(
            id: "diabetic_5",
            title: "Moong Dal Soup",
            description: "Light and nutritious yellow lentil soup",
            heroImage: "drop.circle.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 25,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Moong Dal", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Tomato", quantity: "2", unit: "medium"),
                Ingredient(id: "3", name: "Ginger", quantity: "1", unit: "inch"),
                Ingredient(id: "4", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "5", name: "Spinach", quantity: "1", unit: "cup")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Pressure cook moong dal with turmeric", image: nil, duration: 900),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add tomatoes and ginger", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Simmer for 10 minutes", image: nil, duration: 600),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add spinach and serve hot", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 155, protein: "11g", carbs: "25g", fat: "1g", fiber: "8g"),
            rating: 4.8,
            reviews: 142,
            mode: .diabetic
        ))
        
        // MARK: - Heart Care Mode Recipes
        
        modeRecipes.append(Recipe(
            id: "heart_1",
            title: "Grilled Paneer with Veggies",
            description: "Healthy grilled cottage cheese with colorful vegetables",
            heroImage: "flame.fill",
            cuisine: "Continental",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Paneer", quantity: "200", unit: "g"),
                Ingredient(id: "2", name: "Bell Peppers", quantity: "2", unit: "medium"),
                Ingredient(id: "3", name: "Zucchini", quantity: "1", unit: "medium"),
                Ingredient(id: "4", name: "Olive Oil", quantity: "1", unit: "tbsp"),
                Ingredient(id: "5", name: "Italian Herbs", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cut paneer and vegetables into cubes", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Marinate with olive oil and herbs", image: nil, duration: 600),
                CookingStep(id: "3", stepNumber: 3, instruction: "Thread onto skewers", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Grill until golden brown", image: nil, duration: 720)
            ],
            nutrition: Nutrition(calories: 245, protein: "18g", carbs: "12g", fat: "14g", fiber: "3g"),
            rating: 4.7,
            reviews: 98,
            mode: .heartCare
        ))
        
        modeRecipes.append(Recipe(
            id: "heart_2",
            title: "Tomato Lentil Soup",
            description: "Heart-healthy tomato and red lentil soup",
            heroImage: "drop.circle.fill",
            cuisine: "Mediterranean",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 10,
            cookingTime: 30,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Red Lentils", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Tomatoes", quantity: "4", unit: "large"),
                Ingredient(id: "3", name: "Garlic", quantity: "3", unit: "cloves"),
                Ingredient(id: "4", name: "Olive Oil", quantity: "1", unit: "tbsp"),
                Ingredient(id: "5", name: "Basil", quantity: "10", unit: "leaves")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Sauté garlic in olive oil", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add tomatoes and cook until soft", image: nil, duration: 480),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add lentils and water, simmer", image: nil, duration: 1200),
                CookingStep(id: "4", stepNumber: 4, instruction: "Blend smooth and garnish with basil", image: nil, duration: 180)
            ],
            nutrition: Nutrition(calories: 185, protein: "12g", carbs: "30g", fat: "3g", fiber: "9g"),
            rating: 4.6,
            reviews: 134,
            mode: .heartCare
        ))
        
        modeRecipes.append(Recipe(
            id: "heart_3",
            title: "Quinoa Salad",
            description: "Fresh quinoa bowl with Mediterranean flavors",
            heroImage: "leaf.arrow.circlepath",
            cuisine: "Mediterranean",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 15,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Quinoa", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Cherry Tomatoes", quantity: "1", unit: "cup"),
                Ingredient(id: "3", name: "Cucumber", quantity: "1", unit: "medium"),
                Ingredient(id: "4", name: "Olive Oil", quantity: "2", unit: "tbsp"),
                Ingredient(id: "5", name: "Lemon Juice", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cook quinoa according to package", image: nil, duration: 900),
                CookingStep(id: "2", stepNumber: 2, instruction: "Let quinoa cool completely", image: nil, duration: 600),
                CookingStep(id: "3", stepNumber: 3, instruction: "Chop vegetables", image: nil, duration: 300),
                CookingStep(id: "4", stepNumber: 4, instruction: "Mix all ingredients with dressing", image: nil, duration: 180)
            ],
            nutrition: Nutrition(calories: 220, protein: "8g", carbs: "35g", fat: "6g", fiber: "5g"),
            rating: 4.8,
            reviews: 167,
            mode: .heartCare
        ))
        
        modeRecipes.append(Recipe(
            id: "heart_4",
            title: "Spinach Dal",
            description: "Iron-rich spinach and lentil curry",
            heroImage: "leaf.circle.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 25,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Toor Dal", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Spinach", quantity: "2", unit: "cups"),
                Ingredient(id: "3", name: "Tomato", quantity: "2", unit: "medium"),
                Ingredient(id: "4", name: "Turmeric", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "5", name: "Cumin", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Pressure cook dal with turmeric", image: nil, duration: 900),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add chopped spinach and tomatoes", image: nil, duration: 300),
                CookingStep(id: "3", stepNumber: 3, instruction: "Simmer for 10 minutes", image: nil, duration: 600),
                CookingStep(id: "4", stepNumber: 4, instruction: "Temper with cumin and serve", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 190, protein: "13g", carbs: "32g", fat: "2g", fiber: "10g"),
            rating: 4.7,
            reviews: 145,
            mode: .heartCare
        ))
        
        // MARK: - Weight Loss Mode Recipes
        
        modeRecipes.append(Recipe(
            id: "weightloss_1",
            title: "Cucumber Mint Salad",
            description: "Refreshing low-calorie salad",
            heroImage: "leaf.fill",
            cuisine: "International",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 10,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Cucumber", quantity: "2", unit: "large"),
                Ingredient(id: "2", name: "Mint Leaves", quantity: "1/4", unit: "cup"),
                Ingredient(id: "3", name: "Lemon Juice", quantity: "2", unit: "tbsp"),
                Ingredient(id: "4", name: "Chat Masala", quantity: "1/2", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Dice cucumber into small pieces", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Chop mint leaves finely", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Mix all ingredients", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Chill and serve", image: nil, duration: 300)
            ],
            nutrition: Nutrition(calories: 45, protein: "2g", carbs: "9g", fat: "0g", fiber: "2g"),
            rating: 4.4,
            reviews: 87,
            mode: .weightLoss
        ))
        
        modeRecipes.append(Recipe(
            id: "weightloss_2",
            title: "Vegetable Soup Bowl",
            description: "Nutrient-packed low-calorie soup",
            heroImage: "drop.circle.fill",
            cuisine: "International",
            diet: "Vegan",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 25,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Broccoli", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Carrot", quantity: "2", unit: "medium"),
                Ingredient(id: "3", name: "Celery", quantity: "2", unit: "stalks"),
                Ingredient(id: "4", name: "Cabbage", quantity: "1", unit: "cup"),
                Ingredient(id: "5", name: "Vegetable Broth", quantity: "4", unit: "cups")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Chop all vegetables", image: nil, duration: 420),
                CookingStep(id: "2", stepNumber: 2, instruction: "Bring broth to boil", image: nil, duration: 300),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add vegetables and simmer", image: nil, duration: 1200),
                CookingStep(id: "4", stepNumber: 4, instruction: "Season and serve hot", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 85, protein: "4g", carbs: "16g", fat: "1g", fiber: "6g"),
            rating: 4.5,
            reviews: 112,
            mode: .weightLoss
        ))
        
        modeRecipes.append(Recipe(
            id: "weightloss_3",
            title: "Millet Khichdi",
            description: "Wholesome one-pot meal with millets",
            heroImage: "circle.grid.2x2.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 30,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Foxtail Millet", quantity: "1/2", unit: "cup"),
                Ingredient(id: "2", name: "Moong Dal", quantity: "1/4", unit: "cup"),
                Ingredient(id: "3", name: "Mixed Vegetables", quantity: "1", unit: "cup"),
                Ingredient(id: "4", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "5", name: "Cumin Seeds", quantity: "1/2", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Wash millet and dal", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Pressure cook with vegetables", image: nil, duration: 1200),
                CookingStep(id: "3", stepNumber: 3, instruction: "Temper with cumin seeds", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Mix well and serve", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 195, protein: "9g", carbs: "35g", fat: "2g", fiber: "7g"),
            rating: 4.6,
            reviews: 98,
            mode: .weightLoss
        ))
        
        modeRecipes.append(Recipe(
            id: "weightloss_4",
            title: "Egg White Omelette",
            description: "Protein-rich low-fat breakfast",
            heroImage: "circle.fill",
            cuisine: "International",
            diet: "Gluten-Free",
            category: "Breakfast",
            preparationTime: 5,
            cookingTime: 10,
            difficulty: "Easy",
            servings: 1,
            ingredients: [
                Ingredient(id: "1", name: "Egg Whites", quantity: "4", unit: "pcs"),
                Ingredient(id: "2", name: "Tomato", quantity: "1", unit: "small"),
                Ingredient(id: "3", name: "Spinach", quantity: "1/4", unit: "cup"),
                Ingredient(id: "4", name: "Bell Pepper", quantity: "1/4", unit: "cup")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Beat egg whites until frothy", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Chop vegetables", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Pour eggs on heated pan", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add vegetables and fold", image: nil, duration: 240)
            ],
            nutrition: Nutrition(calories: 95, protein: "18g", carbs: "6g", fat: "0g", fiber: "2g"),
            rating: 4.3,
            reviews: 76,
            mode: .weightLoss
        ))
        
        // MARK: - Weight Gain Mode Recipes
        
        modeRecipes.append(Recipe(
            id: "weightgain_1",
            title: "Peanut Butter Banana Smoothie",
            description: "High-calorie protein smoothie",
            heroImage: "cup.and.saucer.fill",
            cuisine: "International",
            diet: "Vegetarian",
            category: "Snacks",
            preparationTime: 5,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 1,
            ingredients: [
                Ingredient(id: "1", name: "Banana", quantity: "2", unit: "large"),
                Ingredient(id: "2", name: "Peanut Butter", quantity: "2", unit: "tbsp"),
                Ingredient(id: "3", name: "Milk", quantity: "1", unit: "cup"),
                Ingredient(id: "4", name: "Oats", quantity: "2", unit: "tbsp"),
                Ingredient(id: "5", name: "Honey", quantity: "1", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Add all ingredients to blender", image: nil, duration: 60),
                CookingStep(id: "2", stepNumber: 2, instruction: "Blend until smooth", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Pour into glass and serve", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 485, protein: "18g", carbs: "72g", fat: "16g", fiber: "8g"),
            rating: 4.9,
            reviews: 234,
            mode: .weightGain
        ))
        
        modeRecipes.append(Recipe(
            id: "weightgain_2",
            title: "Paneer Paratha",
            description: "Stuffed flatbread with cottage cheese",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 20,
            cookingTime: 25,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Whole Wheat Flour", quantity: "2", unit: "cups"),
                Ingredient(id: "2", name: "Paneer", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Ghee", quantity: "3", unit: "tbsp"),
                Ingredient(id: "4", name: "Cumin Powder", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Knead dough with flour and water", image: nil, duration: 600),
                CookingStep(id: "2", stepNumber: 2, instruction: "Mash paneer with spices", image: nil, duration: 300),
                CookingStep(id: "3", stepNumber: 3, instruction: "Stuff and roll parathas", image: nil, duration: 720),
                CookingStep(id: "4", stepNumber: 4, instruction: "Cook with ghee until golden", image: nil, duration: 480)
            ],
            nutrition: Nutrition(calories: 380, protein: "15g", carbs: "45g", fat: "16g", fiber: "6g"),
            rating: 4.8,
            reviews: 189,
            mode: .weightGain
        ))
        
        modeRecipes.append(Recipe(
            id: "weightgain_3",
            title: "Sweet Potato Mash",
            description: "Creamy nutrient-dense side dish",
            heroImage: "leaf.arrow.triangle.circlepath",
            cuisine: "International",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 30,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Sweet Potato", quantity: "500", unit: "g"),
                Ingredient(id: "2", name: "Butter", quantity: "2", unit: "tbsp"),
                Ingredient(id: "3", name: "Milk", quantity: "1/4", unit: "cup"),
                Ingredient(id: "4", name: "Cinnamon", quantity: "1/4", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Boil sweet potatoes until tender", image: nil, duration: 1200),
                CookingStep(id: "2", stepNumber: 2, instruction: "Peel and mash", image: nil, duration: 300),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add butter, milk, and cinnamon", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Mix until creamy and serve", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 295, protein: "4g", carbs: "52g", fat: "8g", fiber: "7g"),
            rating: 4.7,
            reviews: 156,
            mode: .weightGain
        ))
        
        modeRecipes.append(Recipe(
            id: "weightgain_4",
            title: "Almond Milkshake",
            description: "Rich and creamy high-calorie drink",
            heroImage: "cup.and.saucer.fill",
            cuisine: "International",
            diet: "Vegetarian",
            category: "Beverages",
            preparationTime: 5,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Almonds", quantity: "1/2", unit: "cup"),
                Ingredient(id: "2", name: "Milk", quantity: "2", unit: "cups"),
                Ingredient(id: "3", name: "Dates", quantity: "4", unit: "pcs"),
                Ingredient(id: "4", name: "Vanilla Extract", quantity: "1/2", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Soak almonds for 4 hours", image: nil, duration: 14400),
                CookingStep(id: "2", stepNumber: 2, instruction: "Blend with milk and dates", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add vanilla and blend again", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Serve chilled", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 340, protein: "12g", carbs: "38g", fat: "16g", fiber: "6g"),
            rating: 4.8,
            reviews: 203,
            mode: .weightGain
        ))
        
        modeRecipes.append(Recipe(
            id: "weightgain_5",
            title: "Chickpea Curry",
            description: "Protein-rich creamy curry",
            heroImage: "drop.circle.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 35,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Chickpeas", quantity: "2", unit: "cups"),
                Ingredient(id: "2", name: "Tomato", quantity: "3", unit: "large"),
                Ingredient(id: "3", name: "Coconut Milk", quantity: "1", unit: "cup"),
                Ingredient(id: "4", name: "Garam Masala", quantity: "1", unit: "tsp"),
                Ingredient(id: "5", name: "Ginger Garlic Paste", quantity: "1", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Sauté ginger garlic paste", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add tomatoes and cook", image: nil, duration: 480),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add chickpeas and spices", image: nil, duration: 300),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add coconut milk and simmer", image: nil, duration: 1200)
            ],
            nutrition: Nutrition(calories: 385, protein: "18g", carbs: "52g", fat: "14g", fiber: "12g"),
            rating: 4.9,
            reviews: 267,
            mode: .weightGain
        ))
        
        // Add all mode recipes to the main recipes array
        recipes.append(contentsOf: modeRecipes)
    }
}
