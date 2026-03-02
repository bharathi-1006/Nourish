import SwiftUI

struct CategoryRecipesView: View {
    @EnvironmentObject var db: LocalDatabaseManager
    @EnvironmentObject var modeManager: HealthModeManager
    let category: Category

    @State private var sortOption: SortOption = .rating

    enum SortOption: String, CaseIterable {
        case rating    = "Top Rated"
        case time      = "Quickest"
        case name      = "A–Z"
    }

    private var recipes: [Recipe] {
        let categoryRecipes = db.recipes(for: category.name)
        let filtered = modeManager.filteredRecipes(from: categoryRecipes)
        switch sortOption {
        case .rating: return filtered.sorted { $0.rating > $1.rating }
        case .time:   return filtered.sorted { ($0.preparationTime + $0.cookingTime) < ($1.preparationTime + $1.cookingTime) }
        case .name:   return filtered.sorted { $0.title < $1.title }
        }
    }

    // Colour tint per category
    private var tintColor: Color {
        switch category.name {
        case "Breakfast":  return Color(red: 1.0,  green: 0.72, blue: 0.25)
        case "Lunch":      return Color(red: 0.40, green: 0.78, blue: 0.47)
        case "Dinner":     return Color(red: 0.36, green: 0.54, blue: 0.96)
        case "Dessert":    return Color(red: 0.96, green: 0.42, blue: 0.62)
        case "Snacks":     return Color(red: 0.93, green: 0.62, blue: 0.22)
        case "Beverages":  return Color(red: 0.38, green: 0.74, blue: 0.88)
        default:           return Color.orange
        }
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                // ── Hero banner ──────────────────────────────────────
                ZStack {
                    tintColor.opacity(0.15)
                    VStack(spacing: 12) {
                        Text(category.icon)
                            .font(.system(size: 64))
                        Text(category.name)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.primary)
                        Text("\(recipes.count) recipe\(recipes.count == 1 ? "" : "s")")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 36)
                }
                .frame(maxWidth: .infinity)

                // ── Sort picker ──────────────────────────────────────
                HStack {
                    Text("Sort by")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                    Spacer()
                    Picker("", selection: $sortOption) {
                        ForEach(SortOption.allCases, id: \.self) { opt in
                            Text(opt.rawValue).tag(opt)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(tintColor)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)

                Divider().padding(.horizontal, 20)

                // ── Recipe list ─────────────────────────────────────
                if recipes.isEmpty {
                    EmptyCategoryView(category: category, tintColor: tintColor)
                        .padding(.top, 60)
                } else {
                    LazyVStack(spacing: 14) {
                        ForEach(recipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                CategoryRecipeRow(recipe: recipe, tintColor: tintColor)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 32)
                }
            }
        }
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Category Recipe Row Card
struct CategoryRecipeRow: View {
    let recipe: Recipe
    let tintColor: Color

    var body: some View {
        HStack(spacing: 14) {
            // Thumbnail
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(tintColor.opacity(0.15))
                Image(systemName: recipe.heroImage)
                    .font(.system(size: 28))
                    .foregroundColor(tintColor)
            }
            .frame(width: 80, height: 80)

            // Details
            VStack(alignment: .leading, spacing: 5) {
                Text(recipe.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(2)

                Text(recipe.description)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .lineLimit(1)

                HStack(spacing: 10) {
                    // Time
                    Label("\(recipe.preparationTime + recipe.cookingTime) min",
                          systemImage: "clock")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.secondary)

                    // Difficulty badge
                    Text(recipe.difficulty)
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.horizontal, 7)
                        .padding(.vertical, 3)
                        .background(difficultyColor(recipe.difficulty).opacity(0.15))
                        .foregroundColor(difficultyColor(recipe.difficulty))
                        .cornerRadius(6)

                    Spacer()

                    // Rating
                    HStack(spacing: 3) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.orange)
                        Text(String(format: "%.1f", recipe.rating))
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                }
            }

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
        }
        .padding(14)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.07), radius: 8, x: 0, y: 2)
    }

    private func difficultyColor(_ difficulty: String) -> Color {
        switch difficulty {
        case "Easy":   return .green
        case "Medium": return .orange
        case "Hard":   return .red
        default:       return .gray
        }
    }
}

// MARK: - Empty State
struct EmptyCategoryView: View {
    let category: Category
    let tintColor: Color

    var body: some View {
        VStack(spacing: 16) {
            Text(category.icon)
                .font(.system(size: 56))
                .opacity(0.4)
            Text("No \(category.name) recipes yet")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)
            Text("Check back soon for delicious\n\(category.name.lowercased()) ideas!")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(32)
    }
}

#Preview {
    NavigationStack {
        CategoryRecipesView(category: Category(id: "1", name: "Breakfast", icon: "☀️"))
            .environmentObject(LocalDatabaseManager())
            .environmentObject(HealthModeManager())
    }
}
