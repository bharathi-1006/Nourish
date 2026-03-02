import SwiftUI

// MARK: - Transient input models (only used during form editing)

private struct DraftIngredient: Identifiable {
    let id = UUID()
    var name: String = ""
    var quantity: String = ""
    var unit: String = "g"
}

private struct DraftStep: Identifiable {
    let id = UUID()
    var instruction: String = ""
    var durationMinutes: String = ""
}

// MARK: - CreateRecipeView

struct CreateRecipeView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var db: LocalDatabaseManager
    @EnvironmentObject var modeManager: HealthModeManager

    // Basic info
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var category: String = "Breakfast"
    @State private var cuisine: String = ""
    @State private var diet: String = "None"
    @State private var difficulty: String = "Easy"
    @State private var servings: String = "2"
    @State private var prepTime: String = ""
    @State private var cookTime: String = ""
    @State private var notes: String = ""

    // Nutrition
    @State private var calories: String = ""
    @State private var protein: String = ""
    @State private var carbs: String = ""
    @State private var fat: String = ""

    // Dynamic lists
    @State private var ingredients: [DraftIngredient] = [DraftIngredient()]
    @State private var steps: [DraftStep] = [DraftStep()]

    // UI state
    @State private var showValidationAlert = false
    @State private var validationMessage = ""
    @FocusState private var focusedField: AnyHashable?

    private let categories  = ["Breakfast", "Lunch", "Dinner", "Dessert", "Snacks", "Beverages"]
    private let diets       = ["None", "Vegetarian", "Vegan", "Non-Veg", "Gluten-Free", "Dairy-Free", "Keto", "Paleo"]
    private let difficulties = ["Easy", "Medium", "Hard"]
    private let units       = ["g", "kg", "ml", "l", "cup", "tbsp", "tsp", "oz", "lb", "pcs", "bunch", "slice"]

    // Icon chosen based on category
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

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    // ── Hero Preview ─────────────────────────────────
                    heroPreviewBanner

                    // ── Form Sections ────────────────────────────────
                    VStack(spacing: 20) {
                        basicInfoSection
                        ingredientsSection
                        stepsSection
                        nutritionSection
                        notesSection
                        saveButton
                    }
                    .padding(20)
                    .padding(.bottom, 40)
                }
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle("New Recipe")
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
        FormCard(title: "Basic Info", icon: "info.circle.fill", color: .blue) {
            VStack(spacing: 14) {
                LabeledField(label: "Recipe Name *") {
                    TextField("e.g. Mum's Pasta", text: $title)
                        .textInputAutocapitalization(.words)
                }

                LabeledField(label: "Description") {
                    TextField("Short description…", text: $description, axis: .vertical)
                        .lineLimit(2...4)
                }

                LabeledField(label: "Category *") {
                    Picker("", selection: $category) {
                        ForEach(categories, id: \.self) { Text($0).tag($0) }
                    }
                    .pickerStyle(.menu)
                    .tint(categoryColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                LabeledField(label: "Cuisine") {
                    TextField("e.g. Italian", text: $cuisine)
                        .textInputAutocapitalization(.words)
                }

                LabeledField(label: "Diet") {
                    Picker("", selection: $diet) {
                        ForEach(diets, id: \.self) { Text($0).tag($0) }
                    }
                    .pickerStyle(.menu)
                    .tint(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                HStack(spacing: 12) {
                    LabeledField(label: "Difficulty") {
                        Picker("", selection: $difficulty) {
                            ForEach(difficulties, id: \.self) { Text($0).tag($0) }
                        }
                        .pickerStyle(.segmented)
                    }
                }

                HStack(spacing: 12) {
                    LabeledField(label: "Prep (min) *") {
                        TextField("15", text: $prepTime)
                            .keyboardType(.numberPad)
                    }
                    LabeledField(label: "Cook (min) *") {
                        TextField("30", text: $cookTime)
                            .keyboardType(.numberPad)
                    }
                    LabeledField(label: "Servings") {
                        TextField("2", text: $servings)
                            .keyboardType(.numberPad)
                    }
                }
            }
        }
    }

    // MARK: - Ingredients

    private var ingredientsSection: some View {
        FormCard(title: "Ingredients", icon: "list.bullet.clipboard.fill", color: .green) {
            VStack(spacing: 10) {
                ForEach($ingredients) { $ingredient in
                    HStack(spacing: 8) {
                        // Ingredient name - flexible width
                        TextField("Name *", text: $ingredient.name)
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)

                        // Quantity input - fixed width
                        TextField("Qty", text: $ingredient.quantity)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 60)
                            .padding(10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)

                        // Unit picker - fixed width with alignment
                        Menu {
                            ForEach(units, id: \.self) { unit in
                                Button(unit) {
                                    ingredient.unit = unit
                                }
                            }
                        } label: {
                            HStack(spacing: 2) {
                                Text(ingredient.unit)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)
                                Spacer(minLength: 2)
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.secondary)
                            }
                            .frame(width: 74)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }

                        // Delete button - fixed width
                        if ingredients.count > 1 {
                            Button(action: { remove(ingredient: ingredient) }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red.opacity(0.7))
                                    .frame(width: 24, height: 24)
                            }
                            .buttonStyle(.plain)
                        } else {
                            // Spacer to maintain alignment when only one ingredient
                            Color.clear
                                .frame(width: 24, height: 24)
                        }
                    }
                    .frame(maxWidth: .infinity)

                    if ingredient.id != ingredients.last?.id {
                        Divider().padding(.horizontal, 4)
                    }
                }

                Button(action: { withAnimation { ingredients.append(DraftIngredient()) } }) {
                    Label("Add Ingredient", systemImage: "plus.circle.fill")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.green)
                }
                .padding(.top, 4)
            }
        }
    }

    // MARK: - Steps

    private var stepsSection: some View {
        FormCard(title: "Instructions", icon: "text.badge.checkmark", color: .orange) {
            VStack(spacing: 10) {
                ForEach(Array(steps.enumerated()), id: \.element.id) { index, _ in
                    let binding = $steps[index]
                    HStack(alignment: .top, spacing: 10) {
                        ZStack {
                            Circle()
                                .fill(Color.orange.opacity(0.15))
                                .frame(width: 28, height: 28)
                            Text("\(index + 1)")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.orange)
                        }
                        .padding(.top, 10)

                        VStack(spacing: 8) {
                            TextField("Step instruction *", text: binding.instruction, axis: .vertical)
                                .lineLimit(2...5)
                                .padding(10)
                                .background(Color(.systemBackground))
                                .cornerRadius(10)

                            HStack {
                                Image(systemName: "timer")
                                    .foregroundColor(.secondary)
                                    .font(.system(size: 14))
                                TextField("Duration (min, optional)", text: binding.durationMinutes)
                                    .keyboardType(.numberPad)
                                    .font(.system(size: 14))
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 10)
                        }

                        if steps.count > 1 {
                            Button(action: { remove(step: steps[index]) }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red.opacity(0.7))
                            }
                            .buttonStyle(.plain)
                            .padding(.top, 10)
                        }
                    }

                    if index < steps.count - 1 {
                        Divider().padding(.horizontal, 4)
                    }
                }

                Button(action: { withAnimation { steps.append(DraftStep()) } }) {
                    Label("Add Step", systemImage: "plus.circle.fill")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.orange)
                }
                .padding(.top, 4)
            }
        }
    }

    // MARK: - Nutrition

    private var nutritionSection: some View {
        FormCard(title: "Nutrition (per serving)", icon: "chart.bar.fill", color: .purple) {
            HStack(spacing: 12) {
                NutritionInput(label: "Calories", placeholder: "300", text: $calories, color: .orange, isNumeric: true)
                NutritionInput(label: "Protein (g)", placeholder: "20", text: $protein, color: .red, isNumeric: false)
                NutritionInput(label: "Carbs (g)", placeholder: "40", text: $carbs, color: .green, isNumeric: false)
                NutritionInput(label: "Fat (g)", placeholder: "10", text: $fat, color: .yellow, isNumeric: false)
            }
        }
    }

    // MARK: - Notes

    private var notesSection: some View {
        FormCard(title: "Notes (Optional)", icon: "note.text", color: .secondary) {
            TextField("Tips, substitutions, storage info…", text: $notes, axis: .vertical)
                .lineLimit(2...6)
                .padding(10)
                .background(Color(.systemBackground))
                .cornerRadius(10)
        }
    }

    // MARK: - Save Button

    private var saveButton: some View {
        Button(action: saveRecipe) {
            HStack(spacing: 8) {
                Image(systemName: "checkmark.circle.fill")
                Text("Save Recipe")
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

    // MARK: - Category colour helper

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

    // MARK: - Helpers

    private func remove(ingredient: DraftIngredient) {
        withAnimation { ingredients.removeAll { $0.id == ingredient.id } }
    }

    private func remove(step: DraftStep) {
        withAnimation { steps.removeAll { $0.id == step.id } }
    }

    // MARK: - Validation & Save

    private func saveRecipe() {
        // Validate required fields
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

        // Build Recipe value
        let recipeId = UUID().uuidString

        let finalIngredients: [Ingredient] = validIngredients.enumerated().map { idx, d in
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

        let proteinStr  = protein.isEmpty  ? "0g" : (protein.hasSuffix("g")  ? protein  : "\(protein)g")
        let carbsStr    = carbs.isEmpty    ? "0g" : (carbs.hasSuffix("g")    ? carbs    : "\(carbs)g")
        let fatStr      = fat.isEmpty      ? "0g" : (fat.hasSuffix("g")      ? fat      : "\(fat)g")

        let nutrition = Nutrition(
            calories: Int(calories) ?? 0,
            protein: proteinStr,
            carbs: carbsStr,
            fat: fatStr,
            fiber: "0g"
        )

        let recipe = Recipe(
            id: recipeId,
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
            rating: 5.0,
            reviews: 0,
            mode: modeManager.currentMode // Save in current mode
        )

        db.addCustomRecipe(recipe)
        dismiss()
    }
}

// MARK: - Reusable sub-views

private struct FormCard<Content: View>: View {
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

private struct LabeledField<Content: View>: View {
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

private struct NutritionInput: View {
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

#Preview {
    CreateRecipeView()
        .environmentObject(LocalDatabaseManager())
        .environmentObject(HealthModeManager())
}
