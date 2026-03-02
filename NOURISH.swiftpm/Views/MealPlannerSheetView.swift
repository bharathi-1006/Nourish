import SwiftUI

struct MealPlannerSheetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var db: LocalDatabaseManager
    let recipe: Recipe
    
    @State private var selectedDate = Date()
    @State private var selectedMeal = "dinner"
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(recipe.title)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.primary)
                        
                        HStack {
                            Label("\(recipe.preparationTime + recipe.cookingTime)m", systemImage: "clock")
                            Spacer()
                            Label("\(recipe.servings) servings", systemImage: "person.2")
                        }
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    }
                    .listRowBackground(Color.clear)
                }
                
                Section(header: Text("Select Date")) {
                    DatePicker(
                        "Date",
                        selection: $selectedDate,
                        in: Date()...,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)
                }
                
                Section(header: Text("Meal Type")) {
                    Picker("Meal Type", selection: $selectedMeal) {
                        Label("Breakfast", systemImage: "sunrise.fill").tag("breakfast")
                        Label("Lunch", systemImage: "sun.max.fill").tag("lunch")
                        Label("Dinner", systemImage: "moon.stars.fill").tag("dinner")
                        Label("Snack", systemImage: "leaf.fill").tag("snack")
                    }
                    .pickerStyle(.menu)
                }
                
                Section {
                    Button(action: {
                        db.addMealPlan(recipe.id, date: selectedDate, meal: selectedMeal)
                        dismiss()
                    }) {
                        Text("Add to Meal Plan")
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .listRowBackground(Color.clear)
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle("Add to Meal Plan")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    MealPlannerSheetView(recipe: Recipe(
        id: "1",
        title: "Test Recipe",
        description: "Test",
        heroImage: "pizza",
        cuisine: "Italian",
        diet: "Vegetarian",
        category: "Dinner",
        preparationTime: 30,
        cookingTime: 20,
        difficulty: "Easy",
        servings: 4,
        ingredients: [],
        steps: [],
        nutrition: Nutrition(calories: 300, protein: "10g", carbs: "40g", fat: "10g", fiber: "5g"),
        rating: 4.5,
        reviews: 100,
        mode: .normal
    ))
    .environmentObject(LocalDatabaseManager())
}
