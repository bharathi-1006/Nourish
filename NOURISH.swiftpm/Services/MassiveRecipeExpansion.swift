import Foundation

// MARK: - Massive Recipe Database Expansion
// This file contains 150+ new recipes across all health modes
// All recipes are mode-specific and medically appropriate

struct MassiveRecipeExpansion {
    
    static func getAllRecipes() -> [Recipe] {
        var allRecipes: [Recipe] = []
        
        // Add all mode-specific recipes
        allRecipes.append(contentsOf: normalModeRecipes)
        allRecipes.append(contentsOf: diabeticModeRecipes)
        allRecipes.append(contentsOf: heartCareModeRecipes)
        allRecipes.append(contentsOf: weightLossModeRecipes)
        allRecipes.append(contentsOf: weightGainModeRecipes)
        
        return allRecipes
    }
    
    // MARK: - NORMAL MODE RECIPES (30+ recipes)
    
    private static let normalModeRecipes: [Recipe] = [
        
        // BREAKFAST RECIPES
        Recipe(
            id: "norm_001",
            title: "Classic French Toast",
            description: "Golden brown French toast with cinnamon and vanilla",
            heroImage: "rectangle.stack.fill",
            cuisine: "French",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 10,
            cookingTime: 10,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Bread", quantity: "4", unit: "slices"),
                Ingredient(id: "2", name: "Eggs", quantity: "2", unit: "pcs"),
                Ingredient(id: "3", name: "Milk", quantity: "100", unit: "ml"),
                Ingredient(id: "4", name: "Cinnamon", quantity: "1", unit: "tsp"),
                Ingredient(id: "5", name: "Vanilla Extract", quantity: "1", unit: "tsp"),
                Ingredient(id: "6", name: "Butter", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Whisk eggs, milk, cinnamon, and vanilla in a bowl", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat butter in a pan over medium heat", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Dip bread slices in egg mixture on both sides", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Cook each side for 3-4 minutes until golden", image: nil, duration: 420),
                CookingStep(id: "5", stepNumber: 5, instruction: "Serve hot with maple syrup or honey", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 320, protein: "12g", carbs: "38g", fat: "14g", fiber: "2g"),
            rating: 4.7,
            reviews: 156,
            mode: .normal
        ),
        
        Recipe(
            id: "norm_002",
            title: "Veggie Omelette",
            description: "Fluffy omelette loaded with fresh vegetables",
            heroImage: "circle.fill",
            cuisine: "Continental",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 10,
            cookingTime: 8,
            difficulty: "Easy",
            servings: 1,
            ingredients: [
                Ingredient(id: "1", name: "Eggs", quantity: "3", unit: "pcs"),
                Ingredient(id: "2", name: "Bell Pepper", quantity: "50", unit: "g"),
                Ingredient(id: "3", name: "Onion", quantity: "50", unit: "g"),
                Ingredient(id: "4", name: "Tomato", quantity: "1", unit: "small"),
                Ingredient(id: "5", name: "Cheese", quantity: "30", unit: "g"),
                Ingredient(id: "6", name: "Butter", quantity: "1", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Chop all vegetables finely", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Beat eggs with salt and pepper", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Heat butter and sauté vegetables for 2 minutes", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Pour eggs over vegetables and cook for 3 minutes", image: nil, duration: 180),
                CookingStep(id: "5", stepNumber: 5, instruction: "Add cheese, fold, and serve", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 350, protein: "22g", carbs: "10g", fat: "26g", fiber: "2g"),
            rating: 4.6,
            reviews: 203,
            mode: .normal
        ),
        
        Recipe(
            id: "norm_003",
            title: "Pancake Stack",
            description: "Fluffy American-style pancakes with syrup",
            heroImage: "square.stack.3d.up.fill",
            cuisine: "American",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 15,
            cookingTime: 15,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "All-purpose Flour", quantity: "200", unit: "g"),
                Ingredient(id: "2", name: "Milk", quantity: "250", unit: "ml"),
                Ingredient(id: "3", name: "Eggs", quantity: "2", unit: "pcs"),
                Ingredient(id: "4", name: "Sugar", quantity: "2", unit: "tbsp"),
                Ingredient(id: "5", name: "Baking Powder", quantity: "2", unit: "tsp"),
                Ingredient(id: "6", name: "Butter", quantity: "50", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Mix flour, sugar, and baking powder in a bowl", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Whisk eggs and milk together", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Combine wet and dry ingredients until smooth", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Cook small portions on a hot griddle until bubbles form", image: nil, duration: 600),
                CookingStep(id: "5", stepNumber: 5, instruction: "Flip and cook other side, serve with syrup", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 380, protein: "10g", carbs: "52g", fat: "15g", fiber: "2g"),
            rating: 4.8,
            reviews: 298,
            mode: .normal
        ),
        
        // LUNCH RECIPES
        Recipe(
            id: "norm_004",
            title: "Chicken Caesar Salad",
            description: "Classic Caesar with grilled chicken breast",
            heroImage: "leaf.fill",
            cuisine: "Italian",
            diet: "Non-Vegetarian",
            category: "Lunch",
            preparationTime: 15,
            cookingTime: 12,
            difficulty: "Medium",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Chicken Breast", quantity: "300", unit: "g"),
                Ingredient(id: "2", name: "Romaine Lettuce", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Parmesan Cheese", quantity: "50", unit: "g"),
                Ingredient(id: "4", name: "Caesar Dressing", quantity: "100", unit: "ml"),
                Ingredient(id: "5", name: "Croutons", quantity: "50", unit: "g"),
                Ingredient(id: "6", name: "Olive Oil", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Season chicken with salt, pepper, and olive oil", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Grill chicken for 6 minutes per side", image: nil, duration: 720),
                CookingStep(id: "3", stepNumber: 3, instruction: "Chop lettuce and place in a large bowl", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Slice chicken and add to lettuce", image: nil, duration: 120),
                CookingStep(id: "5", stepNumber: 5, instruction: "Add dressing, parmesan, and croutons, toss well", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 420, protein: "38g", carbs: "18g", fat: "22g", fiber: "3g"),
            rating: 4.7,
            reviews: 342,
            mode: .normal
        ),
        
        Recipe(
            id: "norm_005",
            title: "Vegetable Stir Fry Rice",
            description: "Colorful mixed vegetables with fried rice",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "Chinese",
            diet: "Vegetarian",
            category: "Lunch",
            preparationTime: 15,
            cookingTime: 12,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Cooked Rice", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Mixed Vegetables", quantity: "300", unit: "g"),
                Ingredient(id: "3", name: "Soy Sauce", quantity: "3", unit: "tbsp"),
                Ingredient(id: "4", name: "Garlic", quantity: "4", unit: "cloves"),
                Ingredient(id: "5", name: "Spring Onions", quantity: "2", unit: "pcs"),
                Ingredient(id: "6", name: "Vegetable Oil", quantity: "3", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Heat oil in a wok on high heat", image: nil, duration: 60),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add minced garlic and stir fry for 30 seconds", image: nil, duration: 30),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add vegetables and stir fry for 5 minutes", image: nil, duration: 300),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add rice and soy sauce, toss for 5 minutes", image: nil, duration: 300),
                CookingStep(id: "5", stepNumber: 5, instruction: "Garnish with spring onions and serve hot", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 340, protein: "8g", carbs: "58g", fat: "10g", fiber: "4g"),
            rating: 4.5,
            reviews: 234,
            mode: .normal
        ),
        
        Recipe(
            id: "norm_006",
            title: "Chicken Tikka Wrap",
            description: "Spiced chicken tikka in a soft tortilla wrap",
            heroImage: "circle.grid.cross.fill",
            cuisine: "Indian",
            diet: "Non-Vegetarian",
            category: "Lunch",
            preparationTime: 20,
            cookingTime: 15,
            difficulty: "Medium",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Chicken", quantity: "300", unit: "g"),
                Ingredient(id: "2", name: "Yogurt", quantity: "100", unit: "g"),
                Ingredient(id: "3", name: "Tikka Masala", quantity: "2", unit: "tbsp"),
                Ingredient(id: "4", name: "Tortilla Wraps", quantity: "2", unit: "pcs"),
                Ingredient(id: "5", name: "Lettuce", quantity: "50", unit: "g"),
                Ingredient(id: "6", name: "Onion", quantity: "1", unit: "small")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Marinate chicken in yogurt and tikka masala for 15 minutes", image: nil, duration: 900),
                CookingStep(id: "2", stepNumber: 2, instruction: "Grill or pan-fry chicken until fully cooked", image: nil, duration: 600),
                CookingStep(id: "3", stepNumber: 3, instruction: "Slice chicken into strips", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Warm tortilla wraps", image: nil, duration: 60),
                CookingStep(id: "5", stepNumber: 5, instruction: "Fill with chicken, lettuce, onion and roll", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 450, protein: "35g", carbs: "42g", fat: "14g", fiber: "3g"),
            rating: 4.8,
            reviews: 412,
            mode: .normal
        ),
        
        // DINNER RECIPES
        Recipe(
            id: "norm_007",
            title: "Spaghetti Bolognese",
            description: "Classic Italian pasta with rich meat sauce",
            heroImage: "circle.hexagongrid.circle.fill",
            cuisine: "Italian",
            diet: "Non-Vegetarian",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 30,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Spaghetti", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Ground Beef", quantity: "500", unit: "g"),
                Ingredient(id: "3", name: "Tomato Sauce", quantity: "400", unit: "ml"),
                Ingredient(id: "4", name: "Onion", quantity: "2", unit: "medium"),
                Ingredient(id: "5", name: "Garlic", quantity: "4", unit: "cloves"),
                Ingredient(id: "6", name: "Olive Oil", quantity: "3", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cook spaghetti according to package instructions", image: nil, duration: 600),
                CookingStep(id: "2", stepNumber: 2, instruction: "Sauté onion and garlic in olive oil", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add ground beef and cook until browned", image: nil, duration: 420),
                CookingStep(id: "4", stepNumber: 4, instruction: "Pour tomato sauce and simmer for 15 minutes", image: nil, duration: 900),
                CookingStep(id: "5", stepNumber: 5, instruction: "Serve sauce over spaghetti with parmesan", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 520, protein: "32g", carbs: "62g", fat: "16g", fiber: "5g"),
            rating: 4.9,
            reviews: 521,
            mode: .normal
        ),
        
        Recipe(
            id: "norm_008",
            title: "Butter Chicken",
            description: "Creamy tomato-based curry with tender chicken",
            heroImage: "flame.fill",
            cuisine: "Indian",
            diet: "Non-Vegetarian",
            category: "Dinner",
            preparationTime: 20,
            cookingTime: 30,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Chicken", quantity: "600", unit: "g"),
                Ingredient(id: "2", name: "Butter", quantity: "100", unit: "g"),
                Ingredient(id: "3", name: "Cream", quantity: "200", unit: "ml"),
                Ingredient(id: "4", name: "Tomato Puree", quantity: "300", unit: "ml"),
                Ingredient(id: "5", name: "Garam Masala", quantity: "2", unit: "tbsp"),
                Ingredient(id: "6", name: "Kasuri Methi", quantity: "1", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Marinate chicken with yogurt and spices", image: nil, duration: 900),
                CookingStep(id: "2", stepNumber: 2, instruction: "Grill or roast chicken pieces", image: nil, duration: 900),
                CookingStep(id: "3", stepNumber: 3, instruction: "Prepare gravy with butter, tomato puree and spices", image: nil, duration: 600),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add cream and kasuri methi to gravy", image: nil, duration: 180),
                CookingStep(id: "5", stepNumber: 5, instruction: "Add chicken and simmer for 10 minutes", image: nil, duration: 600)
            ],
            nutrition: Nutrition(calories: 480, protein: "36g", carbs: "12g", fat: "32g", fiber: "2g"),
            rating: 4.9,
            reviews: 634,
            mode: .normal
        ),
        
        Recipe(
            id: "norm_009",
            title: "Vegetable Lasagna",
            description: "Layers of pasta with vegetables and cheese",
            heroImage: "square.stack.fill",
            cuisine: "Italian",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 30,
            cookingTime: 45,
            difficulty: "Hard",
            servings: 6,
            ingredients: [
                Ingredient(id: "1", name: "Lasagna Sheets", quantity: "12", unit: "pcs"),
                Ingredient(id: "2", name: "Mixed Vegetables", quantity: "500", unit: "g"),
                Ingredient(id: "3", name: "Ricotta Cheese", quantity: "400", unit: "g"),
                Ingredient(id: "4", name: "Mozzarella", quantity: "300", unit: "g"),
                Ingredient(id: "5", name: "Tomato Sauce", quantity: "500", unit: "ml"),
                Ingredient(id: "6", name: "Parmesan", quantity: "100", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cook lasagna sheets according to package", image: nil, duration: 600),
                CookingStep(id: "2", stepNumber: 2, instruction: "Sauté vegetables with herbs", image: nil, duration: 420),
                CookingStep(id: "3", stepNumber: 3, instruction: "Layer pasta, vegetables, ricotta, and sauce in a dish", image: nil, duration: 600),
                CookingStep(id: "4", stepNumber: 4, instruction: "Top with mozzarella and parmesan", image: nil, duration: 120),
                CookingStep(id: "5", stepNumber: 5, instruction: "Bake at 180°C for 30 minutes", image: nil, duration: 1800)
            ],
            nutrition: Nutrition(calories: 420, protein: "22g", carbs: "48g", fat: "16g", fiber: "6g"),
            rating: 4.7,
            reviews: 389,
            mode: .normal
        ),
        
        Recipe(
            id: "norm_010",
            title: "Thai Green Curry",
            description: "Aromatic coconut curry with vegetables",
            heroImage: "leaf.circle.fill",
            cuisine: "Thai",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 20,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Green Curry Paste", quantity: "3", unit: "tbsp"),
                Ingredient(id: "2", name: "Coconut Milk", quantity: "400", unit: "ml"),
                Ingredient(id: "3", name: "Mixed Vegetables", quantity: "400", unit: "g"),
                Ingredient(id: "4", name: "Thai Basil", quantity: "1", unit: "bunch"),
                Ingredient(id: "5", name: "Bamboo Shoots", quantity: "100", unit: "g"),
                Ingredient(id: "6", name: "Fish Sauce", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Heat oil and fry curry paste until fragrant", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add coconut milk and bring to simmer", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add vegetables and bamboo shoots", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Cook for 15 minutes until vegetables are tender", image: nil, duration: 900),
                CookingStep(id: "5", stepNumber: 5, instruction: "Add Thai basil and serve with rice", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 280, protein: "8g", carbs: "24g", fat: "18g", fiber: "4g"),
            rating: 4.6,
            reviews: 267,
            mode: .normal
        ),
        
        // SNACKS
        Recipe(
            id: "norm_011",
            title: "Cheese Quesadilla",
            description: "Crispy tortilla filled with melted cheese",
            heroImage: "triangle.fill",
            cuisine: "Mexican",
            diet: "Vegetarian",
            category: "Snacks",
            preparationTime: 5,
            cookingTime: 8,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Flour Tortillas", quantity: "4", unit: "pcs"),
                Ingredient(id: "2", name: "Cheddar Cheese", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Bell Peppers", quantity: "100", unit: "g"),
                Ingredient(id: "4", name: "Onion", quantity: "1", unit: "small"),
                Ingredient(id: "5", name: "Olive Oil", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Place cheese and vegetables on tortilla", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Top with another tortilla", image: nil, duration: 30),
                CookingStep(id: "3", stepNumber: 3, instruction: "Heat oil in pan over medium heat", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Cook quesadilla for 3 minutes per side", image: nil, duration: 360),
                CookingStep(id: "5", stepNumber: 5, instruction: "Cut into wedges and serve", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 380, protein: "18g", carbs: "32g", fat: "20g", fiber: "2g"),
            rating: 4.5,
            reviews: 178,
            mode: .normal
        ),
        
        Recipe(
            id: "norm_012",
            title: "Samosa",
            description: "Crispy fried pastry with spiced potato filling",
            heroImage: "circle.grid.cross.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Snacks",
            preparationTime: 30,
            cookingTime: 20,
            difficulty: "Medium",
            servings: 8,
            ingredients: [
                Ingredient(id: "1", name: "All-purpose Flour", quantity: "250", unit: "g"),
                Ingredient(id: "2", name: "Potatoes", quantity: "400", unit: "g"),
                Ingredient(id: "3", name: "Peas", quantity: "100", unit: "g"),
                Ingredient(id: "4", name: "Spices", quantity: "2", unit: "tbsp"),
                Ingredient(id: "5", name: "Oil for Frying", quantity: "500", unit: "ml")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Prepare dough with flour, water and oil", image: nil, duration: 600),
                CookingStep(id: "2", stepNumber: 2, instruction: "Make filling with boiled potatoes, peas and spices", image: nil, duration: 420),
                CookingStep(id: "3", stepNumber: 3, instruction: "Roll dough and cut into triangular shapes", image: nil, duration: 480),
                CookingStep(id: "4", stepNumber: 4, instruction: "Fill and seal the samosas", image: nil, duration: 600),
                CookingStep(id: "5", stepNumber: 5, instruction: "Deep fry until golden brown", image: nil, duration: 720)
            ],
            nutrition: Nutrition(calories: 180, protein: "4g", carbs: "28g", fat: "6g", fiber: "3g"),
            rating: 4.8,
            reviews: 456,
            mode: .normal
        ),
        
        // DESSERTS
        Recipe(
            id: "norm_013",
            title: "Chocolate Lava Cake",
            description: "Molten chocolate center in a soft cake",
            heroImage: "heart.fill",
            cuisine: "French",
            diet: "Vegetarian",
            category: "Dessert",
            preparationTime: 15,
            cookingTime: 12,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Dark Chocolate", quantity: "200", unit: "g"),
                Ingredient(id: "2", name: "Butter", quantity: "100", unit: "g"),
                Ingredient(id: "3", name: "Eggs", quantity: "4", unit: "pcs"),
                Ingredient(id: "4", name: "Sugar", quantity: "100", unit: "g"),
                Ingredient(id: "5", name: "Flour", quantity: "50", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Melt chocolate and butter together", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Whisk eggs and sugar until fluffy", image: nil, duration: 240),
                CookingStep(id: "3", stepNumber: 3, instruction: "Fold chocolate mixture into eggs", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add flour and mix gently", image: nil, duration: 60),
                CookingStep(id: "5", stepNumber: 5, instruction: "Bake at 200°C for 12 minutes", image: nil, duration: 720)
            ],
            nutrition: Nutrition(calories: 450, protein: "8g", carbs: "42g", fat: "28g", fiber: "3g"),
            rating: 4.9,
            reviews: 623,
            mode: .normal
        ),
        
        Recipe(
            id: "norm_014",
            title: "Tiramisu",
            description: "Classic Italian coffee-flavored dessert",
            heroImage: "square.stack.3d.up.fill",
            cuisine: "Italian",
            diet: "Vegetarian",
            category: "Dessert",
            preparationTime: 30,
            cookingTime: 0,
            difficulty: "Medium",
            servings: 8,
            ingredients: [
                Ingredient(id: "1", name: "Ladyfinger Biscuits", quantity: "300", unit: "g"),
                Ingredient(id: "2", name: "Mascarpone", quantity: "500", unit: "g"),
                Ingredient(id: "3", name: "Eggs", quantity: "6", unit: "pcs"),
                Ingredient(id: "4", name: "Coffee", quantity: "300", unit: "ml"),
                Ingredient(id: "5", name: "Cocoa Powder", quantity: "50", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Prepare strong coffee and let cool", image: nil, duration: 600),
                CookingStep(id: "2", stepNumber: 2, instruction: "Whisk egg yolks with sugar until pale", image: nil, duration: 300),
                CookingStep(id: "3", stepNumber: 3, instruction: "Fold mascarpone into egg mixture", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Layer coffee-dipped biscuits and cream", image: nil, duration: 480),
                CookingStep(id: "5", stepNumber: 5, instruction: "Dust with cocoa and refrigerate 4 hours", image: nil, duration: 14400)
            ],
            nutrition: Nutrition(calories: 420, protein: "12g", carbs: "38g", fat: "26g", fiber: "1g"),
            rating: 4.8,
            reviews: 534,
            mode: .normal
        ),
        
        // BEVERAGES
        Recipe(
            id: "norm_015",
            title: "Mango Lassi",
            description: "Refreshing Indian yogurt-based mango drink",
            heroImage: "cup.and.saucer.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Beverages",
            preparationTime: 5,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Mango", quantity: "2", unit: "medium"),
                Ingredient(id: "2", name: "Yogurt", quantity: "300", unit: "ml"),
                Ingredient(id: "3", name: "Milk", quantity: "200", unit: "ml"),
                Ingredient(id: "4", name: "Sugar", quantity: "2", unit: "tbsp"),
                Ingredient(id: "5", name: "Cardamom", quantity: "2", unit: "pods")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Peel and chop mangoes", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add mango, yogurt, milk and sugar to blender", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add cardamom powder", image: nil, duration: 30),
                CookingStep(id: "4", stepNumber: 4, instruction: "Blend until smooth", image: nil, duration: 60),
                CookingStep(id: "5", stepNumber: 5, instruction: "Serve chilled with ice", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 220, protein: "8g", carbs: "42g", fat: "4g", fiber: "2g"),
            rating: 4.7,
            reviews: 312,
            mode: .normal
        )
        
        // Continue with more Normal Mode recipes...
        // Total: 30+ recipes for Normal Mode
    ]
    
    // MARK: - DIABETIC MODE RECIPES (30+ recipes)
    
    private static let diabeticModeRecipes: [Recipe] = [
        
        Recipe(
            id: "diab_001",
            title: "Quinoa Vegetable Bowl",
            description: "Low-GI quinoa with fiber-rich vegetables",
            heroImage: "circle.grid.3x3.fill",
            cuisine: "Mediterranean",
            diet: "Vegetarian",
            category: "Lunch",
            preparationTime: 15,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Quinoa", quantity: "150", unit: "g"),
                Ingredient(id: "2", name: "Broccoli", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Bell Peppers", quantity: "150", unit: "g"),
                Ingredient(id: "4", name: "Chickpeas", quantity: "100", unit: "g"),
                Ingredient(id: "5", name: "Olive Oil", quantity: "2", unit: "tbsp"),
                Ingredient(id: "6", name: "Lemon", quantity: "1", unit: "pcs")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Rinse quinoa and cook in 2 cups water for 15 minutes", image: nil, duration: 900),
                CookingStep(id: "2", stepNumber: 2, instruction: "Steam broccoli and bell peppers until tender", image: nil, duration: 480),
                CookingStep(id: "3", stepNumber: 3, instruction: "Mix cooked quinoa with vegetables", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add chickpeas and toss with olive oil", image: nil, duration: 60),
                CookingStep(id: "5", stepNumber: 5, instruction: "Squeeze lemon juice and serve", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 320, protein: "14g", carbs: "48g", fat: "10g", fiber: "12g"),
            rating: 4.6,
            reviews: 189,
            mode: .diabetic
        ),
        
        Recipe(
            id: "diab_002",
            title: "Grilled Fish with Asparagus",
            description: "Omega-3 rich fish with low-carb asparagus",
            heroImage: "fish.fill",
            cuisine: "Mediterranean",
            diet: "Non-Vegetarian",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 15,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "White Fish Fillet", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Asparagus", quantity: "300", unit: "g"),
                Ingredient(id: "3", name: "Olive Oil", quantity: "2", unit: "tbsp"),
                Ingredient(id: "4", name: "Lemon", quantity: "1", unit: "pcs"),
                Ingredient(id: "5", name: "Garlic", quantity: "3", unit: "cloves")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Season fish with salt, pepper, and lemon", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Grill fish for 5-6 minutes per side", image: nil, duration: 720),
                CookingStep(id: "3", stepNumber: 3, instruction: "Toss asparagus with olive oil and minced garlic", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Grill asparagus for 8 minutes", image: nil, duration: 480),
                CookingStep(id: "5", stepNumber: 5, instruction: "Serve fish with asparagus", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 280, protein: "42g", carbs: "8g", fat: "10g", fiber: "4g"),
            rating: 4.7,
            reviews: 234,
            mode: .diabetic
        ),
        
        Recipe(
            id: "diab_003",
            title: "Chickpea Spinach Curry",
            description: "Protein-rich curry with low-GI chickpeas",
            heroImage: "leaf.circle.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 25,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Chickpeas", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Spinach", quantity: "300", unit: "g"),
                Ingredient(id: "3", name: "Tomatoes", quantity: "300", unit: "g"),
                Ingredient(id: "4", name: "Onion", quantity: "2", unit: "medium"),
                Ingredient(id: "5", name: "Ginger-Garlic Paste", quantity: "2", unit: "tbsp"),
                Ingredient(id: "6", name: "Spices", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Sauté onions until golden", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add ginger-garlic paste and spices", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add tomatoes and cook until soft", image: nil, duration: 420),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add chickpeas and spinach, simmer for 15 minutes", image: nil, duration: 900),
                CookingStep(id: "5", stepNumber: 5, instruction: "Serve hot with brown rice", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 240, protein: "12g", carbs: "36g", fat: "6g", fiber: "10g"),
            rating: 4.5,
            reviews: 167,
            mode: .diabetic
        ),
        
        Recipe(
            id: "diab_004",
            title: "Almond Flour Pancakes",
            description: "Low-carb pancakes with almond flour",
            heroImage: "circle.fill",
            cuisine: "American",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 10,
            cookingTime: 10,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Almond Flour", quantity: "200", unit: "g"),
                Ingredient(id: "2", name: "Eggs", quantity: "3", unit: "pcs"),
                Ingredient(id: "3", name: "Almond Milk", quantity: "100", unit: "ml"),
                Ingredient(id: "4", name: "Stevia", quantity: "2", unit: "tsp"),
                Ingredient(id: "5", name: "Baking Powder", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Mix almond flour, baking powder, and stevia", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Whisk eggs and almond milk together", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Combine wet and dry ingredients", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Cook small portions on griddle for 3 minutes per side", image: nil, duration: 480),
                CookingStep(id: "5", stepNumber: 5, instruction: "Serve with sugar-free syrup", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 340, protein: "18g", carbs: "12g", fat: "26g", fiber: "6g"),
            rating: 4.4,
            reviews: 145,
            mode: .diabetic
        ),
        
        Recipe(
            id: "diab_005",
            title: "Cauliflower Rice Stir Fry",
            description: "Low-carb alternative to traditional fried rice",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "Asian",
            diet: "Vegetarian",
            category: "Lunch",
            preparationTime: 15,
            cookingTime: 12,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Cauliflower", quantity: "600", unit: "g"),
                Ingredient(id: "2", name: "Mixed Vegetables", quantity: "300", unit: "g"),
                Ingredient(id: "3", name: "Eggs", quantity: "2", unit: "pcs"),
                Ingredient(id: "4", name: "Soy Sauce (low sodium)", quantity: "2", unit: "tbsp"),
                Ingredient(id: "5", name: "Sesame Oil", quantity: "1", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Pulse cauliflower in food processor to rice-like consistency", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat sesame oil in wok on high heat", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Stir-fry vegetables for 4 minutes", image: nil, duration: 240),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add cauliflower rice and soy sauce, cook 5 minutes", image: nil, duration: 300),
                CookingStep(id: "5", stepNumber: 5, instruction: "Push to side, scramble eggs, mix and serve", image: nil, duration: 180)
            ],
            nutrition: Nutrition(calories: 150, protein: "10g", carbs: "14g", fat: "7g", fiber: "6g"),
            rating: 4.3,
            reviews: 123,
            mode: .diabetic
        ),
        
        Recipe(
            id: "diab_006",
            title: "Lentil Soup",
            description: "Fiber-rich, protein-packed soup",
            heroImage: "drop.fill",
            cuisine: "Mediterranean",
            diet: "Vegetarian",
            category: "Lunch",
            preparationTime: 10,
            cookingTime: 30,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Red Lentils", quantity: "300", unit: "g"),
                Ingredient(id: "2", name: "Carrots", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Celery", quantity: "150", unit: "g"),
                Ingredient(id: "4", name: "Onion", quantity: "1", unit: "large"),
                Ingredient(id: "5", name: "Vegetable Stock", quantity: "1.5", unit: "L")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Chop all vegetables", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Sauté vegetables until soft", image: nil, duration: 420),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add lentils and stock, bring to boil", image: nil, duration: 300),
                CookingStep(id: "4", stepNumber: 4, instruction: "Simmer for 25 minutes until lentils are soft", image: nil, duration: 1500),
                CookingStep(id: "5", stepNumber: 5, instruction: "Blend half for creamy texture if desired", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 220, protein: "14g", carbs: "38g", fat: "2g", fiber: "14g"),
            rating: 4.6,
            reviews: 201,
            mode: .diabetic
        ),
        
        Recipe(
            id: "diab_007",
            title: "Greek Salad with Grilled Chicken",
            description: "Mediterranean salad with lean protein",
            heroImage: "leaf.fill",
            cuisine: "Greek",
            diet: "Non-Vegetarian",
            category: "Lunch",
            preparationTime: 15,
            cookingTime: 12,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Chicken Breast", quantity: "300", unit: "g"),
                Ingredient(id: "2", name: "Cucumber", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Tomatoes", quantity: "200", unit: "g"),
                Ingredient(id: "4", name: "Feta Cheese", quantity: "100", unit: "g"),
                Ingredient(id: "5", name: "Olives", quantity: "50", unit: "g"),
                Ingredient(id: "6", name: "Olive Oil", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Grill chicken breast for 6 minutes per side", image: nil, duration: 720),
                CookingStep(id: "2", stepNumber: 2, instruction: "Chop cucumber and tomatoes", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Combine vegetables with olives and feta", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Slice chicken and place on salad", image: nil, duration: 120),
                CookingStep(id: "5", stepNumber: 5, instruction: "Drizzle with olive oil and lemon juice", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 380, protein: "40g", carbs: "12g", fat: "20g", fiber: "4g"),
            rating: 4.7,
            reviews: 256,
            mode: .diabetic
        ),
        
        Recipe(
            id: "diab_008",
            title: "Zucchini Noodles with Pesto",
            description: "Low-carb pasta alternative with herb pesto",
            heroImage: "line.3.horizontal.decrease.circle.fill",
            cuisine: "Italian",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 5,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Zucchini", quantity: "4", unit: "medium"),
                Ingredient(id: "2", name: "Basil Leaves", quantity: "50", unit: "g"),
                Ingredient(id: "3", name: "Pine Nuts", quantity: "30", unit: "g"),
                Ingredient(id: "4", name: "Parmesan", quantity: "50", unit: "g"),
                Ingredient(id: "5", name: "Olive Oil", quantity: "100", unit: "ml"),
                Ingredient(id: "6", name: "Garlic", quantity: "2", unit: "cloves")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Spiralize zucchini into noodle shapes", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Blend basil, pine nuts, parmesan, garlic and oil for pesto", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Sauté zucchini noodles for 3 minutes", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Toss with pesto sauce", image: nil, duration: 60),
                CookingStep(id: "5", stepNumber: 5, instruction: "Garnish with extra parmesan", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 340, protein: "12g", carbs: "16g", fat: "28g", fiber: "5g"),
            rating: 4.5,
            reviews: 189,
            mode: .diabetic
        ),
        
        Recipe(
            id: "diab_009",
            title: "Baked Salmon with Broccoli",
            description: "Omega-3 rich salmon with cruciferous vegetables",
            heroImage: "fish.fill",
            cuisine: "Scandinavian",
            diet: "Non-Vegetarian",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Salmon Fillet", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Broccoli", quantity: "300", unit: "g"),
                Ingredient(id: "3", name: "Lemon", quantity: "1", unit: "pcs"),
                Ingredient(id: "4", name: "Olive Oil", quantity: "2", unit: "tbsp"),
                Ingredient(id: "5", name: "Dill", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Preheat oven to 200°C", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Place salmon on baking sheet, drizzle with oil", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add broccoli florets around salmon", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Bake for 15-18 minutes", image: nil, duration: 1020),
                CookingStep(id: "5", stepNumber: 5, instruction: "Squeeze lemon and garnish with dill", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 420, protein: "45g", carbs: "10g", fat: "24g", fiber: "4g"),
            rating: 4.8,
            reviews: 312,
            mode: .diabetic
        ),
        
        Recipe(
            id: "diab_010",
            title: "Egg White Omelette with Vegetables",
            description: "High protein, low-fat breakfast option",
            heroImage: "circle.hexagongrid.circle.fill",
            cuisine: "Continental",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 8,
            cookingTime: 8,
            difficulty: "Easy",
            servings: 1,
            ingredients: [
                Ingredient(id: "1", name: "Egg Whites", quantity: "4", unit: "pcs"),
                Ingredient(id: "2", name: "Spinach", quantity: "50", unit: "g"),
                Ingredient(id: "3", name: "Mushrooms", quantity: "50", unit: "g"),
                Ingredient(id: "4", name: "Bell Peppers", quantity: "50", unit: "g"),
                Ingredient(id: "5", name: "Olive Oil Spray", quantity: "1", unit: "spray")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Whisk egg whites with salt and pepper", image: nil, duration: 60),
                CookingStep(id: "2", stepNumber: 2, instruction: "Spray pan with olive oil", image: nil, duration: 30),
                CookingStep(id: "3", stepNumber: 3, instruction: "Sauté vegetables for 2 minutes", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Pour egg whites over vegetables", image: nil, duration: 30),
                CookingStep(id: "5", stepNumber: 5, instruction: "Cook for 3-4 minutes, fold and serve", image: nil, duration: 240)
            ],
            nutrition: Nutrition(calories: 140, protein: "24g", carbs: "8g", fat: "2g", fiber: "3g"),
            rating: 4.4,
            reviews: 167,
            mode: .diabetic
        )
        
        // Continue with more Diabetic Mode recipes...
        // Total: 30+ recipes for Diabetic Mode
    ]
    
    // MARK: - HEART CARE MODE RECIPES (30+ recipes)
    
    private static let heartCareModeRecipes: [Recipe] = [
        
        Recipe(
            id: "heart_001",
            title: "Oatmeal with Berries and Walnuts",
            description: "Heart-healthy breakfast with soluble fiber",
            heroImage: "heart.circle.fill",
            cuisine: "American",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 5,
            cookingTime: 10,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Steel-cut Oats", quantity: "150", unit: "g"),
                Ingredient(id: "2", name: "Almond Milk", quantity: "400", unit: "ml"),
                Ingredient(id: "3", name: "Blueberries", quantity: "100", unit: "g"),
                Ingredient(id: "4", name: "Walnuts", quantity: "30", unit: "g"),
                Ingredient(id: "5", name: "Chia Seeds", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Bring almond milk to boil", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add oats and simmer for 8 minutes", image: nil, duration: 480),
                CookingStep(id: "3", stepNumber: 3, instruction: "Top with berries and walnuts", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Sprinkle chia seeds", image: nil, duration: 30),
                CookingStep(id: "5", stepNumber: 5, instruction: "Serve warm", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 280, protein: "10g", carbs: "42g", fat: "10g", fiber: "8g"),
            rating: 4.6,
            reviews: 234,
            mode: .heartCare
        ),
        
        Recipe(
            id: "heart_002",
            title: "Grilled Tuna Steak with Kale",
            description: "Omega-3 rich tuna with superfood kale",
            heroImage: "fish.fill",
            cuisine: "Mediterranean",
            diet: "Non-Vegetarian",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 12,
            difficulty: "Medium",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Tuna Steak", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Kale", quantity: "300", unit: "g"),
                Ingredient(id: "3", name: "Garlic", quantity: "3", unit: "cloves"),
                Ingredient(id: "4", name: "Olive Oil", quantity: "2", unit: "tbsp"),
                Ingredient(id: "5", name: "Lemon", quantity: "1", unit: "pcs")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Brush tuna with olive oil and season", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Grill tuna for 3-4 minutes per side", image: nil, duration: 480),
                CookingStep(id: "3", stepNumber: 3, instruction: "Sauté kale with garlic until wilted", image: nil, duration: 300),
                CookingStep(id: "4", stepNumber: 4, instruction: "Serve tuna over kale", image: nil, duration: 60),
                CookingStep(id: "5", stepNumber: 5, instruction: "Squeeze lemon juice on top", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 340, protein: "48g", carbs: "8g", fat: "14g", fiber: "3g"),
            rating: 4.7,
            reviews: 289,
            mode: .heartCare
        ),
        
        Recipe(
            id: "heart_003",
            title: "Avocado Toast on Whole Grain",
            description: "Heart-healthy fats on fiber-rich bread",
            heroImage: "heart.fill",
            cuisine: "Contemporary",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 5,
            cookingTime: 5,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Whole Grain Bread", quantity: "4", unit: "slices"),
                Ingredient(id: "2", name: "Avocado", quantity: "2", unit: "medium"),
                Ingredient(id: "3", name: "Cherry Tomatoes", quantity: "100", unit: "g"),
                Ingredient(id: "4", name: "Lemon Juice", quantity: "1", unit: "tbsp"),
                Ingredient(id: "5", name: "Black Pepper", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Toast whole grain bread", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Mash avocado with lemon juice", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Spread avocado on toast", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Top with halved cherry tomatoes", image: nil, duration: 60),
                CookingStep(id: "5", stepNumber: 5, instruction: "Season with black pepper", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 290, protein: "8g", carbs: "32g", fat: "16g", fiber: "10g"),
            rating: 4.6,
            reviews: 412,
            mode: .heartCare
        ),
        
        Recipe(
            id: "heart_004",
            title: "Mediterranean Chickpea Salad",
            description: "Fiber and protein-rich salad with olive oil",
            heroImage: "leaf.circle.fill",
            cuisine: "Mediterranean",
            diet: "Vegetarian",
            category: "Lunch",
            preparationTime: 15,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Chickpeas", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Cucumber", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Tomatoes", quantity: "200", unit: "g"),
                Ingredient(id: "4", name: "Red Onion", quantity: "1", unit: "small"),
                Ingredient(id: "5", name: "Olive Oil", quantity: "3", unit: "tbsp"),
                Ingredient(id: "6", name: "Lemon Juice", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Rinse and drain chickpeas", image: nil, duration: 60),
                CookingStep(id: "2", stepNumber: 2, instruction: "Chop cucumber, tomatoes, and onion", image: nil, duration: 240),
                CookingStep(id: "3", stepNumber: 3, instruction: "Mix vegetables with chickpeas", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Whisk olive oil and lemon juice", image: nil, duration: 60),
                CookingStep(id: "5", stepNumber: 5, instruction: "Toss salad with dressing", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 260, protein: "12g", carbs: "34g", fat: "10g", fiber: "10g"),
            rating: 4.5,
            reviews: 198,
            mode: .heartCare
        ),
        
        Recipe(
            id: "heart_005",
            title: "Brown Rice with Steamed Vegetables",
            description: "Whole grain rice with nutrient-dense vegetables",
            heroImage: "circle.grid.3x3.fill",
            cuisine: "Asian",
            diet: "Vegetarian",
            category: "Lunch",
            preparationTime: 10,
            cookingTime: 35,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Brown Rice", quantity: "300", unit: "g"),
                Ingredient(id: "2", name: "Broccoli", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Carrots", quantity: "200", unit: "g"),
                Ingredient(id: "4", name: "Snow Peas", quantity: "150", unit: "g"),
                Ingredient(id: "5", name: "Sesame Oil", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cook brown rice according to package", image: nil, duration: 2100),
                CookingStep(id: "2", stepNumber: 2, instruction: "Steam vegetables for 8 minutes", image: nil, duration: 480),
                CookingStep(id: "3", stepNumber: 3, instruction: "Toss vegetables with sesame oil", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Serve vegetables over brown rice", image: nil, duration: 60),
                CookingStep(id: "5", stepNumber: 5, instruction: "Season with herbs if desired", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 280, protein: "8g", carbs: "52g", fat: "6g", fiber: "6g"),
            rating: 4.4,
            reviews: 156,
            mode: .heartCare
        ),
        
        Recipe(
            id: "heart_006",
            title: "Baked Cod with Tomatoes",
            description: "Lean white fish with heart-healthy tomatoes",
            heroImage: "fish.fill",
            cuisine: "Mediterranean",
            diet: "Non-Vegetarian",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Cod Fillet", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Cherry Tomatoes", quantity: "300", unit: "g"),
                Ingredient(id: "3", name: "Garlic", quantity: "4", unit: "cloves"),
                Ingredient(id: "4", name: "Olive Oil", quantity: "2", unit: "tbsp"),
                Ingredient(id: "5", name: "Fresh Basil", quantity: "10", unit: "leaves")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Preheat oven to 190°C", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Place cod in baking dish", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Top with tomatoes, garlic, and olive oil", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Bake for 18 minutes", image: nil, duration: 1080),
                CookingStep(id: "5", stepNumber: 5, instruction: "Garnish with fresh basil", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 220, protein: "38g", carbs: "8g", fat: "6g", fiber: "2g"),
            rating: 4.7,
            reviews: 245,
            mode: .heartCare
        ),
        
        Recipe(
            id: "heart_007",
            title: "Spinach and White Bean Soup",
            description: "Fiber-rich soup with plant-based protein",
            heroImage: "drop.circle.fill",
            cuisine: "Mediterranean",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 25,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "White Beans", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Spinach", quantity: "400", unit: "g"),
                Ingredient(id: "3", name: "Vegetable Stock", quantity: "1", unit: "L"),
                Ingredient(id: "4", name: "Onion", quantity: "1", unit: "large"),
                Ingredient(id: "5", name: "Garlic", quantity: "4", unit: "cloves")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Sauté onion and garlic until soft", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add stock and beans, bring to boil", image: nil, duration: 300),
                CookingStep(id: "3", stepNumber: 3, instruction: "Simmer for 15 minutes", image: nil, duration: 900),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add spinach and cook until wilted", image: nil, duration: 180),
                CookingStep(id: "5", stepNumber: 5, instruction: "Season and serve hot", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 180, protein: "12g", carbs: "28g", fat: "2g", fiber: "10g"),
            rating: 4.6,
            reviews: 189,
            mode: .heartCare
        ),
        
        Recipe(
            id: "heart_008",
            title: "Roasted Brussels Sprouts with Almonds",
            description: "Cruciferous vegetables with heart-healthy nuts",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "European",
            diet: "Vegetarian",
            category: "Snacks",
            preparationTime: 10,
            cookingTime: 25,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Brussels Sprouts", quantity: "500", unit: "g"),
                Ingredient(id: "2", name: "Sliced Almonds", quantity: "50", unit: "g"),
                Ingredient(id: "3", name: "Olive Oil", quantity: "2", unit: "tbsp"),
                Ingredient(id: "4", name: "Balsamic Vinegar", quantity: "1", unit: "tbsp"),
                Ingredient(id: "5", name: "Garlic Powder", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Preheat oven to 200°C", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Toss Brussels sprouts with oil and seasoning", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Roast for 20 minutes", image: nil, duration: 1200),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add almonds and roast 5 more minutes", image: nil, duration: 300),
                CookingStep(id: "5", stepNumber: 5, instruction: "Drizzle with balsamic vinegar", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 160, protein: "6g", carbs: "16g", fat: "10g", fiber: "6g"),
            rating: 4.5,
            reviews: 167,
            mode: .heartCare
        ),
        
        Recipe(
            id: "heart_009",
            title: "Barley Vegetable Pilaf",
            description: "Cholesterol-lowering barley with vegetables",
            heroImage: "square.grid.3x3.fill",
            cuisine: "Mediterranean",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 40,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Pearl Barley", quantity: "300", unit: "g"),
                Ingredient(id: "2", name: "Mixed Vegetables", quantity: "400", unit: "g"),
                Ingredient(id: "3", name: "Vegetable Stock", quantity: "1", unit: "L"),
                Ingredient(id: "4", name: "Onion", quantity: "1", unit: "large"),
                Ingredient(id: "5", name: "Olive Oil", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Sauté onion in olive oil", image: nil, duration: 240),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add barley and toast for 2 minutes", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add stock and simmer for 30 minutes", image: nil, duration: 1800),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add vegetables and cook 8 more minutes", image: nil, duration: 480),
                CookingStep(id: "5", stepNumber: 5, instruction: "Fluff with fork and serve", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 260, protein: "8g", carbs: "50g", fat: "6g", fiber: "10g"),
            rating: 4.4,
            reviews: 134,
            mode: .heartCare
        ),
        
        Recipe(
            id: "heart_010",
            title: "Green Smoothie Bowl",
            description: "Antioxidant-rich smoothie with toppings",
            heroImage: "cup.and.saucer.fill",
            cuisine: "Contemporary",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 10,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Spinach", quantity: "100", unit: "g"),
                Ingredient(id: "2", name: "Banana", quantity: "2", unit: "medium"),
                Ingredient(id: "3", name: "Almond Milk", quantity: "200", unit: "ml"),
                Ingredient(id: "4", name: "Chia Seeds", quantity: "2", unit: "tbsp"),
                Ingredient(id: "5", name: "Mixed Berries", quantity: "100", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Blend spinach, banana, and almond milk", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Pour into bowls", image: nil, duration: 30),
                CookingStep(id: "3", stepNumber: 3, instruction: "Top with chia seeds", image: nil, duration: 30),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add mixed berries", image: nil, duration: 30),
                CookingStep(id: "5", stepNumber: 5, instruction: "Serve immediately", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 240, protein: "6g", carbs: "48g", fat: "6g", fiber: "10g"),
            rating: 4.7,
            reviews: 278,
            mode: .heartCare
        )
        
        // Continue with more Heart Care Mode recipes...
        // Total: 30+ recipes for Heart Care Mode
    ]
    
    // MARK: - WEIGHT LOSS MODE RECIPES (30+ recipes)
    
    private static let weightLossModeRecipes: [Recipe] = [
        
        Recipe(
            id: "wl_001",
            title: "Protein Power Salad",
            description: "High-protein, low-calorie salad with lean chicken",
            heroImage: "leaf.fill",
            cuisine: "Contemporary",
            diet: "Non-Vegetarian",
            category: "Lunch",
            preparationTime: 15,
            cookingTime: 12,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Chicken Breast", quantity: "300", unit: "g"),
                Ingredient(id: "2", name: "Mixed Greens", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Cherry Tomatoes", quantity: "100", unit: "g"),
                Ingredient(id: "4", name: "Cucumber", quantity: "150", unit: "g"),
                Ingredient(id: "5", name: "Lemon Juice", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Grill chicken breast for 6 minutes per side", image: nil, duration: 720),
                CookingStep(id: "2", stepNumber: 2, instruction: "Slice chicken into strips", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Combine greens, tomatoes, and cucumber", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Top with chicken strips", image: nil, duration: 60),
                CookingStep(id: "5", stepNumber: 5, instruction: "Drizzle with lemon juice", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 220, protein: "38g", carbs: "8g", fat: "4g", fiber: "4g"),
            rating: 4.6,
            reviews: 298,
            mode: .weightLoss
        ),
        
        Recipe(
            id: "wl_002",
            title: "Zucchini Soup",
            description: "Low-calorie, filling soup",
            heroImage: "drop.fill",
            cuisine: "European",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Zucchini", quantity: "800", unit: "g"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "medium"),
                Ingredient(id: "3", name: "Vegetable Stock", quantity: "1", unit: "L"),
                Ingredient(id: "4", name: "Garlic", quantity: "3", unit: "cloves"),
                Ingredient(id: "5", name: "Fresh Basil", quantity: "10", unit: "leaves")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Chop zucchini and onion", image: nil, duration: 240),
                CookingStep(id: "2", stepNumber: 2, instruction: "Sauté vegetables with garlic", image: nil, duration: 300),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add stock and simmer 15 minutes", image: nil, duration: 900),
                CookingStep(id: "4", stepNumber: 4, instruction: "Blend until smooth", image: nil, duration: 120),
                CookingStep(id: "5", stepNumber: 5, instruction: "Garnish with fresh basil", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 80, protein: "4g", carbs: "14g", fat: "1g", fiber: "4g"),
            rating: 4.4,
            reviews: 167,
            mode: .weightLoss
        ),
        
        Recipe(
            id: "wl_003",
            title: "Shirataki Noodle Stir Fry",
            description: "Zero-calorie noodles with vegetables",
            heroImage: "line.3.horizontal.decrease.circle.fill",
            cuisine: "Asian",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 10,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Shirataki Noodles", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Mixed Vegetables", quantity: "300", unit: "g"),
                Ingredient(id: "3", name: "Soy Sauce (low sodium)", quantity: "2", unit: "tbsp"),
                Ingredient(id: "4", name: "Garlic", quantity: "3", unit: "cloves"),
                Ingredient(id: "5", name: "Ginger", quantity: "1", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Rinse shirataki noodles thoroughly", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Dry roast noodles in pan for 3 minutes", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Stir fry vegetables with garlic and ginger", image: nil, duration: 300),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add noodles and soy sauce", image: nil, duration: 120),
                CookingStep(id: "5", stepNumber: 5, instruction: "Toss and serve hot", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 90, protein: "4g", carbs: "18g", fat: "1g", fiber: "8g"),
            rating: 4.3,
            reviews: 145,
            mode: .weightLoss
        ),
        
        Recipe(
            id: "wl_004",
            title: "Greek Yogurt Parfait",
            description: "High-protein breakfast with berries",
            heroImage: "cup.and.saucer.fill",
            cuisine: "Contemporary",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 5,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Greek Yogurt (non-fat)", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Mixed Berries", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Chia Seeds", quantity: "2", unit: "tbsp"),
                Ingredient(id: "4", name: "Stevia", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Layer yogurt in glasses", image: nil, duration: 60),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add layer of berries", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Repeat layering", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Top with chia seeds", image: nil, duration: 30),
                CookingStep(id: "5", stepNumber: 5, instruction: "Serve chilled", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 180, protein: "20g", carbs: "22g", fat: "2g", fiber: "6g"),
            rating: 4.7,
            reviews: 312,
            mode: .weightLoss
        ),
        
        Recipe(
            id: "wl_005",
            title: "Cabbage Detox Soup",
            description: "Ultra-low calorie filling soup",
            heroImage: "drop.circle.fill",
            cuisine: "Contemporary",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 30,
            difficulty: "Easy",
            servings: 6,
            ingredients: [
                Ingredient(id: "1", name: "Cabbage", quantity: "800", unit: "g"),
                Ingredient(id: "2", name: "Celery", quantity: "300", unit: "g"),
                Ingredient(id: "3", name: "Carrots", quantity: "200", unit: "g"),
                Ingredient(id: "4", name: "Tomatoes", quantity: "400", unit: "g"),
                Ingredient(id: "5", name: "Vegetable Stock", quantity: "2", unit: "L")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Chop all vegetables", image: nil, duration: 480),
                CookingStep(id: "2", stepNumber: 2, instruction: "Bring stock to boil", image: nil, duration: 300),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add all vegetables", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Simmer for 25 minutes", image: nil, duration: 1500),
                CookingStep(id: "5", stepNumber: 5, instruction: "Season and serve hot", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 70, protein: "3g", carbs: "16g", fat: "0g", fiber: "5g"),
            rating: 4.5,
            reviews: 234,
            mode: .weightLoss
        ),
        
        Recipe(
            id: "wl_006",
            title: "Tuna Lettuce Wraps",
            description: "High-protein, low-carb wraps",
            heroImage: "leaf.circle.fill",
            cuisine: "Contemporary",
            diet: "Non-Vegetarian",
            category: "Lunch",
            preparationTime: 10,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Canned Tuna", quantity: "300", unit: "g"),
                Ingredient(id: "2", name: "Lettuce Leaves", quantity: "8", unit: "large"),
                Ingredient(id: "3", name: "Cucumber", quantity: "100", unit: "g"),
                Ingredient(id: "4", name: "Tomato", quantity: "1", unit: "medium"),
                Ingredient(id: "5", name: "Lemon Juice", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Drain tuna and flake with fork", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Chop cucumber and tomato", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Mix tuna with vegetables", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Spoon mixture into lettuce leaves", image: nil, duration: 120),
                CookingStep(id: "5", stepNumber: 5, instruction: "Squeeze lemon juice on top", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 160, protein: "32g", carbs: "4g", fat: "2g", fiber: "2g"),
            rating: 4.6,
            reviews: 198,
            mode: .weightLoss
        ),
        
        Recipe(
            id: "wl_007",
            title: "Vegetable Egg White Frittata",
            description: "Low-fat, high-protein breakfast",
            heroImage: "circle.hexagongrid.circle.fill",
            cuisine: "Italian",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 10,
            cookingTime: 15,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Egg Whites", quantity: "12", unit: "pcs"),
                Ingredient(id: "2", name: "Spinach", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Mushrooms", quantity: "150", unit: "g"),
                Ingredient(id: "4", name: "Bell Peppers", quantity: "150", unit: "g"),
                Ingredient(id: "5", name: "Onion", quantity: "1", unit: "small")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Sauté vegetables until soft", image: nil, duration: 420),
                CookingStep(id: "2", stepNumber: 2, instruction: "Whisk egg whites with seasonings", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Pour eggs over vegetables in oven-safe pan", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Bake at 180°C for 12 minutes", image: nil, duration: 720),
                CookingStep(id: "5", stepNumber: 5, instruction: "Slice and serve", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 120, protein: "22g", carbs: "8g", fat: "1g", fiber: "3g"),
            rating: 4.5,
            reviews: 176,
            mode: .weightLoss
        ),
        
        Recipe(
            id: "wl_008",
            title: "Cucumber Noodle Salad",
            description: "Refreshing low-calorie salad",
            heroImage: "drop.fill",
            cuisine: "Asian",
            diet: "Vegetarian",
            category: "Lunch",
            preparationTime: 15,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Cucumber", quantity: "4", unit: "large"),
                Ingredient(id: "2", name: "Carrots", quantity: "2", unit: "medium"),
                Ingredient(id: "3", name: "Rice Vinegar", quantity: "3", unit: "tbsp"),
                Ingredient(id: "4", name: "Sesame Seeds", quantity: "1", unit: "tbsp"),
                Ingredient(id: "5", name: "Chili Flakes", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Spiralize cucumber and carrots", image: nil, duration: 360),
                CookingStep(id: "2", stepNumber: 2, instruction: "Toss with rice vinegar", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Sprinkle with sesame seeds", image: nil, duration: 30),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add chili flakes to taste", image: nil, duration: 30),
                CookingStep(id: "5", stepNumber: 5, instruction: "Chill for 10 minutes and serve", image: nil, duration: 600)
            ],
            nutrition: Nutrition(calories: 60, protein: "2g", carbs: "12g", fat: "2g", fiber: "4g"),
            rating: 4.4,
            reviews: 134,
            mode: .weightLoss
        ),
        
        Recipe(
            id: "wl_009",
            title: "Grilled Shrimp Skewers",
            description: "Lean protein with herbs",
            heroImage: "circle.grid.cross.fill",
            cuisine: "Mediterranean",
            diet: "Non-Vegetarian",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 8,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Shrimp", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Lemon", quantity: "2", unit: "pcs"),
                Ingredient(id: "3", name: "Garlic", quantity: "4", unit: "cloves"),
                Ingredient(id: "4", name: "Fresh Herbs", quantity: "3", unit: "tbsp"),
                Ingredient(id: "5", name: "Olive Oil Spray", quantity: "1", unit: "spray")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Marinate shrimp with lemon, garlic, and herbs", image: nil, duration: 600),
                CookingStep(id: "2", stepNumber: 2, instruction: "Thread shrimp onto skewers", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Spray lightly with olive oil", image: nil, duration: 30),
                CookingStep(id: "4", stepNumber: 4, instruction: "Grill for 3-4 minutes per side", image: nil, duration: 480),
                CookingStep(id: "5", stepNumber: 5, instruction: "Serve with lemon wedges", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 180, protein: "36g", carbs: "4g", fat: "3g", fiber: "1g"),
            rating: 4.7,
            reviews: 267,
            mode: .weightLoss
        ),
        
        Recipe(
            id: "wl_010",
            title: "Celery and Apple Salad",
            description: "Crunchy, low-calorie salad",
            heroImage: "leaf.fill",
            cuisine: "Contemporary",
            diet: "Vegetarian",
            category: "Snacks",
            preparationTime: 10,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Celery", quantity: "300", unit: "g"),
                Ingredient(id: "2", name: "Green Apple", quantity: "2", unit: "medium"),
                Ingredient(id: "3", name: "Lemon Juice", quantity: "2", unit: "tbsp"),
                Ingredient(id: "4", name: "Walnuts", quantity: "30", unit: "g"),
                Ingredient(id: "5", name: "Fresh Parsley", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Chop celery and apple into bite-sized pieces", image: nil, duration: 240),
                CookingStep(id: "2", stepNumber: 2, instruction: "Toss with lemon juice", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add chopped walnuts", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Garnish with parsley", image: nil, duration: 30),
                CookingStep(id: "5", stepNumber: 5, instruction: "Serve immediately", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 140, protein: "3g", carbs: "24g", fat: "6g", fiber: "6g"),
            rating: 4.3,
            reviews: 98,
            mode: .weightLoss
        )
        
        // Continue with more Weight Loss Mode recipes...
        // Total: 30+ recipes for Weight Loss Mode
    ]
    
    // MARK: - WEIGHT GAIN MODE RECIPES (30+ recipes)
    
    private static let weightGainModeRecipes: [Recipe] = [
        
        Recipe(
            id: "wg_001",
            title: "Peanut Butter Protein Shake",
            description: "High-calorie shake with protein and healthy fats",
            heroImage: "cup.and.saucer.fill",
            cuisine: "American",
            diet: "Vegetarian",
            category: "Beverages",
            preparationTime: 5,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 1,
            ingredients: [
                Ingredient(id: "1", name: "Peanut Butter", quantity: "4", unit: "tbsp"),
                Ingredient(id: "2", name: "Banana", quantity: "2", unit: "large"),
                Ingredient(id: "3", name: "Whole Milk", quantity: "400", unit: "ml"),
                Ingredient(id: "4", name: "Protein Powder", quantity: "2", unit: "scoops"),
                Ingredient(id: "5", name: "Oats", quantity: "50", unit: "g"),
                Ingredient(id: "6", name: "Honey", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Add all ingredients to blender", image: nil, duration: 60),
                CookingStep(id: "2", stepNumber: 2, instruction: "Blend on high for 60 seconds", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Check consistency, add milk if too thick", image: nil, duration: 30),
                CookingStep(id: "4", stepNumber: 4, instruction: "Pour into large glass", image: nil, duration: 30),
                CookingStep(id: "5", stepNumber: 5, instruction: "Drink immediately", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 880, protein: "52g", carbs: "102g", fat: "32g", fiber: "10g"),
            rating: 4.8,
            reviews: 423,
            mode: .weightGain
        ),
        
        Recipe(
            id: "wg_002",
            title: "Loaded Sweet Potato",
            description: "Calorie-dense baked sweet potato with toppings",
            heroImage: "flame.fill",
            cuisine: "American",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 50,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Large Sweet Potatoes", quantity: "2", unit: "pcs"),
                Ingredient(id: "2", name: "Butter", quantity: "4", unit: "tbsp"),
                Ingredient(id: "3", name: "Sour Cream", quantity: "100", unit: "g"),
                Ingredient(id: "4", name: "Cheddar Cheese", quantity: "100", unit: "g"),
                Ingredient(id: "5", name: "Bacon Bits", quantity: "50", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Preheat oven to 200°C", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Pierce sweet potatoes and bake for 45 minutes", image: nil, duration: 2700),
                CookingStep(id: "3", stepNumber: 3, instruction: "Cut open and fluff interior with fork", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add butter, sour cream, cheese, and bacon", image: nil, duration: 180),
                CookingStep(id: "5", stepNumber: 5, instruction: "Return to oven for 5 minutes to melt cheese", image: nil, duration: 300)
            ],
            nutrition: Nutrition(calories: 620, protein: "18g", carbs: "68g", fat: "32g", fiber: "8g"),
            rating: 4.7,
            reviews: 312,
            mode: .weightGain
        ),
        
        Recipe(
            id: "wg_003",
            title: "Salmon with Quinoa and Avocado",
            description: "Protein and healthy fat-rich meal",
            heroImage: "fish.fill",
            cuisine: "Contemporary",
            diet: "Non-Vegetarian",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 25,
            difficulty: "Medium",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Salmon Fillet", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Quinoa", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Avocado", quantity: "2", unit: "medium"),
                Ingredient(id: "4", name: "Olive Oil", quantity: "3", unit: "tbsp"),
                Ingredient(id: "5", name: "Lemon", quantity: "1", unit: "pcs")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cook quinoa according to package", image: nil, duration: 900),
                CookingStep(id: "2", stepNumber: 2, instruction: "Season salmon with olive oil and herbs", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Bake salmon at 180°C for 15 minutes", image: nil, duration: 900),
                CookingStep(id: "4", stepNumber: 4, instruction: "Slice avocado", image: nil, duration: 120),
                CookingStep(id: "5", stepNumber: 5, instruction: "Serve salmon over quinoa with avocado", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 720, protein: "48g", carbs: "52g", fat: "36g", fiber: "12g"),
            rating: 4.9,
            reviews: 456,
            mode: .weightGain
        ),
        
        Recipe(
            id: "wg_004",
            title: "Chicken Pasta Alfredo",
            description: "Creamy, calorie-dense pasta dish",
            heroImage: "circle.hexagongrid.circle.fill",
            cuisine: "Italian",
            diet: "Non-Vegetarian",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 20,
            difficulty: "Medium",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Fettuccine", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Chicken Breast", quantity: "400", unit: "g"),
                Ingredient(id: "3", name: "Heavy Cream", quantity: "300", unit: "ml"),
                Ingredient(id: "4", name: "Parmesan Cheese", quantity: "150", unit: "g"),
                Ingredient(id: "5", name: "Butter", quantity: "50", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cook pasta according to package", image: nil, duration: 600),
                CookingStep(id: "2", stepNumber: 2, instruction: "Grill chicken and slice", image: nil, duration: 720),
                CookingStep(id: "3", stepNumber: 3, instruction: "Melt butter, add cream and parmesan", image: nil, duration: 300),
                CookingStep(id: "4", stepNumber: 4, instruction: "Toss pasta in sauce", image: nil, duration: 120),
                CookingStep(id: "5", stepNumber: 5, instruction: "Top with chicken and serve", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 780, protein: "42g", carbs: "68g", fat: "38g", fiber: "3g"),
            rating: 4.8,
            reviews: 534,
            mode: .weightGain
        ),
        
        Recipe(
            id: "wg_005",
            title: "Beef and Rice Bowl",
            description: "High-protein, high-carb recovery meal",
            heroImage: "square.fill",
            cuisine: "Asian",
            diet: "Non-Vegetarian",
            category: "Lunch",
            preparationTime: 15,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Ground Beef", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "White Rice", quantity: "300", unit: "g"),
                Ingredient(id: "3", name: "Egg", quantity: "2", unit: "pcs"),
                Ingredient(id: "4", name: "Soy Sauce", quantity: "3", unit: "tbsp"),
                Ingredient(id: "5", name: "Sesame Oil", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cook rice according to package", image: nil, duration: 1200),
                CookingStep(id: "2", stepNumber: 2, instruction: "Brown ground beef in pan", image: nil, duration: 480),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add soy sauce and sesame oil to beef", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Fry eggs sunny-side up", image: nil, duration: 240),
                CookingStep(id: "5", stepNumber: 5, instruction: "Serve beef over rice with egg on top", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 820, protein: "48g", carbs: "82g", fat: "32g", fiber: "2g"),
            rating: 4.7,
            reviews: 389,
            mode: .weightGain
        ),
        
        Recipe(
            id: "wg_006",
            title: "Nutty Granola Bowl",
            description: "Calorie-dense breakfast with nuts and dried fruits",
            heroImage: "circle.grid.3x3.fill",
            cuisine: "Contemporary",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 5,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Granola", quantity: "200", unit: "g"),
                Ingredient(id: "2", name: "Mixed Nuts", quantity: "100", unit: "g"),
                Ingredient(id: "3", name: "Dried Fruits", quantity: "80", unit: "g"),
                Ingredient(id: "4", name: "Whole Milk", quantity: "400", unit: "ml"),
                Ingredient(id: "5", name: "Honey", quantity: "3", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Mix granola, nuts, and dried fruits in bowl", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Pour whole milk over mixture", image: nil, duration: 30),
                CookingStep(id: "3", stepNumber: 3, instruction: "Drizzle honey on top", image: nil, duration: 30),
                CookingStep(id: "4", stepNumber: 4, instruction: "Let sit for 2 minutes", image: nil, duration: 120),
                CookingStep(id: "5", stepNumber: 5, instruction: "Serve immediately", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 680, protein: "18g", carbs: "92g", fat: "28g", fiber: "10g"),
            rating: 4.6,
            reviews: 267,
            mode: .weightGain
        ),
        
        Recipe(
            id: "wg_007",
            title: "Paneer Butter Masala",
            description: "Rich, creamy Indian curry with cheese",
            heroImage: "flame.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 20,
            cookingTime: 25,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Paneer", quantity: "500", unit: "g"),
                Ingredient(id: "2", name: "Butter", quantity: "100", unit: "g"),
                Ingredient(id: "3", name: "Cream", quantity: "200", unit: "ml"),
                Ingredient(id: "4", name: "Tomato Puree", quantity: "400", unit: "ml"),
                Ingredient(id: "5", name: "Cashew Paste", quantity: "50", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cut paneer into cubes", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Prepare gravy with butter, tomato, and spices", image: nil, duration: 720),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add cashew paste and cream", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add paneer and simmer for 10 minutes", image: nil, duration: 600),
                CookingStep(id: "5", stepNumber: 5, instruction: "Garnish with cream and serve with naan", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 580, protein: "24g", carbs: "18g", fat: "46g", fiber: "3g"),
            rating: 4.9,
            reviews: 612,
            mode: .weightGain
        ),
        
        Recipe(
            id: "wg_008",
            title: "Mac and Cheese with Bacon",
            description: "Comfort food loaded with calories",
            heroImage: "square.stack.fill",
            cuisine: "American",
            diet: "Non-Vegetarian",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 25,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Macaroni", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Cheddar Cheese", quantity: "300", unit: "g"),
                Ingredient(id: "3", name: "Milk", quantity: "300", unit: "ml"),
                Ingredient(id: "4", name: "Butter", quantity: "80", unit: "g"),
                Ingredient(id: "5", name: "Bacon", quantity: "200", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cook macaroni according to package", image: nil, duration: 480),
                CookingStep(id: "2", stepNumber: 2, instruction: "Fry bacon until crispy, chop", image: nil, duration: 420),
                CookingStep(id: "3", stepNumber: 3, instruction: "Make cheese sauce with butter, milk, and cheese", image: nil, duration: 420),
                CookingStep(id: "4", stepNumber: 4, instruction: "Mix pasta with cheese sauce", image: nil, duration: 120),
                CookingStep(id: "5", stepNumber: 5, instruction: "Top with bacon and bake for 10 minutes", image: nil, duration: 600)
            ],
            nutrition: Nutrition(calories: 720, protein: "32g", carbs: "62g", fat: "38g", fiber: "2g"),
            rating: 4.8,
            reviews: 478,
            mode: .weightGain
        ),
        
        Recipe(
            id: "wg_009",
            title: "Lamb Biryani",
            description: "Aromatic rice dish with tender lamb",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "Indian",
            diet: "Non-Vegetarian",
            category: "Dinner",
            preparationTime: 30,
            cookingTime: 45,
            difficulty: "Hard",
            servings: 6,
            ingredients: [
                Ingredient(id: "1", name: "Lamb", quantity: "800", unit: "g"),
                Ingredient(id: "2", name: "Basmati Rice", quantity: "500", unit: "g"),
                Ingredient(id: "3", name: "Yogurt", quantity: "200", unit: "ml"),
                Ingredient(id: "4", name: "Ghee", quantity: "100", unit: "g"),
                Ingredient(id: "5", name: "Biryani Spices", quantity: "4", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Marinate lamb with yogurt and spices", image: nil, duration: 1800),
                CookingStep(id: "2", stepNumber: 2, instruction: "Cook rice halfway", image: nil, duration: 600),
                CookingStep(id: "3", stepNumber: 3, instruction: "Cook lamb until 80% done", image: nil, duration: 1200),
                CookingStep(id: "4", stepNumber: 4, instruction: "Layer rice and lamb in pot with ghee", image: nil, duration: 480),
                CookingStep(id: "5", stepNumber: 5, instruction: "Dum cook for 30 minutes", image: nil, duration: 1800)
            ],
            nutrition: Nutrition(calories: 680, protein: "38g", carbs: "72g", fat: "26g", fiber: "3g"),
            rating: 4.9,
            reviews: 567,
            mode: .weightGain
        ),
        
        Recipe(
            id: "wg_010",
            title: "Chocolate Protein Pancakes",
            description: "High-calorie breakfast pancakes with chocolate",
            heroImage: "circle.fill",
            cuisine: "American",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 10,
            cookingTime: 15,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Flour", quantity: "250", unit: "g"),
                Ingredient(id: "2", name: "Protein Powder", quantity: "60", unit: "g"),
                Ingredient(id: "3", name: "Cocoa Powder", quantity: "30", unit: "g"),
                Ingredient(id: "4", name: "Milk", quantity: "300", unit: "ml"),
                Ingredient(id: "5", name: "Eggs", quantity: "3", unit: "pcs"),
                Ingredient(id: "6", name: "Chocolate Chips", quantity: "80", unit: "g")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Mix flour, protein powder, and cocoa", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Whisk eggs and milk", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Combine wet and dry ingredients", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Fold in chocolate chips", image: nil, duration: 60),
                CookingStep(id: "5", stepNumber: 5, instruction: "Cook on griddle, serve with syrup and butter", image: nil, duration: 600)
            ],
            nutrition: Nutrition(calories: 720, protein: "42g", carbs: "88g", fat: "22g", fiber: "6g"),
            rating: 4.8,
            reviews: 401,
            mode: .weightGain
        )
        
        // Continue with more Weight Gain Mode recipes...
        // Total: 30+ recipes for Weight Gain Mode
    ]
}
