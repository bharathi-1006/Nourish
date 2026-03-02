import SwiftUI

// MARK: - 1-Minute Recipe Page

struct OneMinRecipeView: View {
    @EnvironmentObject var modeManager: HealthModeManager
    @Environment(\.dismiss) var dismiss
    
    private var recipes: [QuickRecipe] {
        QuickRecipesProvider.recipes(for: modeManager.currentMode)
    }
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            modeManager.theme.backgroundGradient.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header - Apple style
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 12) {
                            Image(systemName: "flame.fill")
                                .font(.system(size: 34, weight: .medium))
                                .foregroundColor(modeManager.theme.primaryColor)
                            Text("Five Minute Recipes")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(.primary)
                        }
                        
                        Text("Quick & delicious recipes for \(modeManager.currentMode.displayName) mode")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.secondary)
                            .padding(.top, 2)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    
                    // Recipe List
                    VStack(spacing: 12) {
                        ForEach(recipes) { recipe in
                            NavigationLink(destination: QuickRecipeDetailView(recipe: recipe)) {
                                QuickRecipeListCard(recipe: recipe)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationTitle("Five Minute Recipes")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Quick Recipe List Card

struct QuickRecipeListCard: View {
    @EnvironmentObject var modeManager: HealthModeManager
    let recipe: QuickRecipe
    
    var body: some View {
        HStack(spacing: 16) {
            // Premium gradient SF Symbol icon
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(
                        LinearGradient(
                            colors: [
                                modeManager.theme.primaryColor.opacity(0.85),
                                modeManager.theme.accentColor.opacity(0.65)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 72, height: 72)
                
                // Specular top highlight
                RoundedRectangle(cornerRadius: 14)
                    .fill(
                        LinearGradient(
                            colors: [.white.opacity(0.2), .clear],
                            startPoint: .top,
                            endPoint: .center
                        )
                    )
                    .frame(width: 72, height: 72)
                
                Image(systemName: recipe.systemIcon)
                    .font(.system(size: 28, weight: .medium))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white.opacity(0.95), .white.opacity(0.5))
            }
            .shadow(color: modeManager.theme.primaryColor.opacity(0.3), radius: 8, x: 0, y: 4)
            
            // Content
            VStack(alignment: .leading, spacing: 6) {
                Text(recipe.title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text(recipe.description)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                HStack(spacing: 6) {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 14, weight: .medium))
                    Text(recipe.prepTime)
                        .font(.system(size: 14, weight: .medium))
                }
                .foregroundColor(modeManager.theme.primaryColor)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color(.systemGray3))
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color(.systemGray5), lineWidth: 0.5)
        )
    }
}

// MARK: - Quick Recipe Detail View

struct QuickRecipeDetailView: View {
    @EnvironmentObject var modeManager: HealthModeManager
    @EnvironmentObject var db: LocalDatabaseManager
    @Environment(\.dismiss) var dismiss
    let recipe: QuickRecipe
    
    @State private var showAddedAlert = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            modeManager.theme.backgroundGradient.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    // Hero Section with Premium SF Symbol - Center Aligned
                    VStack(spacing: 20) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 28)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            modeManager.theme.primaryColor.opacity(0.85),
                                            modeManager.theme.accentColor.opacity(0.65)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 150, height: 150)
                            
                            // Specular highlight
                            RoundedRectangle(cornerRadius: 28)
                                .fill(
                                    LinearGradient(
                                        colors: [.white.opacity(0.2), .clear],
                                        startPoint: .top,
                                        endPoint: .center
                                    )
                                )
                                .frame(width: 150, height: 150)
                            
                            Circle()
                                .fill(.white.opacity(0.08))
                                .frame(width: 120, height: 120)
                                .blur(radius: 20)
                            
                            Image(systemName: recipe.systemIcon)
                                .font(.system(size: 64, weight: .light))
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white.opacity(0.95), .white.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .shadow(color: modeManager.theme.primaryColor.opacity(0.3), radius: 20, x: 0, y: 8)
                        
                        VStack(spacing: 10) {
                            Text(recipe.title)
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)
                            
                            Text(recipe.description)
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                            
                            // Time Badge
                            HStack(spacing: 8) {
                                Image(systemName: "clock.fill")
                                    .font(.system(size: 14, weight: .medium))
                                Text(recipe.prepTime)
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(modeManager.theme.primaryColor)
                            .cornerRadius(24)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Ingredients Section
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Ingredients")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(Array(recipe.ingredients.enumerated()), id: \.offset) { index, ingredient in
                                HStack(alignment: .top, spacing: 14) {
                                    ZStack {
                                        Circle()
                                            .fill(modeManager.theme.primaryColor.opacity(0.12))
                                            .frame(width: 32, height: 32)
                                        
                                        Text("\(index + 1)")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(modeManager.theme.primaryColor)
                                    }
                                    
                                    Text(ingredient)
                                        .font(.system(size: 17, weight: .regular))
                                        .foregroundColor(.primary)
                                        .fixedSize(horizontal: false, vertical: true)
                                    
                                    Spacer()
                                }
                            }
                        }
                        .padding(18)
                        .background(Color(.systemGray6).opacity(0.6))
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 20)
                    
                    // Instructions Section (Point-wise)
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Instructions")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                        
                        VStack(alignment: .leading, spacing: 14) {
                            ForEach(Array(recipe.steps.enumerated()), id: \.offset) { index, step in
                                HStack(alignment: .top, spacing: 14) {
                                    ZStack {
                                        Circle()
                                            .fill(modeManager.theme.primaryColor)
                                            .frame(width: 32, height: 32)
                                        
                                        Text("\(index + 1)")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    
                                    Text(step)
                                        .font(.system(size: 17, weight: .regular))
                                        .foregroundColor(.primary)
                                        .lineSpacing(4)
                                        .fixedSize(horizontal: false, vertical: true)
                                    
                                    Spacer()
                                }
                            }
                        }
                        .padding(18)
                        .background(Color(.systemGray6).opacity(0.6))
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 20)
                    
                    // Nutrition Section
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Nutrition")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                        
                        VStack(spacing: 0) {
                            NutritionRow(label: "Calories", value: "\(recipe.nutrition.calories)", unit: "kcal")
                            Divider().padding(.horizontal, 16)
                            NutritionRow(label: "Protein", value: recipe.nutrition.protein, unit: "")
                            Divider().padding(.horizontal, 16)
                            NutritionRow(label: "Carbs", value: recipe.nutrition.carbs, unit: "")
                            Divider().padding(.horizontal, 16)
                            NutritionRow(label: "Fat", value: recipe.nutrition.fat, unit: "")
                        }
                        .background(Color(.systemGray6).opacity(0.6))
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 20)
                    
                    // Add to List Button
                    Button(action: {
                        addIngredientsToShoppingList()
                        showAddedAlert = true
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: "cart.fill.badge.plus")
                                .font(.system(size: 18, weight: .semibold))
                            Text("Add to Shopping List")
                                .font(.system(size: 17, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(modeManager.theme.primaryColor)
                        .cornerRadius(14)
                        .shadow(color: modeManager.theme.primaryColor.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .padding(.horizontal, 20)
                    
                    // Mode Badge
                    HStack {
                        Spacer()
                        
                        HStack(spacing: 8) {
                            Image(systemName: modeManager.currentMode.icon)
                            Text(modeManager.currentMode.displayName)
                        }
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(modeManager.theme.primaryColor)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 10)
                        .background(modeManager.theme.primaryColor.opacity(0.12))
                        .cornerRadius(24)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationTitle(recipe.title)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Added to Shopping List", isPresented: $showAddedAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("All ingredients have been added to your shopping list.")
        }
    }
    
    private func addIngredientsToShoppingList() {
        // Convert string ingredients to Ingredient objects for the shopping list
        let ingredients = recipe.ingredients.map { ingredientString in
            Ingredient(
                id: UUID().uuidString,
                name: ingredientString,
                quantity: "1",
                unit: "unit"
            )
        }
        db.addIngredientsToShoppingList(ingredients)
    }
}

// MARK: - Nutrition Row Component

struct NutritionRow: View {
    let label: String
    let value: String
    let unit: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value + (unit.isEmpty ? "" : " \(unit)"))
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

#Preview {
    NavigationStack {
        OneMinRecipeView()
            .environmentObject(HealthModeManager())
    }
}
