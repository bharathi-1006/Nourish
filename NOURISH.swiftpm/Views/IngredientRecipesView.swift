import SwiftUI

struct IngredientRecipesView: View {
    @EnvironmentObject var db: LocalDatabaseManager
    @EnvironmentObject var modeManager: HealthModeManager
    let ingredient: String
    
    // Computed property to get filtered recipes (performance optimization)
    private var filteredRecipes: [Recipe] {
        let ingredientRecipes = db.recipesContaining(ingredient: ingredient)
        return modeManager.filteredRecipes(from: ingredientRecipes)
    }
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            if filteredRecipes.isEmpty {
                // Empty state
                VStack(spacing: 16) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    
                    Text("No recipes found")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text("No recipes found with \(ingredient.lowercased()).")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
            } else {
                // Recipe list
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(filteredRecipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeCard(recipe: recipe)
                            }
                        }
                    }
                    .padding(16)
                }
            }
        }
        .navigationTitle("Recipes with \(ingredient)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Recipe Card Component
struct RecipeCard: View {
    let recipe: Recipe
    
    var body: some View {
        HStack(spacing: 12) {
            // Recipe Image
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemGray6))
                
                Image(systemName: recipe.heroImage)
                    .font(.system(size: 24))
                    .foregroundColor(.gray)
            }
            .frame(width: 80, height: 80)
            
            // Recipe Info
            VStack(alignment: .leading, spacing: 6) {
                Text(recipe.title)
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                HStack(spacing: 12) {
                    Label(recipe.difficulty, systemImage: "chart.bar")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.secondary)
                    
                    Label("\(recipe.preparationTime + recipe.cookingTime)m", systemImage: "clock")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Image(systemName: "star.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.orange)
                    
                    Text(String(format: "%.1f", recipe.rating))
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text("(\(recipe.reviews))")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
        }
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    NavigationStack {
        IngredientRecipesView(ingredient: "Chicken")
            .environmentObject(LocalDatabaseManager())
            .environmentObject(HealthModeManager())
    }
}
