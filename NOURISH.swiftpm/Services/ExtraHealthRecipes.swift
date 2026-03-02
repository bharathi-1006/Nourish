import Foundation

// MARK: - Extra Health Mode Recipes
// Affordable, everyday family-friendly recipes for all health modes

extension LocalDatabaseManager {

    func loadExtraHealthRecipes() {
        var extra: [Recipe] = []

        // ─────────────────────────────
        // MARK: DIABETIC MODE
        // ─────────────────────────────

        extra.append(Recipe(
            id: "xd_01",
            title: "Methi Roti",
            description: "Whole wheat flatbread with fresh fenugreek leaves — low GI and tasty",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Breakfast",
            preparationTime: 15,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Whole Wheat Flour", quantity: "2", unit: "cups"),
                Ingredient(id: "2", name: "Fresh Methi Leaves", quantity: "1", unit: "cup"),
                Ingredient(id: "3", name: "Cumin Seeds", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "4", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "5", name: "Salt", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "6", name: "Oil", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Wash and finely chop methi leaves", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Mix flour, methi, cumin, turmeric and salt. Knead into soft dough with water", image: nil, duration: 300),
                CookingStep(id: "3", stepNumber: 3, instruction: "Rest dough 10 minutes, divide into small balls", image: nil, duration: 600),
                CookingStep(id: "4", stepNumber: 4, instruction: "Roll each ball thin and cook on dry hot tawa, flipping twice until golden spots appear", image: nil, duration: 600)
            ],
            nutrition: Nutrition(calories: 140, protein: "5g", carbs: "25g", fat: "2g", fiber: "5g"),
            rating: 4.6,
            reviews: 112,
            mode: .diabetic
        ))

        extra.append(Recipe(
            id: "xd_02",
            title: "Moong Dal Cheela",
            description: "Quick savory lentil pancakes — protein-packed, no refined flour",
            heroImage: "circle.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Breakfast",
            preparationTime: 10,
            cookingTime: 15,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Yellow Moong Dal", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "small"),
                Ingredient(id: "3", name: "Green Chili", quantity: "1", unit: "pcs"),
                Ingredient(id: "4", name: "Ginger", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "5", name: "Cumin Seeds", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "6", name: "Oil", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Soak moong dal in water for 2 hours", image: nil, duration: 7200),
                CookingStep(id: "2", stepNumber: 2, instruction: "Drain and blend with ginger and green chili to a smooth batter", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Stir in chopped onion, cumin, and salt", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Pour small ladleful on oiled non-stick pan, spread thin, cook 2 min each side", image: nil, duration: 600)
            ],
            nutrition: Nutrition(calories: 160, protein: "11g", carbs: "22g", fat: "2g", fiber: "6g"),
            rating: 4.8,
            reviews: 145,
            mode: .diabetic
        ))

        extra.append(Recipe(
            id: "xd_03",
            title: "Lauki Ki Sabzi",
            description: "Simple bottle gourd vegetable — very low calorie and easy to digest",
            heroImage: "leaf.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 10,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Bottle Gourd", quantity: "500", unit: "g"),
                Ingredient(id: "2", name: "Tomato", quantity: "1", unit: "medium"),
                Ingredient(id: "3", name: "Cumin Seeds", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "4", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "5", name: "Coriander Powder", quantity: "1", unit: "tsp"),
                Ingredient(id: "6", name: "Oil", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Peel and dice bottle gourd into 1-inch cubes", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat oil, add cumin. When it splutters add tomato and cook 3 min", image: nil, duration: 240),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add turmeric, coriander powder, and bottle gourd. Mix well", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Cover and cook on low heat 15 min until soft. Garnish with coriander", image: nil, duration: 900)
            ],
            nutrition: Nutrition(calories: 75, protein: "2g", carbs: "12g", fat: "2g", fiber: "4g"),
            rating: 4.3,
            reviews: 88,
            mode: .diabetic
        ))

        extra.append(Recipe(
            id: "xd_04",
            title: "Chana Dal Salad",
            description: "Boiled Bengal gram salad with onion and lemon — high protein, low GI",
            heroImage: "leaf.circle.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 10,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Chana Dal (Bengal Gram)", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "medium"),
                Ingredient(id: "3", name: "Tomato", quantity: "1", unit: "small"),
                Ingredient(id: "4", name: "Lemon Juice", quantity: "2", unit: "tbsp"),
                Ingredient(id: "5", name: "Green Chili", quantity: "1", unit: "pcs"),
                Ingredient(id: "6", name: "Coriander Leaves", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Boil chana dal until just soft but not mushy (about 20 min)", image: nil, duration: 1200),
                CookingStep(id: "2", stepNumber: 2, instruction: "Drain and let cool to room temperature", image: nil, duration: 600),
                CookingStep(id: "3", stepNumber: 3, instruction: "Finely chop onion, tomato, chili and coriander", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Mix everything with lemon juice and a pinch of salt. Serve fresh", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 185, protein: "12g", carbs: "28g", fat: "2g", fiber: "8g"),
            rating: 4.5,
            reviews: 93,
            mode: .diabetic
        ))

        extra.append(Recipe(
            id: "xd_05",
            title: "Palak Paneer (Low Fat)",
            description: "Classic spinach and cottage cheese curry made with minimal oil",
            heroImage: "leaf.circle.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 25,
            difficulty: "Medium",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Spinach", quantity: "300", unit: "g"),
                Ingredient(id: "2", name: "Low-Fat Paneer", quantity: "200", unit: "g"),
                Ingredient(id: "3", name: "Onion", quantity: "1", unit: "medium"),
                Ingredient(id: "4", name: "Garlic", quantity: "3", unit: "cloves"),
                Ingredient(id: "5", name: "Ginger", quantity: "1", unit: "inch"),
                Ingredient(id: "6", name: "Tomato", quantity: "1", unit: "medium"),
                Ingredient(id: "7", name: "Cumin Seeds", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "8", name: "Oil", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Blanch spinach in hot water 2 min, drain and blend smooth", image: nil, duration: 240),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat oil, add cumin, then onion, garlic and ginger. Cook till golden", image: nil, duration: 360),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add chopped tomato and cook until mashy, 5 min", image: nil, duration: 300),
                CookingStep(id: "4", stepNumber: 4, instruction: "Pour in spinach puree and cubed paneer. Simmer 8 min", image: nil, duration: 480)
            ],
            nutrition: Nutrition(calories: 195, protein: "16g", carbs: "10g", fat: "9g", fiber: "5g"),
            rating: 4.7,
            reviews: 178,
            mode: .diabetic
        ))

        extra.append(Recipe(
            id: "xd_06",
            title: "Tomato Onion Egg Bhurji",
            description: "Simple scrambled eggs with tomato and onion — everyday breakfast",
            heroImage: "flame.fill",
            cuisine: "Indian",
            diet: "Gluten-Free",
            category: "Breakfast",
            preparationTime: 5,
            cookingTime: 10,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Eggs", quantity: "3", unit: "pcs"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "small"),
                Ingredient(id: "3", name: "Tomato", quantity: "1", unit: "medium"),
                Ingredient(id: "4", name: "Green Chili", quantity: "1", unit: "pcs"),
                Ingredient(id: "5", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "6", name: "Oil", quantity: "1/2", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Finely chop onion, tomato and green chili", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat oil, sauté onion until translucent, 3 min", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add tomato, chili and turmeric. Cook 2 min", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Beat eggs, pour in and scramble on medium heat until just set", image: nil, duration: 180)
            ],
            nutrition: Nutrition(calories: 165, protein: "13g", carbs: "6g", fat: "10g", fiber: "2g"),
            rating: 4.6,
            reviews: 203,
            mode: .diabetic
        ))

        extra.append(Recipe(
            id: "xd_07",
            title: "Curd Rice",
            description: "Cooling yogurt rice — simple, probiotic and low glycemic",
            heroImage: "circle.grid.2x2.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Lunch",
            preparationTime: 5,
            cookingTime: 5,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Cooked Brown Rice", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Low-Fat Curd", quantity: "1", unit: "cup"),
                Ingredient(id: "3", name: "Mustard Seeds", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "4", name: "Curry Leaves", quantity: "8", unit: "leaves"),
                Ingredient(id: "5", name: "Ginger", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "6", name: "Green Chili", quantity: "1", unit: "pcs")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Mix cooled brown rice with curd until combined", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat little oil, add mustard seeds and curry leaves, let splutter", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add ginger and green chili, fry 30 seconds", image: nil, duration: 30),
                CookingStep(id: "4", stepNumber: 4, instruction: "Pour tempering over curd rice, mix and serve", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 195, protein: "8g", carbs: "32g", fat: "3g", fiber: "3g"),
            rating: 4.5,
            reviews: 134,
            mode: .diabetic
        ))

        extra.append(Recipe(
            id: "xd_08",
            title: "Mixed Vegetable Khichdi",
            description: "Comforting one-pot rice and lentil meal with veggies",
            heroImage: "circle.grid.2x2.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 25,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Brown Rice", quantity: "1/2", unit: "cup"),
                Ingredient(id: "2", name: "Moong Dal", quantity: "1/2", unit: "cup"),
                Ingredient(id: "3", name: "Carrot", quantity: "1", unit: "medium"),
                Ingredient(id: "4", name: "Beans", quantity: "1/2", unit: "cup"),
                Ingredient(id: "5", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "6", name: "Cumin Seeds", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "7", name: "Ginger", quantity: "1/2", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Wash rice and dal. Chop vegetables", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat oil in pressure cooker, add cumin and ginger", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add rice, dal, vegetables, turmeric and 3 cups water", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Pressure cook 3 whistles on medium heat. Let steam release", image: nil, duration: 1200),
                CookingStep(id: "5", stepNumber: 5, instruction: "Stir and adjust consistency. Season and serve", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 210, protein: "10g", carbs: "36g", fat: "2g", fiber: "7g"),
            rating: 4.7,
            reviews: 156,
            mode: .diabetic
        ))

        extra.append(Recipe(
            id: "xd_09",
            title: "Besan Chilla",
            description: "Gram flour pancake with veggies — cheap, quick, and protein rich",
            heroImage: "circle.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Breakfast",
            preparationTime: 5,
            cookingTime: 10,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Besan (Gram Flour)", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "small"),
                Ingredient(id: "3", name: "Tomato", quantity: "1", unit: "small"),
                Ingredient(id: "4", name: "Cumin Powder", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "5", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "6", name: "Green Chili", quantity: "1", unit: "pcs")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Mix besan with water to make thin, lump-free batter", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add all chopped vegetables and spices to batter", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Pour onto hot non-stick pan, spread thin like a dosa", image: nil, duration: 30),
                CookingStep(id: "4", stepNumber: 4, instruction: "Cook 2-3 min per side until golden and crispy", image: nil, duration: 300)
            ],
            nutrition: Nutrition(calories: 175, protein: "10g", carbs: "24g", fat: "3g", fiber: "6g"),
            rating: 4.8,
            reviews: 221,
            mode: .diabetic
        ))

        extra.append(Recipe(
            id: "xd_10",
            title: "Karela Juice",
            description: "Fresh bitter gourd juice — a natural blood sugar regulator",
            heroImage: "drop.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Beverages",
            preparationTime: 10,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 1,
            ingredients: [
                Ingredient(id: "1", name: "Bitter Gourd", quantity: "2", unit: "medium"),
                Ingredient(id: "2", name: "Lemon Juice", quantity: "1", unit: "tsp"),
                Ingredient(id: "3", name: "Ginger", quantity: "1/2", unit: "inch"),
                Ingredient(id: "4", name: "Water", quantity: "1/2", unit: "cup"),
                Ingredient(id: "5", name: "Salt", quantity: "1", unit: "pinch")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Wash karela, cut and remove seeds", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Blend karela with ginger and water", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Strain through a sieve", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add lemon juice and a pinch of salt. Drink fresh on empty stomach", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 25, protein: "1g", carbs: "5g", fat: "0g", fiber: "2g"),
            rating: 4.2,
            reviews: 67,
            mode: .diabetic
        ))

        extra.append(Recipe(
            id: "xd_11",
            title: "Roasted Chickpea Snack",
            description: "Crunchy spiced chickpeas — a great low-GI snack between meals",
            heroImage: "circle.grid.cross.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Snacks",
            preparationTime: 5,
            cookingTime: 25,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Boiled Chickpeas", quantity: "1.5", unit: "cups"),
                Ingredient(id: "2", name: "Cumin Powder", quantity: "1", unit: "tsp"),
                Ingredient(id: "3", name: "Chili Powder", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "4", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "5", name: "Lemon Juice", quantity: "1", unit: "tbsp"),
                Ingredient(id: "6", name: "Oil", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Preheat oven to 200°C. Pat chickpeas completely dry", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Toss with oil and spices", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Spread on baking tray and roast 20-25 min, shaking halfway", image: nil, duration: 1500),
                CookingStep(id: "4", stepNumber: 4, instruction: "Cool and finish with lemon juice", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 145, protein: "7g", carbs: "20g", fat: "3g", fiber: "6g"),
            rating: 4.7,
            reviews: 176,
            mode: .diabetic
        ))

        // ─────────────────────────────
        // MARK: HEART CARE MODE
        // ─────────────────────────────

        extra.append(Recipe(
            id: "xh_01",
            title: "Oats Porridge with Fruits",
            description: "Cholesterol-lowering oats with seasonal fruit — simple daily breakfast",
            heroImage: "sunrise.fill",
            cuisine: "International",
            diet: "Vegan",
            category: "Breakfast",
            preparationTime: 5,
            cookingTime: 10,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Rolled Oats", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Water or Milk", quantity: "2", unit: "cups"),
                Ingredient(id: "3", name: "Banana", quantity: "1", unit: "medium"),
                Ingredient(id: "4", name: "Apple", quantity: "1", unit: "small"),
                Ingredient(id: "5", name: "Cinnamon Powder", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "6", name: "Walnuts", quantity: "1", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Bring water or milk to boil in a pot", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add oats and cook on low heat, stirring, 5-7 min until thick", image: nil, duration: 420),
                CookingStep(id: "3", stepNumber: 3, instruction: "Slice banana and apple", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Pour porridge in bowl, top with fruits, walnuts and cinnamon", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 280, protein: "9g", carbs: "48g", fat: "6g", fiber: "8g"),
            rating: 4.7,
            reviews: 189,
            mode: .heartCare
        ))

        extra.append(Recipe(
            id: "xh_02",
            title: "Palak Dal",
            description: "Iron-rich spinach lentil curry — low sodium, heart-healthy",
            heroImage: "leaf.circle.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 10,
            cookingTime: 25,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Toor Dal", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Spinach", quantity: "2", unit: "cups"),
                Ingredient(id: "3", name: "Tomato", quantity: "2", unit: "medium"),
                Ingredient(id: "4", name: "Garlic", quantity: "3", unit: "cloves"),
                Ingredient(id: "5", name: "Turmeric", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "6", name: "Cumin Seeds", quantity: "1", unit: "tsp"),
                Ingredient(id: "7", name: "Oil", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Pressure cook dal with turmeric and water, 3 whistles", image: nil, duration: 900),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat oil, add cumin seeds and garlic. Sauté until golden", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add chopped tomatoes and cook until soft", image: nil, duration: 300),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add cooked dal and spinach. Simmer 10 min. Season lightly", image: nil, duration: 600)
            ],
            nutrition: Nutrition(calories: 185, protein: "12g", carbs: "28g", fat: "3g", fiber: "9g"),
            rating: 4.8,
            reviews: 201,
            mode: .heartCare
        ))

        extra.append(Recipe(
            id: "xh_03",
            title: "Baked Fish with Vegetables",
            description: "Omega-3 rich fish baked with seasonal veggies — no oil frying",
            heroImage: "fish.fill",
            cuisine: "Indian",
            diet: "Gluten-Free",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 25,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Fish (Rohu or any white fish)", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Tomato", quantity: "2", unit: "medium"),
                Ingredient(id: "3", name: "Onion", quantity: "1", unit: "medium"),
                Ingredient(id: "4", name: "Lemon Juice", quantity: "2", unit: "tbsp"),
                Ingredient(id: "5", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "6", name: "Cumin Powder", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "7", name: "Oil", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Marinate fish with lemon, turmeric and cumin for 15 min", image: nil, duration: 900),
                CookingStep(id: "2", stepNumber: 2, instruction: "Slice tomato and onion into rings", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Layer vegetables in a baking dish, place fish on top", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Drizzle with oil, bake at 190°C for 20-25 min until cooked", image: nil, duration: 1500)
            ],
            nutrition: Nutrition(calories: 220, protein: "30g", carbs: "8g", fat: "7g", fiber: "2g"),
            rating: 4.7,
            reviews: 134,
            mode: .heartCare
        ))

        extra.append(Recipe(
            id: "xh_04",
            title: "Lauki Chana Dal",
            description: "Bottle gourd with split Bengal gram — low fat, heart-friendly",
            heroImage: "drop.circle.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 30,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Lauki (Bottle Gourd)", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Chana Dal", quantity: "1/2", unit: "cup"),
                Ingredient(id: "3", name: "Tomato", quantity: "2", unit: "medium"),
                Ingredient(id: "4", name: "Ginger", quantity: "1", unit: "inch"),
                Ingredient(id: "5", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "6", name: "Oil", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Soak chana dal 30 min. Peel and cube lauki", image: nil, duration: 1800),
                CookingStep(id: "2", stepNumber: 2, instruction: "Pressure cook dal and lauki together with turmeric, 3 whistles", image: nil, duration: 900),
                CookingStep(id: "3", stepNumber: 3, instruction: "Prepare tomato-ginger tempering in little oil", image: nil, duration: 300),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add cooked dal mixture to tempering, simmer 5 min", image: nil, duration: 300)
            ],
            nutrition: Nutrition(calories: 165, protein: "9g", carbs: "26g", fat: "3g", fiber: "8g"),
            rating: 4.5,
            reviews: 97,
            mode: .heartCare
        ))

        extra.append(Recipe(
            id: "xh_05",
            title: "Vegetable Dalia",
            description: "Broken wheat porridge with vegetables — filling, fibre-rich breakfast",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Breakfast",
            preparationTime: 10,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Dalia (Broken Wheat)", quantity: "1/2", unit: "cup"),
                Ingredient(id: "2", name: "Carrot", quantity: "1", unit: "small"),
                Ingredient(id: "3", name: "Green Peas", quantity: "1/4", unit: "cup"),
                Ingredient(id: "4", name: "Onion", quantity: "1", unit: "small"),
                Ingredient(id: "5", name: "Tomato", quantity: "1", unit: "small"),
                Ingredient(id: "6", name: "Cumin Seeds", quantity: "1/2", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Dry roast dalia in a pan until lightly golden, set aside", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat little oil, add cumin, onion and cook until soft", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add tomato, carrot and peas. Cook 3 min", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add roasted dalia and 2 cups water. Cover and cook 15 min until done", image: nil, duration: 900)
            ],
            nutrition: Nutrition(calories: 185, protein: "6g", carbs: "33g", fat: "3g", fiber: "6g"),
            rating: 4.6,
            reviews: 143,
            mode: .heartCare
        ))

        extra.append(Recipe(
            id: "xh_06",
            title: "Moong Dal Soup",
            description: "Light protein soup — gentle on the heart, easy to make",
            heroImage: "drop.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 5,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Yellow Moong Dal", quantity: "3/4", unit: "cup"),
                Ingredient(id: "2", name: "Ginger", quantity: "1", unit: "inch"),
                Ingredient(id: "3", name: "Garlic", quantity: "2", unit: "cloves"),
                Ingredient(id: "4", name: "Tomato", quantity: "1", unit: "medium"),
                Ingredient(id: "5", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "6", name: "Cumin Seeds", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "7", name: "Spinach", quantity: "1", unit: "cup")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Wash dal and pressure cook with turmeric and 2.5 cups water, 2 whistles", image: nil, duration: 600),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat oil, add cumin. When it splutters add garlic and ginger", image: nil, duration: 90),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add tomato and cook until soft, 3 min", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add cooked dal and spinach, simmer 8 min. Serve hot", image: nil, duration: 480)
            ],
            nutrition: Nutrition(calories: 160, protein: "10g", carbs: "24g", fat: "2g", fiber: "7g"),
            rating: 4.8,
            reviews: 167,
            mode: .heartCare
        ))

        extra.append(Recipe(
            id: "xh_07",
            title: "Sprouts Chaat",
            description: "Tangy mixed sprouts snack — no cooking, loaded with antioxidants",
            heroImage: "leaf.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Snacks",
            preparationTime: 10,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Mixed Sprouts", quantity: "1.5", unit: "cups"),
                Ingredient(id: "2", name: "Tomato", quantity: "1", unit: "medium"),
                Ingredient(id: "3", name: "Onion", quantity: "1", unit: "small"),
                Ingredient(id: "4", name: "Cucumber", quantity: "1", unit: "small"),
                Ingredient(id: "5", name: "Lemon Juice", quantity: "2", unit: "tbsp"),
                Ingredient(id: "6", name: "Coriander Leaves", quantity: "2", unit: "tbsp"),
                Ingredient(id: "7", name: "Chaat Masala", quantity: "1/2", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Rinse sprouts, optionally steam 2 min for better digestion", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Finely dice tomato, onion and cucumber", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Combine sprouts and vegetables in a bowl", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add lemon juice, chaat masala and fresh coriander. Toss well", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 115, protein: "8g", carbs: "16g", fat: "1g", fiber: "6g"),
            rating: 4.6,
            reviews: 143,
            mode: .heartCare
        ))

        extra.append(Recipe(
            id: "xh_08",
            title: "Apple Cinnamon Oatmeal",
            description: "Heart-protective porridge you can eat every morning without getting bored",
            heroImage: "sunrise.fill",
            cuisine: "International",
            diet: "Vegan",
            category: "Breakfast",
            preparationTime: 5,
            cookingTime: 8,
            difficulty: "Easy",
            servings: 1,
            ingredients: [
                Ingredient(id: "1", name: "Oats", quantity: "1/2", unit: "cup"),
                Ingredient(id: "2", name: "Apple", quantity: "1", unit: "small"),
                Ingredient(id: "3", name: "Cinnamon Powder", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "4", name: "Milk or Water", quantity: "1", unit: "cup"),
                Ingredient(id: "5", name: "Walnuts", quantity: "4-5", unit: "pcs")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Peel and dice apple into small cubes", image: nil, duration: 60),
                CookingStep(id: "2", stepNumber: 2, instruction: "Boil milk/water. Add oats and apple pieces. Cook stirring 5 min", image: nil, duration: 300),
                CookingStep(id: "3", stepNumber: 3, instruction: "Stir in cinnamon. Transfer to bowl", image: nil, duration: 30),
                CookingStep(id: "4", stepNumber: 4, instruction: "Top with chopped walnuts and serve warm", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 255, protein: "8g", carbs: "38g", fat: "8g", fiber: "7g"),
            rating: 4.7,
            reviews: 198,
            mode: .heartCare
        ))

        extra.append(Recipe(
            id: "xh_09",
            title: "Banana Walnut Smoothie",
            description: "Potassium and omega-3 rich smoothie — great for blood pressure",
            heroImage: "cup.and.saucer.fill",
            cuisine: "International",
            diet: "Vegan",
            category: "Beverages",
            preparationTime: 5,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 1,
            ingredients: [
                Ingredient(id: "1", name: "Banana", quantity: "1", unit: "large"),
                Ingredient(id: "2", name: "Walnuts", quantity: "5", unit: "pcs"),
                Ingredient(id: "3", name: "Low-Fat Milk", quantity: "1", unit: "cup"),
                Ingredient(id: "4", name: "Flaxseeds", quantity: "1", unit: "tsp"),
                Ingredient(id: "5", name: "Honey", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Peel banana and break into pieces", image: nil, duration: 30),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add all ingredients to blender", image: nil, duration: 30),
                CookingStep(id: "3", stepNumber: 3, instruction: "Blend on high for 45 seconds until smooth", image: nil, duration: 45),
                CookingStep(id: "4", stepNumber: 4, instruction: "Pour into glass and drink immediately", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 265, protein: "9g", carbs: "38g", fat: "9g", fiber: "4g"),
            rating: 4.6,
            reviews: 112,
            mode: .heartCare
        ))

        extra.append(Recipe(
            id: "xh_10",
            title: "Steamed Idli with Sambar",
            description: "Oil-free steamed rice cakes with veggie lentil sambar — heart-friendly South Indian staple",
            heroImage: "circle.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Breakfast",
            preparationTime: 480,
            cookingTime: 30,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Idli Rice", quantity: "2", unit: "cups"),
                Ingredient(id: "2", name: "Urad Dal", quantity: "1", unit: "cup"),
                Ingredient(id: "3", name: "Toor Dal", quantity: "1/2", unit: "cup"),
                Ingredient(id: "4", name: "Mixed Vegetables", quantity: "1", unit: "cup"),
                Ingredient(id: "5", name: "Tamarind", quantity: "1", unit: "small ball"),
                Ingredient(id: "6", name: "Sambar Powder", quantity: "1.5", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Soak rice and dal separately 6-8 hours. Grind to smooth batter. Ferment overnight", image: nil, duration: 28800),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add salt to batter and pour into idli moulds. Steam 12-15 min", image: nil, duration: 900),
                CookingStep(id: "3", stepNumber: 3, instruction: "Cook dal with vegetables, tamarind and sambar powder", image: nil, duration: 1200),
                CookingStep(id: "4", stepNumber: 4, instruction: "Serve hot idlis with sambar and fresh chutney", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 195, protein: "8g", carbs: "36g", fat: "1g", fiber: "5g"),
            rating: 4.9,
            reviews: 345,
            mode: .heartCare
        ))

        extra.append(Recipe(
            id: "xh_11",
            title: "Rajma Salad",
            description: "Boiled kidney beans salad with crunchy vegetables — high fibre, no fat",
            heroImage: "leaf.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 10,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Boiled Rajma (Kidney Beans)", quantity: "1.5", unit: "cups"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "medium"),
                Ingredient(id: "3", name: "Tomato", quantity: "1", unit: "medium"),
                Ingredient(id: "4", name: "Cucumber", quantity: "1", unit: "small"),
                Ingredient(id: "5", name: "Lemon Juice", quantity: "2", unit: "tbsp"),
                Ingredient(id: "6", name: "Cumin Powder", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "7", name: "Coriander Leaves", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Chop onion, tomato, cucumber finely", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Combine chopped vegetables with boiled rajma", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add lemon juice, cumin powder and coriander", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Toss well and serve fresh", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 190, protein: "12g", carbs: "30g", fat: "1g", fiber: "10g"),
            rating: 4.5,
            reviews: 89,
            mode: .heartCare
        ))

        // ─────────────────────────────
        // MARK: WEIGHT LOSS MODE
        // ─────────────────────────────

        extra.append(Recipe(
            id: "xwl_01",
            title: "Vegetable Poha",
            description: "Light flattened rice with veggies — filling and under 200 calories",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Breakfast",
            preparationTime: 10,
            cookingTime: 10,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Thin Poha (Flattened Rice)", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "small"),
                Ingredient(id: "3", name: "Green Peas", quantity: "1/4", unit: "cup"),
                Ingredient(id: "4", name: "Mustard Seeds", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "5", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "6", name: "Lemon Juice", quantity: "1", unit: "tbsp"),
                Ingredient(id: "7", name: "Coriander Leaves", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Wash poha in water and drain. Leave to soften 5 min", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat little oil, add mustard seeds. When they pop add onion and peas", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add turmeric. Add soaked poha and mix gently", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Cook 3-4 min on low heat. Add lemon juice and coriander, serve", image: nil, duration: 240)
            ],
            nutrition: Nutrition(calories: 175, protein: "4g", carbs: "34g", fat: "2g", fiber: "4g"),
            rating: 4.6,
            reviews: 234,
            mode: .weightLoss
        ))

        extra.append(Recipe(
            id: "xwl_02",
            title: "Masoor Dal",
            description: "Simple red lentil dal — high protein, very filling, low calorie",
            heroImage: "drop.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 5,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Masoor Dal (Red Lentils)", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "medium"),
                Ingredient(id: "3", name: "Tomato", quantity: "2", unit: "medium"),
                Ingredient(id: "4", name: "Garlic", quantity: "3", unit: "cloves"),
                Ingredient(id: "5", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "6", name: "Cumin Seeds", quantity: "1", unit: "tsp"),
                Ingredient(id: "7", name: "Oil", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Wash dal and pressure cook with turmeric and water, 2-3 whistles", image: nil, duration: 600),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat oil, add cumin seeds then garlic until golden", image: nil, duration: 90),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add onion and tomato. Cook until tomato breaks down, 5 min", image: nil, duration: 300),
                CookingStep(id: "4", stepNumber: 4, instruction: "Mix in cooked dal, add water for consistency. Simmer 5 min", image: nil, duration: 300)
            ],
            nutrition: Nutrition(calories: 185, protein: "13g", carbs: "28g", fat: "2g", fiber: "9g"),
            rating: 4.8,
            reviews: 267,
            mode: .weightLoss
        ))

        extra.append(Recipe(
            id: "xwl_03",
            title: "Grilled Chicken with Salad",
            description: "Simple grilled chicken breast with fresh salad — high protein, low calorie",
            heroImage: "flame.fill",
            cuisine: "International",
            diet: "Gluten-Free",
            category: "Dinner",
            preparationTime: 15,
            cookingTime: 15,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Chicken Breast", quantity: "300", unit: "g"),
                Ingredient(id: "2", name: "Lemon Juice", quantity: "2", unit: "tbsp"),
                Ingredient(id: "3", name: "Garlic Powder", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "4", name: "Cucumber", quantity: "1", unit: "medium"),
                Ingredient(id: "5", name: "Tomato", quantity: "2", unit: "medium"),
                Ingredient(id: "6", name: "Onion", quantity: "1", unit: "small"),
                Ingredient(id: "7", name: "Coriander Leaves", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Flatten chicken, marinate with lemon juice, garlic powder and pepper 10 min", image: nil, duration: 600),
                CookingStep(id: "2", stepNumber: 2, instruction: "Grill on a hot pan 6-7 min each side until cooked through", image: nil, duration: 840),
                CookingStep(id: "3", stepNumber: 3, instruction: "Chop cucumber, tomato and onion for salad", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Dress salad with lemon juice, serve with sliced chicken", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 245, protein: "35g", carbs: "8g", fat: "6g", fiber: "3g"),
            rating: 4.7,
            reviews: 189,
            mode: .weightLoss
        ))

        extra.append(Recipe(
            id: "xwl_04",
            title: "Moong Dal Soup",
            description: "Thin comforting lentil broth — lowest calorie filling meal",
            heroImage: "drop.circle.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Dinner",
            preparationTime: 5,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Yellow Moong Dal", quantity: "1/2", unit: "cup"),
                Ingredient(id: "2", name: "Garlic", quantity: "2", unit: "cloves"),
                Ingredient(id: "3", name: "Ginger", quantity: "1/2", unit: "inch"),
                Ingredient(id: "4", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "5", name: "Lemon Juice", quantity: "1", unit: "tbsp"),
                Ingredient(id: "6", name: "Coriander Leaves", quantity: "1", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Pressure cook dal with ginger, garlic and turmeric in 2 cups water, 2 whistles", image: nil, duration: 600),
                CookingStep(id: "2", stepNumber: 2, instruction: "Open and mash dal lightly for a slightly thick soup", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Adjust water consistency, simmer 5 min", image: nil, duration: 300),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add lemon juice, coriander and serve warm", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 130, protein: "9g", carbs: "20g", fat: "1g", fiber: "6g"),
            rating: 4.6,
            reviews: 134,
            mode: .weightLoss
        ))

        extra.append(Recipe(
            id: "xwl_05",
            title: "Besan Vegetable Wrap",
            description: "Gram flour roti stuffed with sautéed vegetables — very low fat",
            heroImage: "fork.knife.circle.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 15,
            cookingTime: 15,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Besan Flour", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "medium"),
                Ingredient(id: "3", name: "Capsicum", quantity: "1", unit: "medium"),
                Ingredient(id: "4", name: "Cabbage", quantity: "1", unit: "cup"),
                Ingredient(id: "5", name: "Lemon Juice", quantity: "1", unit: "tbsp"),
                Ingredient(id: "6", name: "Cumin Powder", quantity: "1/2", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Make thin besan chilla (pancake) and set aside", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Sauté onion, capsicum and cabbage with cumin 5 min", image: nil, duration: 300),
                CookingStep(id: "3", stepNumber: 3, instruction: "Sprinkle lemon juice and mix", image: nil, duration: 30),
                CookingStep(id: "4", stepNumber: 4, instruction: "Place filling on chilla and roll tightly. Serve with mint chutney", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 195, protein: "10g", carbs: "28g", fat: "3g", fiber: "6g"),
            rating: 4.5,
            reviews: 112,
            mode: .weightLoss
        ))

        extra.append(Recipe(
            id: "xwl_06",
            title: "Steamed Sprouts",
            description: "Simple steamed mixed sprouts with lemon and spices — zero oil snack",
            heroImage: "leaf.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Snacks",
            preparationTime: 5,
            cookingTime: 5,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Mixed Sprouts", quantity: "2", unit: "cups"),
                Ingredient(id: "2", name: "Lemon Juice", quantity: "2", unit: "tbsp"),
                Ingredient(id: "3", name: "Chaat Masala", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "4", name: "Green Chili", quantity: "1", unit: "pcs"),
                Ingredient(id: "5", name: "Coriander Leaves", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Steam sprouts 3-5 min until just warm and soft enough to eat", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Allow to cool slightly", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add lemon juice, chaat masala, chopped chili and coriander", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Toss well and serve immediately", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 80, protein: "7g", carbs: "11g", fat: "1g", fiber: "5g"),
            rating: 4.4,
            reviews: 98,
            mode: .weightLoss
        ))

        extra.append(Recipe(
            id: "xwl_07",
            title: "Jeera Rice with Raita",
            description: "Simple cumin rice with cooling yogurt — light and balanced meal",
            heroImage: "circle.grid.2x2.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Lunch",
            preparationTime: 5,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Brown Rice", quantity: "1/2", unit: "cup"),
                Ingredient(id: "2", name: "Cumin Seeds", quantity: "1", unit: "tsp"),
                Ingredient(id: "3", name: "Low-Fat Curd", quantity: "1", unit: "cup"),
                Ingredient(id: "4", name: "Cucumber", quantity: "1", unit: "small"),
                Ingredient(id: "5", name: "Mint Leaves", quantity: "10", unit: "leaves"),
                Ingredient(id: "6", name: "Oil", quantity: "1/2", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cook brown rice with 1.5x water until done", image: nil, duration: 1200),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat tiny bit of oil, add cumin seeds to splutter, mix into cooked rice", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Whisk curd with grated cucumber and chopped mint for raita", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Serve jeera rice with raita on the side", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 240, protein: "9g", carbs: "40g", fat: "4g", fiber: "4g"),
            rating: 4.5,
            reviews: 145,
            mode: .weightLoss
        ))

        extra.append(Recipe(
            id: "xwl_08",
            title: "Green Vegetable Soup",
            description: "Zero-oil warming soup with broccoli, peas and spinach",
            heroImage: "leaf.circle.fill",
            cuisine: "International",
            diet: "Vegan",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 15,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Broccoli", quantity: "200", unit: "g"),
                Ingredient(id: "2", name: "Spinach", quantity: "1", unit: "cup"),
                Ingredient(id: "3", name: "Green Peas", quantity: "1/2", unit: "cup"),
                Ingredient(id: "4", name: "Onion", quantity: "1", unit: "medium"),
                Ingredient(id: "5", name: "Garlic", quantity: "2", unit: "cloves"),
                Ingredient(id: "6", name: "Black Pepper", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "7", name: "Lemon Juice", quantity: "1", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Boil onion, garlic, broccoli and peas in 3 cups water for 10 min", image: nil, duration: 600),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add spinach, cook 2 more minutes", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Blend to smooth consistency", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add lemon juice, black pepper. Serve hot", image: nil, duration: 60)
            ],
            nutrition: Nutrition(calories: 90, protein: "6g", carbs: "14g", fat: "1g", fiber: "6g"),
            rating: 4.7,
            reviews: 176,
            mode: .weightLoss
        ))

        extra.append(Recipe(
            id: "xwl_09",
            title: "Nimbu Pani",
            description: "Classic Indian lemon water — hydrating, zero calories, metabolism boosting",
            heroImage: "drop.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Beverages",
            preparationTime: 5,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Lemon", quantity: "2", unit: "pcs"),
                Ingredient(id: "2", name: "Water", quantity: "2", unit: "glasses"),
                Ingredient(id: "3", name: "Cumin Powder (Roasted)", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "4", name: "Black Salt", quantity: "1", unit: "pinch"),
                Ingredient(id: "5", name: "Mint Leaves", quantity: "6", unit: "leaves")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Squeeze lemons into water", image: nil, duration: 30),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add black salt and roasted cumin powder", image: nil, duration: 30),
                CookingStep(id: "3", stepNumber: 3, instruction: "Stir well and add mint leaves", image: nil, duration: 30),
                CookingStep(id: "4", stepNumber: 4, instruction: "Serve with ice cubes", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 20, protein: "0g", carbs: "5g", fat: "0g", fiber: "0g"),
            rating: 4.7,
            reviews: 312,
            mode: .weightLoss
        ))

        extra.append(Recipe(
            id: "xwl_10",
            title: "Cabbage Stir Fry",
            description: "Quick cabbage sabzi — extremely low calorie, high volume side dish",
            heroImage: "leaf.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 10,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Cabbage", quantity: "500", unit: "g"),
                Ingredient(id: "2", name: "Mustard Seeds", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "3", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "4", name: "Green Chili", quantity: "1", unit: "pcs"),
                Ingredient(id: "5", name: "Curry Leaves", quantity: "8", unit: "leaves"),
                Ingredient(id: "6", name: "Oil", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Shred cabbage finely", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat oil, add mustard seeds, curry leaves and chili", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add cabbage and turmeric. Stir on high heat 2 min", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Cover, cook 5-7 min on low until tender but not mushy. Season and serve", image: nil, duration: 420)
            ],
            nutrition: Nutrition(calories: 60, protein: "2g", carbs: "8g", fat: "2g", fiber: "3g"),
            rating: 4.3,
            reviews: 88,
            mode: .weightLoss
        ))

        extra.append(Recipe(
            id: "xwl_11",
            title: "Apple with Peanut Butter",
            description: "Simple two-ingredient snack — fibre and protein to kill hunger",
            heroImage: "heart.fill",
            cuisine: "International",
            diet: "Vegan",
            category: "Snacks",
            preparationTime: 3,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 1,
            ingredients: [
                Ingredient(id: "1", name: "Apple", quantity: "1", unit: "medium"),
                Ingredient(id: "2", name: "Natural Peanut Butter", quantity: "1", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Wash and slice apple into wedges", image: nil, duration: 60),
                CookingStep(id: "2", stepNumber: 2, instruction: "Serve apple slices with peanut butter for dipping", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 170, protein: "4g", carbs: "28g", fat: "6g", fiber: "5g"),
            rating: 4.6,
            reviews: 201,
            mode: .weightLoss
        ))

        // ─────────────────────────────
        // MARK: WEIGHT GAIN MODE
        // ─────────────────────────────

        extra.append(Recipe(
            id: "xwg_01",
            title: "Aloo Paratha with Ghee",
            description: "Stuffed potato flatbread with ghee — affordable calorie-dense breakfast",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 20,
            cookingTime: 20,
            difficulty: "Medium",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Whole Wheat Flour", quantity: "2", unit: "cups"),
                Ingredient(id: "2", name: "Potato", quantity: "3", unit: "medium"),
                Ingredient(id: "3", name: "Ghee", quantity: "3", unit: "tbsp"),
                Ingredient(id: "4", name: "Cumin Powder", quantity: "1", unit: "tsp"),
                Ingredient(id: "5", name: "Coriander Leaves", quantity: "2", unit: "tbsp"),
                Ingredient(id: "6", name: "Green Chili", quantity: "1", unit: "pcs")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Boil potatoes, peel and mash. Mix with spices and coriander", image: nil, duration: 900),
                CookingStep(id: "2", stepNumber: 2, instruction: "Knead dough with flour and water into a smooth ball", image: nil, duration: 300),
                CookingStep(id: "3", stepNumber: 3, instruction: "Divide dough, roll flat, stuff with potato filling and seal", image: nil, duration: 480),
                CookingStep(id: "4", stepNumber: 4, instruction: "Roll stuffed paratha gently, cook on hot tawa with ghee both sides until golden", image: nil, duration: 480)
            ],
            nutrition: Nutrition(calories: 410, protein: "10g", carbs: "58g", fat: "14g", fiber: "7g"),
            rating: 4.9,
            reviews: 345,
            mode: .weightGain
        ))

        extra.append(Recipe(
            id: "xwg_02",
            title: "Rajma Chawal",
            description: "Kidney bean curry with white rice — the ultimate Indian comfort bulking meal",
            heroImage: "fork.knife.circle.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 20,
            cookingTime: 40,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Rajma (Kidney Beans)", quantity: "1.5", unit: "cups"),
                Ingredient(id: "2", name: "White Rice", quantity: "2", unit: "cups"),
                Ingredient(id: "3", name: "Onion", quantity: "2", unit: "large"),
                Ingredient(id: "4", name: "Tomato", quantity: "3", unit: "medium"),
                Ingredient(id: "5", name: "Ginger Garlic Paste", quantity: "1", unit: "tbsp"),
                Ingredient(id: "6", name: "Rajma Masala", quantity: "2", unit: "tsp"),
                Ingredient(id: "7", name: "Oil", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Soak rajma overnight. Pressure cook until tender, 6-8 whistles", image: nil, duration: 28800),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat oil, sauté onion until brown. Add ginger garlic paste", image: nil, duration: 480),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add tomatoes, cook 8 min until mashy. Add rajma masala", image: nil, duration: 480),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add cooked rajma with cooking water, simmer 15 min until thick", image: nil, duration: 900),
                CookingStep(id: "5", stepNumber: 5, instruction: "Cook rice separately. Serve rajma over hot rice", image: nil, duration: 1200)
            ],
            nutrition: Nutrition(calories: 490, protein: "20g", carbs: "80g", fat: "10g", fiber: "14g"),
            rating: 4.9,
            reviews: 423,
            mode: .weightGain
        ))

        extra.append(Recipe(
            id: "xwg_03",
            title: "Egg Rice",
            description: "Quick egg fried rice — affordable, calorie-dense and filling",
            heroImage: "flame.fill",
            cuisine: "Indian",
            diet: "Gluten-Free",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 15,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Cooked Rice", quantity: "2", unit: "cups"),
                Ingredient(id: "2", name: "Eggs", quantity: "3", unit: "pcs"),
                Ingredient(id: "3", name: "Onion", quantity: "1", unit: "medium"),
                Ingredient(id: "4", name: "Carrot", quantity: "1", unit: "small"),
                Ingredient(id: "5", name: "Garlic", quantity: "2", unit: "cloves"),
                Ingredient(id: "6", name: "Soy Sauce", quantity: "1", unit: "tbsp"),
                Ingredient(id: "7", name: "Oil", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Heat oil in a wok. Add garlic and onion, fry 2 min on high heat", image: nil, duration: 120),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add carrot and cook 2 min", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Push to side, scramble beaten eggs in pan", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add rice and soy sauce. Toss everything on high heat 3 min", image: nil, duration: 180)
            ],
            nutrition: Nutrition(calories: 445, protein: "18g", carbs: "58g", fat: "16g", fiber: "3g"),
            rating: 4.7,
            reviews: 256,
            mode: .weightGain
        ))

        extra.append(Recipe(
            id: "xwg_04",
            title: "Bread Omelette",
            description: "Loaded bread and egg sandwich — classic high-calorie street breakfast",
            heroImage: "flame.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 5,
            cookingTime: 10,
            difficulty: "Easy",
            servings: 1,
            ingredients: [
                Ingredient(id: "1", name: "Bread", quantity: "4", unit: "slices"),
                Ingredient(id: "2", name: "Eggs", quantity: "3", unit: "pcs"),
                Ingredient(id: "3", name: "Onion", quantity: "1", unit: "small"),
                Ingredient(id: "4", name: "Tomato", quantity: "1", unit: "small"),
                Ingredient(id: "5", name: "Butter", quantity: "2", unit: "tsp"),
                Ingredient(id: "6", name: "Green Chili", quantity: "1", unit: "pcs")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Beat eggs with chopped onion, tomato, chili and salt", image: nil, duration: 60),
                CookingStep(id: "2", stepNumber: 2, instruction: "Butter a hot pan and pour egg mixture", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Before egg sets, place 2 bread slices on top, press gently", image: nil, duration: 30),
                CookingStep(id: "4", stepNumber: 4, instruction: "Flip and cook bread side for 2 min. Serve hot", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 480, protein: "25g", carbs: "46g", fat: "20g", fiber: "3g"),
            rating: 4.8,
            reviews: 312,
            mode: .weightGain
        ))

        extra.append(Recipe(
            id: "xwg_05",
            title: "Banana Milk Shake",
            description: "Simple 3-ingredient high calorie shake — perfect post-workout",
            heroImage: "cup.and.saucer.fill",
            cuisine: "International",
            diet: "Vegetarian",
            category: "Beverages",
            preparationTime: 5,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 1,
            ingredients: [
                Ingredient(id: "1", name: "Ripe Banana", quantity: "2", unit: "large"),
                Ingredient(id: "2", name: "Full Fat Milk", quantity: "1.5", unit: "cups"),
                Ingredient(id: "3", name: "Honey", quantity: "2", unit: "tsp"),
                Ingredient(id: "4", name: "Cardamom Powder", quantity: "1", unit: "pinch")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Peel bananas and break into pieces", image: nil, duration: 30),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add all ingredients to blender", image: nil, duration: 30),
                CookingStep(id: "3", stepNumber: 3, instruction: "Blend until thick and creamy, about 45 seconds", image: nil, duration: 45),
                CookingStep(id: "4", stepNumber: 4, instruction: "Drink immediately or chill for 15 min", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 420, protein: "11g", carbs: "68g", fat: "10g", fiber: "4g"),
            rating: 4.9,
            reviews: 378,
            mode: .weightGain
        ))

        extra.append(Recipe(
            id: "xwg_06",
            title: "Chole Bhature",
            description: "Spicy chickpea curry with fried bread — festive high-calorie meal",
            heroImage: "circle.grid.cross.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 30,
            cookingTime: 40,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Chickpeas", quantity: "2", unit: "cups"),
                Ingredient(id: "2", name: "Maida (All Purpose Flour)", quantity: "2", unit: "cups"),
                Ingredient(id: "3", name: "Curd", quantity: "1/4", unit: "cup"),
                Ingredient(id: "4", name: "Onion", quantity: "2", unit: "large"),
                Ingredient(id: "5", name: "Tomato", quantity: "2", unit: "large"),
                Ingredient(id: "6", name: "Chole Masala", quantity: "2", unit: "tsp"),
                Ingredient(id: "7", name: "Oil for Frying", quantity: "200", unit: "ml")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Soak chickpeas overnight. Pressure cook 6-8 whistles until soft", image: nil, duration: 28800),
                CookingStep(id: "2", stepNumber: 2, instruction: "Cook onion-tomato masala, add chole masala and chickpeas. Simmer 20 min", image: nil, duration: 1200),
                CookingStep(id: "3", stepNumber: 3, instruction: "Knead bhatura dough with maida, curd and salt. Rest 2 hours", image: nil, duration: 7200),
                CookingStep(id: "4", stepNumber: 4, instruction: "Roll bhaturas, deep fry in hot oil until puffed and golden", image: nil, duration: 600)
            ],
            nutrition: Nutrition(calories: 580, protein: "18g", carbs: "76g", fat: "22g", fiber: "10g"),
            rating: 4.9,
            reviews: 412,
            mode: .weightGain
        ))

        extra.append(Recipe(
            id: "xwg_07",
            title: "Paneer Bhurji with Roti",
            description: "Scrambled cottage cheese with 3 rotis — high protein vegetarian bulking meal",
            heroImage: "flame.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 15,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Paneer", quantity: "250", unit: "g"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "large"),
                Ingredient(id: "3", name: "Tomato", quantity: "2", unit: "medium"),
                Ingredient(id: "4", name: "Capsicum", quantity: "1", unit: "medium"),
                Ingredient(id: "5", name: "Cumin Seeds", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "6", name: "Garam Masala", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "7", name: "Whole Wheat Roti", quantity: "6", unit: "pcs")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Crumble paneer into small pieces", image: nil, duration: 60),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat oil, add cumin, then onion. Cook until golden", image: nil, duration: 240),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add capsicum and tomato, cook 4 min. Add garam masala", image: nil, duration: 240),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add crumbled paneer, toss and cook 3 min. Serve with hot rotis", image: nil, duration: 180)
            ],
            nutrition: Nutrition(calories: 530, protein: "28g", carbs: "48g", fat: "24g", fiber: "6g"),
            rating: 4.8,
            reviews: 234,
            mode: .weightGain
        ))

        extra.append(Recipe(
            id: "xwg_08",
            title: "Mixed Nuts and Dry Fruit Snack",
            description: "A handful of everyday nuts and raisins — easiest calorie-dense snack",
            heroImage: "circle.grid.2x2.fill",
            cuisine: "International",
            diet: "Vegan",
            category: "Snacks",
            preparationTime: 2,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 1,
            ingredients: [
                Ingredient(id: "1", name: "Almonds", quantity: "10", unit: "pcs"),
                Ingredient(id: "2", name: "Cashews", quantity: "8", unit: "pcs"),
                Ingredient(id: "3", name: "Walnuts", quantity: "4", unit: "pcs"),
                Ingredient(id: "4", name: "Raisins", quantity: "2", unit: "tbsp"),
                Ingredient(id: "5", name: "Dates", quantity: "3", unit: "pcs")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Combine all nuts in a small bowl", image: nil, duration: 30),
                CookingStep(id: "2", stepNumber: 2, instruction: "Add raisins and chopped dates", image: nil, duration: 30),
                CookingStep(id: "3", stepNumber: 3, instruction: "Mix and eat as a snack between meals", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 380, protein: "9g", carbs: "38g", fat: "22g", fiber: "5g"),
            rating: 4.7,
            reviews: 289,
            mode: .weightGain
        ))

        extra.append(Recipe(
            id: "xwg_09",
            title: "Dal Makhani",
            description: "Creamy black lentil curry — slow cooked, rich and calorie dense",
            heroImage: "drop.circle.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Dinner",
            preparationTime: 20,
            cookingTime: 60,
            difficulty: "Medium",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Black Urad Dal (whole)", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Rajma", quantity: "1/4", unit: "cup"),
                Ingredient(id: "3", name: "Butter", quantity: "3", unit: "tbsp"),
                Ingredient(id: "4", name: "Fresh Cream", quantity: "4", unit: "tbsp"),
                Ingredient(id: "5", name: "Tomato Puree", quantity: "3/4", unit: "cup"),
                Ingredient(id: "6", name: "Ginger Garlic Paste", quantity: "1", unit: "tbsp"),
                Ingredient(id: "7", name: "Garam Masala", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Soak urad dal and rajma overnight. Pressure cook until very soft, 8-10 whistles", image: nil, duration: 28800),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat butter, sauté ginger garlic paste 2 min", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add tomato puree and garam masala. Cook 8 min on low", image: nil, duration: 480),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add cooked dal and simmer 30-40 min on very low heat, stirring occasionally. Add cream and serve", image: nil, duration: 2400)
            ],
            nutrition: Nutrition(calories: 365, protein: "14g", carbs: "40g", fat: "16g", fiber: "11g"),
            rating: 4.9,
            reviews: 456,
            mode: .weightGain
        ))

        extra.append(Recipe(
            id: "xwg_10",
            title: "Bread Upma",
            description: "Leftover bread turned into a filling upma — great for morning bulk",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 5,
            cookingTime: 10,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Bread", quantity: "6", unit: "slices"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "medium"),
                Ingredient(id: "3", name: "Green Peas", quantity: "1/4", unit: "cup"),
                Ingredient(id: "4", name: "Mustard Seeds", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "5", name: "Curry Leaves", quantity: "8", unit: "leaves"),
                Ingredient(id: "6", name: "Butter", quantity: "1", unit: "tbsp"),
                Ingredient(id: "7", name: "Lemon Juice", quantity: "1", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Cut bread into small cubes or crumble roughly", image: nil, duration: 60),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat butter, add mustard and curry leaves", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Sauté onion and peas until soft, 4 min", image: nil, duration: 240),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add bread pieces, toss well on medium heat 3 min. Add lemon juice and serve", image: nil, duration: 180)
            ],
            nutrition: Nutrition(calories: 340, protein: "9g", carbs: "50g", fat: "10g", fiber: "4g"),
            rating: 4.5,
            reviews: 167,
            mode: .weightGain
        ))

        extra.append(Recipe(
            id: "xwg_11",
            title: "Sabudana Khichdi",
            description: "Tapioca pearls cooked with peanuts and potato — energy-dense and filling",
            heroImage: "circle.grid.2x2.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Breakfast",
            preparationTime: 240,
            cookingTime: 15,
            difficulty: "Medium",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Sabudana (Tapioca Pearls)", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Peanuts", quantity: "1/2", unit: "cup"),
                Ingredient(id: "3", name: "Potato", quantity: "1", unit: "large"),
                Ingredient(id: "4", name: "Green Chili", quantity: "2", unit: "pcs"),
                Ingredient(id: "5", name: "Cumin Seeds", quantity: "1", unit: "tsp"),
                Ingredient(id: "6", name: "Oil", quantity: "2", unit: "tbsp"),
                Ingredient(id: "7", name: "Lemon Juice", quantity: "1", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Soak sabudana in water 3-4 hours. Drain completely", image: nil, duration: 14400),
                CookingStep(id: "2", stepNumber: 2, instruction: "Dry roast peanuts, cool and roughly crush", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Heat oil, add cumin and green chili. Add boiled diced potato and sauté 3 min", image: nil, duration: 240),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add sabudana and peanuts. Toss on medium heat 5-7 min until translucent. Add lemon juice", image: nil, duration: 420)
            ],
            nutrition: Nutrition(calories: 490, protein: "12g", carbs: "72g", fat: "18g", fiber: "5g"),
            rating: 4.8,
            reviews: 223,
            mode: .weightGain
        ))

        // ─────────────────────────────
        // MARK: NORMAL MODE
        // ─────────────────────────────

        extra.append(Recipe(
            id: "xn_01",
            title: "Masala Chai",
            description: "Classic Indian spiced milk tea — the everyday essential",
            heroImage: "cup.and.saucer.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Beverages",
            preparationTime: 2,
            cookingTime: 8,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Water", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Milk", quantity: "1", unit: "cup"),
                Ingredient(id: "3", name: "Tea Leaves", quantity: "2", unit: "tsp"),
                Ingredient(id: "4", name: "Sugar", quantity: "2", unit: "tsp"),
                Ingredient(id: "5", name: "Cardamom", quantity: "2", unit: "pods"),
                Ingredient(id: "6", name: "Ginger", quantity: "1/2", unit: "inch")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Crush cardamom pods. Grate or smash ginger", image: nil, duration: 30),
                CookingStep(id: "2", stepNumber: 2, instruction: "Bring water to boil with ginger and cardamom", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add tea leaves and simmer 2 min", image: nil, duration: 120),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add milk and sugar, bring to boil once and strain into cups", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 80, protein: "3g", carbs: "12g", fat: "3g", fiber: "0g"),
            rating: 4.9,
            reviews: 512,
            mode: .normal
        ))

        extra.append(Recipe(
            id: "xn_02",
            title: "Poha",
            description: "Flattened rice breakfast dish with onion and mustard — ready in 15 min",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Breakfast",
            preparationTime: 5,
            cookingTime: 10,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Poha (Flattened Rice)", quantity: "1.5", unit: "cups"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "medium"),
                Ingredient(id: "3", name: "Green Peas", quantity: "1/4", unit: "cup"),
                Ingredient(id: "4", name: "Mustard Seeds", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "5", name: "Curry Leaves", quantity: "8", unit: "leaves"),
                Ingredient(id: "6", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "7", name: "Lemon Juice", quantity: "1", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Rinse poha, drain and let soften 5 min", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat oil, add mustard seeds and curry leaves", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add onion and peas, sauté 4 min. Add turmeric", image: nil, duration: 240),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add poha, mix gently, cook 2 min. Finish with lemon juice", image: nil, duration: 120)
            ],
            nutrition: Nutrition(calories: 220, protein: "5g", carbs: "40g", fat: "4g", fiber: "4g"),
            rating: 4.7,
            reviews: 389,
            mode: .normal
        ))

        extra.append(Recipe(
            id: "xn_03",
            title: "Aloo Sabzi",
            description: "Simple spiced potato curry — pairs with any roti or rice",
            heroImage: "leaf.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Lunch",
            preparationTime: 10,
            cookingTime: 20,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Potato", quantity: "4", unit: "medium"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "medium"),
                Ingredient(id: "3", name: "Tomato", quantity: "2", unit: "medium"),
                Ingredient(id: "4", name: "Cumin Seeds", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "5", name: "Coriander Powder", quantity: "1", unit: "tsp"),
                Ingredient(id: "6", name: "Turmeric", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "7", name: "Oil", quantity: "2", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Peel and cube potatoes. Boil or pressure cook until 80% done", image: nil, duration: 600),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat oil, add cumin, then chopped onion. Cook until golden", image: nil, duration: 240),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add tomato and all spices. Cook 4 min until oil separates", image: nil, duration: 240),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add potatoes, mix well and cook covered 5-7 min. Garnish with coriander", image: nil, duration: 420)
            ],
            nutrition: Nutrition(calories: 185, protein: "4g", carbs: "32g", fat: "4g", fiber: "4g"),
            rating: 4.6,
            reviews: 445,
            mode: .normal
        ))

        extra.append(Recipe(
            id: "xn_04",
            title: "Dal Tadka",
            description: "Everyday tempered yellow lentil curry — the backbone of Indian cooking",
            heroImage: "drop.circle.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Dinner",
            preparationTime: 5,
            cookingTime: 25,
            difficulty: "Easy",
            servings: 4,
            ingredients: [
                Ingredient(id: "1", name: "Toor Dal (Yellow Lentils)", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "medium"),
                Ingredient(id: "3", name: "Tomato", quantity: "2", unit: "medium"),
                Ingredient(id: "4", name: "Garlic", quantity: "4", unit: "cloves"),
                Ingredient(id: "5", name: "Cumin Seeds", quantity: "1", unit: "tsp"),
                Ingredient(id: "6", name: "Dry Red Chili", quantity: "2", unit: "pcs"),
                Ingredient(id: "7", name: "Ghee", quantity: "1", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Pressure cook dal with tomato and turmeric, 3 whistles. Mash lightly", image: nil, duration: 900),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat ghee in a small pan. Add cumin, dry red chili and sliced garlic", image: nil, duration: 90),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add chopped onion and cook until golden brown, 5 min", image: nil, duration: 300),
                CookingStep(id: "4", stepNumber: 4, instruction: "Pour tadka over dal. Mix well, simmer 5 min. Serve with rice or roti", image: nil, duration: 300)
            ],
            nutrition: Nutrition(calories: 195, protein: "12g", carbs: "30g", fat: "4g", fiber: "8g"),
            rating: 4.9,
            reviews: 567,
            mode: .normal
        ))

        extra.append(Recipe(
            id: "xn_05",
            title: "Upma",
            description: "Semolina breakfast — quick, filling and easy on the wallet",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Breakfast",
            preparationTime: 5,
            cookingTime: 15,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Semolina (Rava)", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "medium"),
                Ingredient(id: "3", name: "Carrot", quantity: "1", unit: "small"),
                Ingredient(id: "4", name: "Mustard Seeds", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "5", name: "Curry Leaves", quantity: "8", unit: "leaves"),
                Ingredient(id: "6", name: "Cashews", quantity: "8", unit: "pcs"),
                Ingredient(id: "7", name: "Oil", quantity: "2", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Dry roast rava in a pan until light golden, set aside", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat oil, fry cashews. Add mustard, curry leaves, onion and carrot", image: nil, duration: 240),
                CookingStep(id: "3", stepNumber: 3, instruction: "Add 2 cups water with salt and bring to boil", image: nil, duration: 180),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add roasted rava slowly, stirring constantly. Cook on low 5 min, stirring, until done", image: nil, duration: 300)
            ],
            nutrition: Nutrition(calories: 240, protein: "6g", carbs: "40g", fat: "6g", fiber: "3g"),
            rating: 4.7,
            reviews: 312,
            mode: .normal
        ))

        extra.append(Recipe(
            id: "xn_06",
            title: "Bhindi Masala",
            description: "Crispy okra stir-fry with spices — quick weeknight dinner",
            heroImage: "leaf.fill",
            cuisine: "Indian",
            diet: "Vegan",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 15,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Okra (Bhindi)", quantity: "400", unit: "g"),
                Ingredient(id: "2", name: "Onion", quantity: "1", unit: "large"),
                Ingredient(id: "3", name: "Tomato", quantity: "1", unit: "medium"),
                Ingredient(id: "4", name: "Cumin Seeds", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "5", name: "Coriander Powder", quantity: "1", unit: "tsp"),
                Ingredient(id: "6", name: "Amchur Powder", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "7", name: "Oil", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Wash and dry bhindi completely. Slice into 1-inch pieces", image: nil, duration: 180),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat oil, fry bhindi on medium-high heat 7-8 min until non-sticky and crisp", image: nil, duration: 480),
                CookingStep(id: "3", stepNumber: 3, instruction: "Remove bhindi. In same oil sauté onion until golden, add tomato and cook 3 min", image: nil, duration: 300),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add spices and fried bhindi. Toss and cook 3 min. Serve with roti", image: nil, duration: 180)
            ],
            nutrition: Nutrition(calories: 130, protein: "3g", carbs: "14g", fat: "7g", fiber: "5g"),
            rating: 4.7,
            reviews: 289,
            mode: .normal
        ))

        extra.append(Recipe(
            id: "xn_07",
            title: "Rava Idli",
            description: "Instant semolina idli — no soaking or fermentation needed",
            heroImage: "circle.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 15,
            cookingTime: 15,
            difficulty: "Easy",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Rava (Semolina)", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Curd", quantity: "1", unit: "cup"),
                Ingredient(id: "3", name: "Baking Soda", quantity: "1/4", unit: "tsp"),
                Ingredient(id: "4", name: "Mustard Seeds", quantity: "1/2", unit: "tsp"),
                Ingredient(id: "5", name: "Cashews", quantity: "8", unit: "pcs"),
                Ingredient(id: "6", name: "Curry Leaves", quantity: "8", unit: "leaves")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Dry roast rava. Mix with curd and baking soda. Let rest 10 min", image: nil, duration: 600),
                CookingStep(id: "2", stepNumber: 2, instruction: "Grease idli moulds. Place a cashew and curry leaf in each mould", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Fill moulds with batter 3/4 full", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Steam 12-15 min until a toothpick comes out clean. Serve with chutney", image: nil, duration: 900)
            ],
            nutrition: Nutrition(calories: 195, protein: "7g", carbs: "32g", fat: "4g", fiber: "2g"),
            rating: 4.6,
            reviews: 234,
            mode: .normal
        ))

        extra.append(Recipe(
            id: "xn_08",
            title: "Egg Curry",
            description: "Boiled eggs in a spicy tomato-onion gravy — affordable protein-rich dinner",
            heroImage: "drop.circle.fill",
            cuisine: "Indian",
            diet: "Gluten-Free",
            category: "Dinner",
            preparationTime: 10,
            cookingTime: 25,
            difficulty: "Medium",
            servings: 3,
            ingredients: [
                Ingredient(id: "1", name: "Eggs", quantity: "6", unit: "pcs"),
                Ingredient(id: "2", name: "Onion", quantity: "2", unit: "large"),
                Ingredient(id: "3", name: "Tomato", quantity: "2", unit: "large"),
                Ingredient(id: "4", name: "Ginger Garlic Paste", quantity: "1", unit: "tbsp"),
                Ingredient(id: "5", name: "Garam Masala", quantity: "1", unit: "tsp"),
                Ingredient(id: "6", name: "Oil", quantity: "2", unit: "tbsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Hard boil eggs, peel and make shallow cuts on them", image: nil, duration: 600),
                CookingStep(id: "2", stepNumber: 2, instruction: "Heat oil, fry eggs lightly until golden. Remove and set aside", image: nil, duration: 180),
                CookingStep(id: "3", stepNumber: 3, instruction: "In same oil cook onion until brown, add ginger garlic paste", image: nil, duration: 360),
                CookingStep(id: "4", stepNumber: 4, instruction: "Add tomatoes and all spices. Cook 8 min until thick gravy forms. Add eggs, simmer 5 min", image: nil, duration: 780)
            ],
            nutrition: Nutrition(calories: 265, protein: "18g", carbs: "10g", fat: "16g", fiber: "2g"),
            rating: 4.8,
            reviews: 334,
            mode: .normal
        ))

        extra.append(Recipe(
            id: "xn_09",
            title: "Dahi Chura",
            description: "Flattened rice with yogurt and banana — simple Bihar-style breakfast",
            heroImage: "circle.hexagongrid.fill",
            cuisine: "Indian",
            diet: "Vegetarian",
            category: "Breakfast",
            preparationTime: 5,
            cookingTime: 0,
            difficulty: "Easy",
            servings: 2,
            ingredients: [
                Ingredient(id: "1", name: "Thick Poha (Chura)", quantity: "1", unit: "cup"),
                Ingredient(id: "2", name: "Curd", quantity: "1", unit: "cup"),
                Ingredient(id: "3", name: "Banana", quantity: "1", unit: "pcs"),
                Ingredient(id: "4", name: "Sugar", quantity: "1", unit: "tsp"),
                Ingredient(id: "5", name: "Salt", quantity: "1", unit: "pinch")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Wash thick poha and soak 3-5 minutes until just softened", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Drain and squeeze out excess water", image: nil, duration: 60),
                CookingStep(id: "3", stepNumber: 3, instruction: "Mix poha with curd, sugar and a pinch of salt", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Slice banana over the top and serve immediately", image: nil, duration: 30)
            ],
            nutrition: Nutrition(calories: 235, protein: "8g", carbs: "44g", fat: "3g", fiber: "3g"),
            rating: 4.5,
            reviews: 178,
            mode: .normal
        ))

        extra.append(Recipe(
            id: "xn_10",
            title: "Banana Bread",
            description: "Moist homemade banana bread — great use of overripe bananas",
            heroImage: "birthday.cake.fill",
            cuisine: "International",
            diet: "Vegetarian",
            category: "Snacks",
            preparationTime: 15,
            cookingTime: 50,
            difficulty: "Medium",
            servings: 8,
            ingredients: [
                Ingredient(id: "1", name: "Ripe Banana", quantity: "3", unit: "large"),
                Ingredient(id: "2", name: "All Purpose Flour", quantity: "1.5", unit: "cups"),
                Ingredient(id: "3", name: "Sugar", quantity: "3/4", unit: "cup"),
                Ingredient(id: "4", name: "Egg", quantity: "2", unit: "pcs"),
                Ingredient(id: "5", name: "Butter", quantity: "1/3", unit: "cup"),
                Ingredient(id: "6", name: "Baking Soda", quantity: "1", unit: "tsp"),
                Ingredient(id: "7", name: "Vanilla Extract", quantity: "1", unit: "tsp")
            ],
            steps: [
                CookingStep(id: "1", stepNumber: 1, instruction: "Mash bananas until smooth. Preheat oven 175°C", image: nil, duration: 300),
                CookingStep(id: "2", stepNumber: 2, instruction: "Melt butter, mix with sugar and eggs. Add mashed banana and vanilla", image: nil, duration: 120),
                CookingStep(id: "3", stepNumber: 3, instruction: "Fold in flour and baking soda gently until just combined", image: nil, duration: 60),
                CookingStep(id: "4", stepNumber: 4, instruction: "Pour into greased loaf tin and bake 45-50 min until golden", image: nil, duration: 3000)
            ],
            nutrition: Nutrition(calories: 245, protein: "4g", carbs: "42g", fat: "7g", fiber: "2g"),
            rating: 4.8,
            reviews: 423,
            mode: .normal
        ))

        recipes.append(contentsOf: extra)
    }
}
