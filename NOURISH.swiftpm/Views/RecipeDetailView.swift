import SwiftUI

// MARK: - Recipe Detail View

struct RecipeDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var db: LocalDatabaseManager
    @EnvironmentObject var modeManager: HealthModeManager
    let recipe: Recipe

    @State private var isFavorited = false
    @State private var showCookingMode = false
    @State private var showAddedAlert = false
    @State private var showMealPlanner = false
    @State private var showDeleteConfirm = false
    @State private var showEditRecipe = false
    @State private var showDuplicateAlert = false
    @State private var duplicateNames: [String] = []

    private var theme: HealthModeTheme { modeManager.theme }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                    // ── Cinematic Hero ─────────────────────────────────────
                    ZStack(alignment: .topTrailing) {
                        // Gradient card
                        ZStack {
                            LinearGradient(
                                colors: [theme.primaryColor.opacity(0.88), theme.accentColor.opacity(0.75)],
                                startPoint: .topLeading, endPoint: .bottomTrailing
                            )
                            LinearGradient(colors:[.white.opacity(0.14),.clear], startPoint:.top, endPoint:.center)

                            Image(systemName: recipe.heroImage)
                                .font(.system(size: 96, weight: .ultraLight))
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white.opacity(0.95), .white.opacity(0.45))
                                .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 6)
                        }
                        .frame(height: 280)
                        .clipShape(RoundedRectangle(cornerRadius: 0))

                        // Favorite button floating
                        Button(action: {
                            if isFavorited { db.removeFromFavorites(recipe.id) }
                            else { db.addToFavorites(recipe) }
                            isFavorited.toggle()
                        }) {
                            ZStack {
                                Circle().fill(.ultraThinMaterial).frame(width: 44, height: 44)
                                Image(systemName: isFavorited ? "heart.fill" : "heart")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(isFavorited ? .red : .white)
                            }
                        }
                        .buttonStyle(ScaleButtonStyle())
                        .padding(.top, 56).padding(.trailing, 20)
                    }

                    // ── Content ────────────────────────────────────────────
                    VStack(alignment: .leading, spacing: 24) {

                        // Title & rating
                        VStack(alignment: .leading, spacing: 10) {
                            Text(recipe.title)
                                .font(.system(size: 26, weight: .bold, design: .rounded))
                                .foregroundColor(.primary)

                            HStack(spacing: 10) {
                                HStack(spacing: 4) {
                                    ForEach(0..<5, id: \.self) { i in
                                        Image(systemName: i < Int(recipe.rating.rounded()) ? "star.fill" : "star")
                                            .font(.system(size: 14)).foregroundColor(.orange)
                                    }
                                    Text(String(format: "%.1f", recipe.rating))
                                        .font(.system(size: 14, weight: .semibold)).foregroundColor(.primary)
                                    Text("(\(recipe.reviews))").font(.system(size: 14)).foregroundColor(.secondary)
                                }
                                Spacer()
                                // Diet badge
                                Text(recipe.diet)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(theme.primaryColor)
                                    .padding(.horizontal, 10).padding(.vertical, 5)
                                    .background(theme.primaryColor.opacity(0.10), in: Capsule())
                            }
                        }

                        // Info pills row
                        HStack(spacing: 10) {
                            InfoPill(icon: "clock.fill", title: "Prep", value: "\(recipe.preparationTime)m")
                            InfoPill(icon: "flame.fill", title: "Cook", value: "\(recipe.cookingTime)m")
                            InfoPill(icon: "person.fill", title: "Serves", value: "\(recipe.servings)")
                            InfoPill(icon: "bolt.fill", title: "Level", value: recipe.difficulty)
                        }

                        dividerSection

                        // About
                        sectionTitle("About")
                        Text(recipe.description)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.secondary).lineSpacing(4)

                        dividerSection

                        // Ingredients
                        sectionTitle("Ingredients")
                        VStack(spacing: 8) {
                            ForEach(recipe.ingredients) { ing in
                                HStack(spacing: 12) {
                                    ZStack {
                                        Circle().fill(theme.primaryColor.opacity(0.10)).frame(width: 28, height: 28)
                                        Image(systemName: "circle.fill").font(.system(size: 7)).foregroundColor(theme.primaryColor)
                                    }
                                    Text(ing.name).font(.system(size: 15)).foregroundColor(.primary)
                                    Spacer()
                                    Text("\(ing.quantity) \(ing.unit)")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(theme.primaryColor)
                                        .padding(.horizontal, 10).padding(.vertical, 5)
                                        .background(theme.primaryColor.opacity(0.09), in: Capsule())
                                }
                                .padding(.horizontal, 14).padding(.vertical, 11)
                                .background(Color(.systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 13))
                                .shadow(color: Color.black.opacity(0.04), radius: 5, x: 0, y: 2)
                            }
                        }

                        dividerSection

                        // Nutrition
                        sectionTitle("Nutrition per serving")
                        HStack(spacing: 10) {
                            NutritionBadge(label: "Calories", value: "\(recipe.nutrition.calories)", color: .orange)
                            NutritionBadge(label: "Protein",  value: recipe.nutrition.protein,  color: Color(red:0.95,green:0.38,blue:0.38))
                            NutritionBadge(label: "Carbs",    value: recipe.nutrition.carbs,    color: Color(red:0.20,green:0.78,blue:0.35))
                            NutritionBadge(label: "Fat",      value: recipe.nutrition.fat,      color: Color(red:0.95,green:0.58,blue:0.15))
                        }

                        dividerSection

                        // Instructions
                        sectionTitle("Instructions")
                        VStack(spacing: 12) {
                            ForEach(recipe.steps.indices, id: \.self) { i in
                                let step = recipe.steps[i]
                                HStack(alignment: .top, spacing: 14) {
                                    ZStack {
                                        Circle()
                                            .fill(LinearGradient(colors:[theme.primaryColor, theme.accentColor], startPoint:.topLeading, endPoint:.bottomTrailing))
                                            .frame(width: 30, height: 30)
                                        Text("\(step.stepNumber)")
                                            .font(.system(size: 14, weight: .bold)).foregroundColor(.white)
                                    }
                                    .shadow(color: theme.primaryColor.opacity(0.3), radius: 5, x: 0, y: 2)
                                    .padding(.top, 1)

                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(step.instruction)
                                            .font(.system(size: 15, weight: .regular))
                                            .foregroundColor(.primary).lineSpacing(3)
                                            .fixedSize(horizontal: false, vertical: true)
                                        if let dur = step.duration {
                                            Label(formatDuration(dur), systemImage: "timer")
                                                .font(.system(size: 14, weight: .medium))
                                                .foregroundColor(theme.primaryColor)
                                                .padding(.horizontal, 10).padding(.vertical, 5)
                                                .background(theme.primaryColor.opacity(0.09), in: RoundedRectangle(cornerRadius: 8))
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding(16)
                                .background(Color(.systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 3)
                                .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Color(.systemGray5).opacity(0.4), lineWidth: 0.5))
                            }
                        }
                    }
                    .padding(20)
                    .padding(.bottom, 20)
            }
        }
        .background(Color(.systemBackground))
        .safeAreaInset(edge: .bottom, spacing: 0) {
            // ── Floating Action Bar ─────────────────────────────────────────
            VStack(spacing: 10) {
                Button(action: { showCookingMode = true }) {
                    HStack(spacing: 8) {
                        Image(systemName: "flame.fill").font(.system(size: 16, weight: .semibold))
                        Text("Start Cooking").font(.system(size: 17, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity).frame(height: 52)
                    .background(
                        LinearGradient(colors:[theme.primaryColor, theme.accentColor], startPoint:.leading, endPoint:.trailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: theme.primaryColor.opacity(0.35), radius: 12, x: 0, y: 5)
                }
                .buttonStyle(ScaleButtonStyle())

                HStack(spacing: 10) {
                    Button(action: {
                        let dupes = db.duplicateIngredientNames(in: recipe.ingredients)
                        if dupes.isEmpty { db.addIngredientsToShoppingList(recipe.ingredients); showAddedAlert = true }
                        else { duplicateNames = dupes; showDuplicateAlert = true }
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "cart.fill").font(.system(size: 14, weight: .semibold))
                            Text("Add to List").font(.system(size: 15, weight: .semibold))
                        }
                        .foregroundColor(.white).frame(maxWidth: .infinity).frame(height: 48)
                        .background(Color(red:0.20,green:0.78,blue:0.35)).clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .buttonStyle(ScaleButtonStyle())

                    Button(action: { showMealPlanner = true }) {
                        HStack(spacing: 6) {
                            Image(systemName: "calendar").font(.system(size: 14, weight: .semibold))
                            Text("Meal Plan").font(.system(size: 15, weight: .semibold))
                        }
                        .foregroundColor(.white).frame(maxWidth: .infinity).frame(height: 48)
                        .background(Color(red:0.42,green:0.34,blue:0.85)).clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
            .padding(.horizontal, 20).padding(.vertical, 16)
            .background(.ultraThinMaterial)
            .shadow(color: Color.black.opacity(0.10), radius: 20, x: 0, y: -6)
        }
        .navigationBarBackButtonHidden(false)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }.foregroundColor(theme.primaryColor)
                }
            }
            if db.isCustomRecipe(recipe.id) {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 4) {
                        Button { showEditRecipe = true } label: {
                            Image(systemName: "pencil").foregroundColor(theme.primaryColor)
                        }
                        Button { showDeleteConfirm = true } label: {
                            Image(systemName: "trash").foregroundColor(.red)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showCookingMode) { CookingModeView(recipe: recipe) }
        .sheet(isPresented: $showMealPlanner) { MealPlannerSheetView(recipe: recipe) }
        .sheet(isPresented: $showEditRecipe) {
            EditRecipeView(recipe: recipe).environmentObject(db).environmentObject(modeManager)
        }
        .alert("Added to Shopping List", isPresented: $showAddedAlert) { Button("OK") {} }
        .alert("Already in Your List", isPresented: $showDuplicateAlert) {
            Button("Add Anyway") { db.addIngredientsToShoppingList(recipe.ingredients); showAddedAlert = true }
            Button("Cancel", role: .cancel) {}
        } message: {
            let names = duplicateNames.prefix(3).joined(separator: ", ")
            let more = duplicateNames.count > 3 ? " +\(duplicateNames.count - 3) more" : ""
            Text("\(names)\(more) \(duplicateNames.count == 1 ? "is" : "are") already in your list.\n\nAdd again?")
        }
        .alert("Delete Recipe", isPresented: $showDeleteConfirm) {
            Button("Delete", role: .destructive) { db.deleteCustomRecipe(recipe.id); dismiss() }
            Button("Cancel", role: .cancel) {}
        } message: { Text("\(recipe.title) will be permanently deleted.") }
        .onAppear { isFavorited = db.isFavorite(recipe.id) }
    }

    private var dividerSection: some View {
        Divider().padding(.vertical, 2)
    }

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .foregroundColor(.primary)
    }

    private func formatDuration(_ seconds: Int) -> String {
        let m = seconds / 60; let s = seconds % 60
        return m > 0 ? "\(m)m \(s)s" : "\(s)s"
    }
}

// MARK: - Info Pill
struct InfoPill: View {
    @EnvironmentObject var modeManager: HealthModeManager
    let icon: String
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: icon).font(.system(size: 16))
                .symbolRenderingMode(.palette)
                .foregroundStyle(modeManager.theme.primaryColor, modeManager.theme.primaryColor.opacity(0.5))
            Text(title).font(.system(size: 14, weight: .medium)).foregroundColor(.secondary)
            Text(value).font(.system(size: 14, weight: .bold)).foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity).padding(.vertical, 13)
        .background(modeManager.theme.primaryColor.opacity(0.07), in: RoundedRectangle(cornerRadius: 13))
        .overlay(RoundedRectangle(cornerRadius: 13).strokeBorder(modeManager.theme.primaryColor.opacity(0.16), lineWidth: 1))
    }
}

// MARK: - Nutrition Badge
struct NutritionBadge: View {
    let label: String
    let value: String
    let color: Color

    private var icon: String {
        switch label.lowercased() {
        case "calories": return "flame.fill"
        case "protein":  return "bolt.fill"
        case "carbs":    return "leaf.fill"
        case "fat":      return "drop.fill"
        default:         return "circle.fill"
        }
    }

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon).font(.system(size: 14, weight: .semibold)).foregroundColor(color)
            Text(label).font(.system(size: 14, weight: .medium)).foregroundColor(.secondary)
            Text(value).font(.system(size: 14, weight: .bold)).foregroundColor(color)
        }
        .frame(maxWidth: .infinity).padding(.vertical, 14)
        .background(color.opacity(0.09), in: RoundedRectangle(cornerRadius: 13))
        .overlay(RoundedRectangle(cornerRadius: 13).strokeBorder(color.opacity(0.20), lineWidth: 1))
    }
}
