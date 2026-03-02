import SwiftUI

// MARK: - Home View

struct HomeView: View {
    @EnvironmentObject var db: LocalDatabaseManager
    @EnvironmentObject var modeManager: HealthModeManager
    @State private var showCreateRecipe = false

    private var availableIngredients: [String] { modeManager.ingredientSuggestions }
    private var filteredRecipes: [Recipe] { modeManager.filteredRecipes(from: db.recipes) }

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    heroHeader.padding(.bottom, 24)
                    sectionHeader("Featured")
                    featuredCards.padding(.bottom, 36)
                    sectionHeader("Categories")
                    categoriesGrid.padding(.bottom, 36)
                    if !db.customRecipeIds.isEmpty {
                        myRecipesSection.padding(.bottom, 36)
                    }
                    sectionHeader("Cook With What You Have")
                    ingredientChips.padding(.bottom, 36)
                    sectionHeader("Quick Suggestions")
                    quickSuggestions.padding(.bottom, 48)
                }
            }
            .ignoresSafeArea(edges: .top)
            .navigationBarHidden(true)
            .sheet(isPresented: $showCreateRecipe) {
                CreateRecipeView().environmentObject(db).environmentObject(modeManager)
            }
        }
    }

    // MARK: - Hero Header
    private let nourishOrange = Color(red: 0.97, green: 0.45, blue: 0.15)

    private var heroHeader: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [
                    modeManager.theme.primaryColor.opacity(0.30),
                    modeManager.theme.primaryColor.opacity(0.12),
                    Color(.systemBackground).opacity(0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea(edges: .top)
            .frame(height: 260)

            HStack(alignment: .bottom, spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Nourish")
                        .font(.system(size: 42, weight: .heavy, design: .rounded))
                        .foregroundColor(nourishOrange)
                    Spacer().frame(height: 6)
                    Text(greetingText)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    Text("What would you like to cook today?")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                        .minimumScaleFactor(0.85)
                }
                Spacer(minLength: 8)
                VStack(alignment: .trailing, spacing: 8) {
                    HealthModeSelectorOnLight()
                    Button(action: { showCreateRecipe = true }) {
                        HStack(spacing: 5) {
                            Image(systemName: "plus").font(.system(size: 14, weight: .bold))
                            Text("New").font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(modeManager.theme.primaryColor)
                        .padding(.horizontal, 14).padding(.vertical, 8)
                        .background(modeManager.theme.primaryColor.opacity(0.12), in: Capsule())
                        .overlay(Capsule().strokeBorder(modeManager.theme.primaryColor.opacity(0.35), lineWidth: 1.5))
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 22)
        }
    }

    private var greetingText: String {
        let h = Calendar.current.component(.hour, from: Date())
        if h < 12 { return "Good Morning" }
        if h < 17 { return "Good Afternoon" }
        if h < 21 { return "Good Evening" }
        return "Good Night"
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 22, weight: .bold, design: .rounded))
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20).padding(.bottom, 14)
    }

    private var featuredCards: some View {
        HStack(spacing: 14) {
            NavigationLink(destination: OneMinRecipeView()) {
                FeaturedActionCard(
                    title: "Five Minute\nRecipe",
                    subtitle: "Quick & Delicious",
                    icon: "flame.fill",
                    gradientColors: [modeManager.theme.primaryColor, modeManager.theme.accentColor]
                )
            }.buttonStyle(InteractiveCardButtonStyle())
            if modeManager.currentMode != .normal {
                NavigationLink(destination: NotRecommendedView()) {
                    FeaturedActionCard(
                        title: "Not\nRecommended",
                        subtitle: "Foods to Avoid",
                        icon: "exclamationmark.shield.fill",
                        gradientColors: [Color(red: 1.0, green: 0.42, blue: 0.22), Color(red: 0.88, green: 0.25, blue: 0.25)]
                    )
                }.buttonStyle(InteractiveCardButtonStyle())
            }
        }.padding(.horizontal, 20)
    }

    private var categoriesGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(db.categories) { category in
                NavigationLink(destination: CategoryRecipesView(category: category)) {
                    CategoryCard(category: category)
                }.buttonStyle(CategoryButtonStyle())
            }
        }.padding(.horizontal, 20)
    }

    private var myRecipesSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("My Recipes")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                Spacer()
                Text("\(db.customRecipeIds.count)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(modeManager.theme.primaryColor)
                    .padding(.horizontal, 12).padding(.vertical, 5)
                    .background(modeManager.theme.primaryColor.opacity(0.1), in: Capsule())
            }.padding(.horizontal, 20)
            VStack(spacing: 10) {
                ForEach(filteredRecipes.filter { db.isCustomRecipe($0.id) }) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        QuickSuggestionRow(recipe: recipe)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }.padding(.horizontal, 20)
        }
    }

    private var ingredientChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(availableIngredients, id: \.self) { ingredient in
                    NavigationLink(destination: IngredientRecipesView(ingredient: ingredient)) {
                        IngredientChip(ingredient: ingredient)
                    }
                }
            }.padding(.horizontal, 20)
        }
    }

    private var quickSuggestions: some View {
        VStack(spacing: 10) {
            ForEach(filteredRecipes.prefix(4)) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    QuickSuggestionRow(recipe: recipe)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }.padding(.horizontal, 20)
    }
}

// MARK: - Category Card
struct CategoryCard: View {
    let category: Category
    private var tintColor: Color {
        switch category.name {
        case "Breakfast": return Color(red: 1.0, green: 0.72, blue: 0.25)
        case "Lunch":     return Color(red: 0.30, green: 0.78, blue: 0.47)
        case "Dinner":    return Color(red: 0.36, green: 0.54, blue: 0.96)
        case "Dessert":   return Color(red: 0.96, green: 0.38, blue: 0.62)
        case "Snacks":    return Color(red: 0.93, green: 0.62, blue: 0.22)
        case "Beverages": return Color(red: 0.28, green: 0.74, blue: 0.92)
        default:          return Color.orange
        }
    }
    private var sfIcon: String {
        switch category.name {
        case "Breakfast": return "sun.horizon.fill"
        case "Lunch":     return "fork.knife"
        case "Dinner":    return "moon.stars.fill"
        case "Dessert":   return "birthday.cake.fill"
        case "Snacks":    return "leaf.fill"
        case "Beverages": return "cup.and.saucer.fill"
        default:          return "star.fill"
        }
    }
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle().fill(tintColor.opacity(0.14)).frame(width: 58, height: 58)
                Circle()
                    .fill(LinearGradient(colors: [tintColor.opacity(0.95), tintColor.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 48, height: 48)
                    .shadow(color: tintColor.opacity(0.4), radius: 8, x: 0, y: 4)
                Image(systemName: sfIcon)
                    .font(.system(size: 21, weight: .medium))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .white.opacity(0.65))
            }
            Text(category.name)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity).frame(height: 106)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemBackground)).shadow(color: tintColor.opacity(0.12), radius: 12, x: 0, y: 4))
        .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(tintColor.opacity(0.14), lineWidth: 1))
    }
}

// MARK: - Quick Suggestion Row
struct QuickSuggestionRow: View {
    let recipe: Recipe
    private var iconColor: Color {
        switch recipe.category.lowercased() {
        case "breakfast": return Color(red: 1.0, green: 0.72, blue: 0.25)
        case "lunch":     return Color(red: 0.30, green: 0.78, blue: 0.47)
        case "dinner":    return Color(red: 0.36, green: 0.54, blue: 0.96)
        case "dessert":   return Color(red: 0.93, green: 0.38, blue: 0.62)
        case "snacks":    return Color(red: 0.93, green: 0.62, blue: 0.22)
        case "beverages": return Color(red: 0.28, green: 0.74, blue: 0.92)
        default:          return Color(red: 0.78, green: 0.50, blue: 0.16)
        }
    }
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(LinearGradient(colors: [iconColor.opacity(0.9), iconColor.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                Image(systemName: recipe.heroImage)
                    .font(.system(size: 26, weight: .medium))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white.opacity(0.95), .white.opacity(0.5))
            }
            .frame(width: 64, height: 64)
            .shadow(color: iconColor.opacity(0.3), radius: 8, x: 0, y: 4)
            VStack(alignment: .leading, spacing: 5) {
                Text(recipe.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(2)
                HStack(spacing: 8) {
                    Label(recipe.difficulty, systemImage: "chart.bar.fill")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                    Text("·").foregroundColor(Color(.systemGray4))
                    Label("\(recipe.preparationTime + recipe.cookingTime) min", systemImage: "clock.fill")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                }
                HStack(spacing: 3) {
                    Image(systemName: "star.fill").font(.system(size: 14)).foregroundColor(.orange)
                    Text(String(format: "%.1f", recipe.rating))
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.primary)
                    Text("(\(recipe.reviews))")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
            }
            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color(.systemGray3))
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 18).fill(Color(.systemBackground)).shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 3))
        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(Color(.systemGray5).opacity(0.6), lineWidth: 0.5))
    }
}

// MARK: - Ingredient Chip
struct IngredientChip: View {
    @EnvironmentObject var modeManager: HealthModeManager
    let ingredient: String
    var body: some View {
        Text(ingredient)
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(modeManager.theme.primaryColor)
            .padding(.horizontal, 16).padding(.vertical, 10)
            .background(Capsule().fill(modeManager.theme.primaryColor.opacity(0.08)))
            .overlay(Capsule().strokeBorder(modeManager.theme.primaryColor.opacity(0.22), lineWidth: 1))
    }
}

// MARK: - Featured Action Card
struct FeaturedActionCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let gradientColors: [Color]
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Spacer()
                ZStack {
                    Circle().fill(.white.opacity(0.18)).frame(width: 54, height: 54)
                    Image(systemName: icon)
                        .font(.system(size: 24, weight: .semibold))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .white.opacity(0.6))
                }
                .padding(.top, 20).padding(.trailing, 18)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(2)
                Text(subtitle)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.85))
            }
            .padding(.horizontal, 18).padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity).frame(height: 170)
        .background(
            ZStack {
                LinearGradient(colors: gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing)
                LinearGradient(colors: [.white.opacity(0.12), .clear], startPoint: .top, endPoint: .center)
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .shadow(color: gradientColors[0].opacity(0.3), radius: 14, x: 0, y: 6)
        .overlay(RoundedRectangle(cornerRadius: 22).strokeBorder(.white.opacity(0.12), lineWidth: 1))
    }
}

// MARK: - Interactive Card Button Style
struct InteractiveCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.28, dampingFraction: 0.72), value: configuration.isPressed)
    }
}

#Preview {
    HomeView()
        .environmentObject(LocalDatabaseManager())
        .environmentObject(HealthModeManager())
}
