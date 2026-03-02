import SwiftUI

// MARK: - EditRecipeView
// Pre-populates all fields from an existing custom recipe and saves changes locally.

struct EditRecipeView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var db: LocalDatabaseManager
    @EnvironmentObject var modeManager: HealthModeManager

    let recipe: Recipe

    // Basic info
    @State private var title: String
    @State private var description: String
    @State private var category: String
    @State private var cuisine: String
    @State private var diet: String
    @State private var difficulty: String
    @State private var servings: String
    @State private var prepTime: String
    @State private var cookTime: String

    // Nutrition
    @State private var calories: String
    @State private var protein: String
    @State private var carbs: String
    @State private var fat: String

    // Dynamic lists
    @State private var ingredients: [EditDraftIngredient]
    @State private var steps: [EditDraftStep]

    // UI state
    @State private var showValidationAlert = false
    @State private var validationMessage = ""

    private let categories  = ["Breakfast", "Lunch", "Dinner", "Dessert", "Snacks", "Beverages"]
    private let diets       = ["None", "Vegetarian", "Vegan", "Non-Veg", "Gluten-Free", "Dairy-Free", "Keto", "Paleo"]
    private let difficulties = ["Easy", "Medium", "Hard"]
    private let units       = ["g", "kg", "ml", "l", "cup", "tbsp", "tsp", "oz", "lb", "pcs", "bunch", "slice"]

    // MARK: - Init: pre-populate all fields from recipe

    init(recipe: Recipe) {
        self.recipe = recipe
        _title       = State(initialValue: recipe.title)
        _description = State(initialValue: recipe.description)
        _category    = State(initialValue: recipe.category)
        _cuisine     = State(initialValue: recipe.cuisine == "Custom" ? "" : recipe.cuisine)
        // Map stored diet value back to picker option
        let storedDiet = recipe.diet
        let knownDiets = ["None", "Vegetarian", "Vegan", "Non-Veg", "Gluten-Free", "Dairy-Free", "Keto", "Paleo"]
        _diet        = State(initialValue: knownDiets.contains(storedDiet) ? storedDiet : (storedDiet == "Custom" ? "None" : storedDiet))
        _difficulty  = State(initialValue: recipe.difficulty)
        _servings    = State(initialValue: "\(recipe.servings)")
        _prepTime    = State(initialValue: "\(recipe.preparationTime)")
        _cookTime    = State(initialValue: "\(recipe.cookingTime)")
        _calories    = State(initialValue: "\(recipe.nutrition.calories)")
        // Strip trailing 'g' suffix stored in nutrition strings
        _protein     = State(initialValue: recipe.nutrition.protein.replacingOccurrences(of: "g", with: ""))
        _carbs       = State(initialValue: recipe.nutrition.carbs.replacingOccurrences(of: "g", with: ""))
        _fat         = State(initialValue: recipe.nutrition.fat.replacingOccurrences(of: "g", with: ""))
        _ingredients = State(initialValue: recipe.ingredients.map {
            EditDraftIngredient(id: UUID(), name: $0.name, quantity: $0.quantity, unit: $0.unit)
        })
        _steps = State(initialValue: recipe.steps.map {
            EditDraftStep(id: UUID(), instruction: $0.instruction,
                          durationMinutes: $0.duration.map { "\($0 / 60)" } ?? "")
        })
    }

    // MARK: - Computed Helpers

    private var heroIcon: String {
        switch category {
        case "Breakfast":  return "sunrise.fill"
        case "Lunch":      return "sun.max.fill"
        case "Dinner":     return "moon.stars.fill"
        case "Dessert":    return "birthday.cake.fill"
        case "Snacks":     return "leaf.fill"
        case "Beverages":  return "cup.and.saucer.fill"
        default:           return "fork.knife"
        }
    }

    private var categoryColor: Color {
        switch category {
        case "Breakfast":  return Color(red: 1.0,  green: 0.72, blue: 0.25)
        case "Lunch":      return Color(red: 0.40, green: 0.78, blue: 0.47)
        case "Dinner":     return Color(red: 0.36, green: 0.54, blue: 0.96)
        case "Dessert":    return Color(red: 0.96, green: 0.42, blue: 0.62)
        case "Snacks":     return Color(red: 0.93, green: 0.62, blue: 0.22)
        case "Beverages":  return Color(red: 0.38, green: 0.74, blue: 0.88)
        default:           return .blue
        }
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    heroPreviewBanner

                    VStack(spacing: 20) {
                        basicInfoSection
                        ingredientsSection
                        stepsSection
                        nutritionSection
                        saveButton
                    }
                    .padding(20)
                    .padding(.bottom, 40)
                }
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle("Edit Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(.blue)
                }
            }
            .alert("Missing Information", isPresented: $showValidationAlert) {
                Button("OK") {}
            } message: {
                Text(validationMessage)
            }
        }
    }

    // MARK: - Hero Preview

    private var heroPreviewBanner: some View {
        ZStack {
            LinearGradient(
                colors: [categoryColor.opacity(0.25), categoryColor.opacity(0.08)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(categoryColor.opacity(0.18))
                        .frame(width: 80, height: 80)
                    Image(systemName: heroIcon)
                        .font(.system(size: 36))
                        .foregroundColor(categoryColor)
                }
                if !title.isEmpty {
                    Text(title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .transition(.opacity)
                }
                Text(category)
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .background(categoryColor.opacity(0.18))
                    .foregroundColor(categoryColor)
                    .cornerRadius(20)
            }
            .padding(.vertical, 28)
        }
        .animation(.easeInOut(duration: 0.2), value: title)
        .animation(.easeInOut(duration: 0.2), value: category)
    }

    // MARK: - Basic Info

    private var basicInfoSection: some View {
        EditFormCard(title: "Basic Info", icon: "info.circle.fill", color: .blue) {
            VStack(spacing: 14) {
                EditLabeledField(label: "Recipe Name *") {
                    TextField("e.g. Mum's Pasta", text: $title)
                        .textInputAutocapitalization(.words)
                }
                EditLabeledField(label: "Description") {
                    TextField("Short description…", text: $description, axis: .vertical)
                        .lineLimit(2...4)
                }
                EditLabeledField(label: "Category *") {
                    Picker("", selection: $category) {
                        ForEach(categories, id: \.self) { Text($0).tag($0) }
                    }
                    .pickerStyle(.menu)
                    .tint(categoryColor)
                }
                EditLabeledField(label: "Cuisine") {
                    TextField("e.g. Italian", text: $cuisine)
                        .textInputAutocapitalization(.words)
                }
                EditLabeledField(label: "Diet") {
                    Picker("", selection: $diet) {
                        ForEach(diets, id: \.self) { Text($0).tag($0) }
                    }
                    .pickerStyle(.menu)
                    .tint(.secondary)
                }
                HStack(spacing: 12) {
                    EditLabeledField(label: "Difficulty") {
                        Picker("", selection: $difficulty) {
                            ForEach(difficulties, id: \.self) { Text($0).tag($0) }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                HStack(spacing: 12) {
                    EditLabeledField(label: "Prep (min) *") {
                        TextField("15", text: $prepTime)
                            .keyboardType(.numberPad)
                    }
                    EditLabeledField(label: "Cook (min) *") {
                        TextField("30", text: $cookTime)
                            .keyboardType(.numberPad)
                    }
                    EditLabeledField(label: "Servings") {
                        TextField("2", text: $servings)
                            .keyboardType(.numberPad)
                    }
                }
            }
        }
    }

    // MARK: - Ingredients

    private var ingredientsSection: some View {
        EditFormCard(title: "Ingredients", icon: "list.bullet.clipboard.fill", color: .green) {
            VStack(spacing: 10) {
                ForEach($ingredients) { $ingredient in
                    HStack(spacing: 8) {
                        TextField("Name *", text: $ingredient.name)
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)

                        TextField("Qty", text: $ingredient.quantity)
                            .frame(width: 52)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)

                        Menu {
                            ForEach(units, id: \.self) { unit in
                                Button(unit) { ingredient.unit = unit }
                            }
                        } label: {
                            HStack(spacing: 2) {
                                Text(ingredient.unit)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(.secondary)
                            }
                            .frame(width: 70)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }

                        if ingredients.count > 1 {
                            Button(action: { withAnimation { remove(ingredient: ingredient) } }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red.opacity(0.7))
                                    .font(.system(size: 20))
                            }
                        }
                    }
                }

                Button(action: { withAnimation { ingredients.append(EditDraftIngredient()) } }) {
                    HStack(spacing: 6) {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Ingredient")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .foregroundColor(.green)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.green.opacity(0.07))
                    .cornerRadius(10)
                }
            }
        }
    }

    // MARK: - Steps

    private var stepsSection: some View {
        EditFormCard(title: "Instructions", icon: "checklist", color: .purple) {
            VStack(spacing: 12) {
                ForEach(Array(zip(steps.indices, $steps)), id: \.0) { index, $step in
                    HStack(alignment: .top, spacing: 10) {
                        Text("\(index + 1)")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 24, height: 24)
                            .background(Color.purple)
                            .clipShape(Circle())
                            .padding(.top, 10)

                        VStack(spacing: 8) {
                            TextField("Describe this step…", text: $step.instruction, axis: .vertical)
                                .lineLimit(2...5)
                                .padding(10)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)

                            TextField("Duration (min, optional)", text: $step.durationMinutes)
                                .keyboardType(.numberPad)
                                .padding(10)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                        }

                        if steps.count > 1 {
                            Button(action: { withAnimation { remove(step: step) } }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red.opacity(0.7))
                                    .font(.system(size: 20))
                            }
                            .padding(.top, 8)
                        }
                    }
                }

                Button(action: { withAnimation { steps.append(EditDraftStep()) } }) {
                    HStack(spacing: 6) {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Step")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .foregroundColor(.purple)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.purple.opacity(0.07))
                    .cornerRadius(10)
                }
            }
        }
    }

    // MARK: - Nutrition

    private var nutritionSection: some View {
        EditFormCard(title: "Nutrition (per serving)", icon: "chart.pie.fill", color: .orange) {
            HStack(spacing: 10) {
                EditNutritionInput(label: "Calories",   placeholder: "0",  text: $calories, color: .orange,  isNumeric: true)
                EditNutritionInput(label: "Protein (g)", placeholder: "0",  text: $protein,  color: .red,     isNumeric: true)
                EditNutritionInput(label: "Carbs (g)",  placeholder: "0",  text: $carbs,    color: .green,   isNumeric: true)
                EditNutritionInput(label: "Fat (g)",    placeholder: "0",  text: $fat,      color: .yellow,  isNumeric: true)
            }
        }
    }

    // MARK: - Save Button

    private var saveButton: some View {
        Button(action: saveChanges) {
            HStack(spacing: 8) {
                Image(systemName: "checkmark.circle.fill")
                Text("Save Changes")
                    .font(.system(size: 17, weight: .semibold))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .foregroundColor(.white)
            .background(
                LinearGradient(colors: [categoryColor, categoryColor.opacity(0.8)],
                               startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(14)
            .shadow(color: categoryColor.opacity(0.35), radius: 8, x: 0, y: 4)
        }
        .padding(.top, 8)
    }

    // MARK: - Helpers

    private func remove(ingredient: EditDraftIngredient) {
        ingredients.removeAll { $0.id == ingredient.id }
    }

    private func remove(step: EditDraftStep) {
        steps.removeAll { $0.id == step.id }
    }

    // MARK: - Validation & Save

    private func saveChanges() {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            validationMessage = "Please enter a recipe name."
            showValidationAlert = true
            return
        }
        guard let prep = Int(prepTime), prep >= 0 else {
            validationMessage = "Please enter a valid preparation time (in minutes)."
            showValidationAlert = true
            return
        }
        guard let cook = Int(cookTime), cook >= 0 else {
            validationMessage = "Please enter a valid cooking time (in minutes)."
            showValidationAlert = true
            return
        }
        let validIngredients = ingredients.filter { !$0.name.trimmingCharacters(in: .whitespaces).isEmpty }
        guard !validIngredients.isEmpty else {
            validationMessage = "Please add at least one ingredient."
            showValidationAlert = true
            return
        }
        let validSteps = steps.filter { !$0.instruction.trimmingCharacters(in: .whitespaces).isEmpty }
        guard !validSteps.isEmpty else {
            validationMessage = "Please add at least one instruction step."
            showValidationAlert = true
            return
        }

        let finalIngredients: [Ingredient] = validIngredients.map { d in
            Ingredient(
                id: UUID().uuidString,
                name: d.name.trimmingCharacters(in: .whitespaces),
                quantity: d.quantity.isEmpty ? "1" : d.quantity,
                unit: d.unit
            )
        }

        let finalSteps: [CookingStep] = validSteps.enumerated().map { idx, d in
            let durationSecs: Int? = Int(d.durationMinutes).map { $0 * 60 }
            return CookingStep(
                id: UUID().uuidString,
                stepNumber: idx + 1,
                instruction: d.instruction.trimmingCharacters(in: .whitespaces),
                image: nil,
                duration: durationSecs
            )
        }

        let proteinStr = protein.isEmpty ? "0g" : (protein.hasSuffix("g") ? protein : "\(protein)g")
        let carbsStr   = carbs.isEmpty   ? "0g" : (carbs.hasSuffix("g")   ? carbs   : "\(carbs)g")
        let fatStr     = fat.isEmpty     ? "0g" : (fat.hasSuffix("g")     ? fat     : "\(fat)g")

        let nutrition = Nutrition(
            calories: Int(calories) ?? 0,
            protein: proteinStr,
            carbs: carbsStr,
            fat: fatStr,
            fiber: recipe.nutrition.fiber // preserve existing fiber value
        )

        let updated = Recipe(
            id: recipe.id, // preserve original ID
            title: title.trimmingCharacters(in: .whitespaces),
            description: description.isEmpty
                ? "Custom recipe created in Nourish"
                : description.trimmingCharacters(in: .whitespaces),
            heroImage: heroIcon,
            cuisine: cuisine.isEmpty ? "Custom" : cuisine.trimmingCharacters(in: .whitespaces),
            diet: diet == "None" ? "Custom" : diet,
            category: category,
            preparationTime: prep,
            cookingTime: cook,
            difficulty: difficulty,
            servings: Int(servings) ?? 2,
            ingredients: finalIngredients,
            steps: finalSteps,
            nutrition: nutrition,
            rating: recipe.rating,    // preserve original rating
            reviews: recipe.reviews,  // preserve original reviews
            mode: recipe.mode         // preserve original mode — no cross-mode pollution
        )

        db.updateCustomRecipe(updated)
        dismiss()
    }
}

// MARK: - Local draft models (private to this file)

private struct EditDraftIngredient: Identifiable {
    let id: UUID
    var name: String
    var quantity: String
    var unit: String

    init(id: UUID = UUID(), name: String = "", quantity: String = "", unit: String = "g") {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
}

private struct EditDraftStep: Identifiable {
    let id: UUID
    var instruction: String
    var durationMinutes: String

    init(id: UUID = UUID(), instruction: String = "", durationMinutes: String = "") {
        self.id = id
        self.instruction = instruction
        self.durationMinutes = durationMinutes
    }
}

// MARK: - Reusable sub-views (private, scoped to this file)

private struct EditFormCard<Content: View>: View {
    let title: String
    let icon: String
    let color: Color
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(color)
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
            }
            content
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 2)
    }
}

private struct EditLabeledField<Content: View>: View {
    let label: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
                .textCase(.uppercase)
            content
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct EditNutritionInput: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    let color: Color
    let isNumeric: Bool

    var body: some View {
        VStack(spacing: 6) {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.8)

            TextField(placeholder, text: $text)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(color)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(color.opacity(0.10))
                .cornerRadius(10)
        }
    }
}
