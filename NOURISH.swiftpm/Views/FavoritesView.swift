import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var db: LocalDatabaseManager
    @EnvironmentObject var modeManager: HealthModeManager
    @State private var searchText = ""

    var favoriteRecipes: [Recipe] {
        let ids = Set(db.favorites.map { $0.recipeId })
        return modeManager.filteredRecipes(from: db.recipes.filter { ids.contains($0.id) })
            .filter { searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: 0) {
                        HStack {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Saved")
                                    .font(.system(size: 32, weight: .bold, design: .rounded))
                                    .foregroundColor(.primary)
                                Text("\(favoriteRecipes.count) recipes")
                                    .font(.system(size: 14)).foregroundColor(.secondary)
                            }
                            Spacer()
                            if !favoriteRecipes.isEmpty {
                                ZStack {
                                    Circle().fill(Color(red:0.95,green:0.38,blue:0.38).opacity(0.12)).frame(width: 42, height: 42)
                                    Image(systemName: "heart.fill").font(.system(size: 18)).foregroundColor(Color(red:0.95,green:0.38,blue:0.38))
                                }
                            }
                        }
                        .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 14)

                        if !favoriteRecipes.isEmpty {
                            HStack(spacing: 10) {
                                Image(systemName: "magnifyingglass").font(.system(size: 15)).foregroundColor(.secondary)
                                TextField("Search saved...", text: $searchText).textFieldStyle(.plain)
                                if !searchText.isEmpty {
                                    Button { searchText = "" } label: {
                                        Image(systemName: "xmark.circle.fill").foregroundColor(.secondary)
                                    }
                                }
                            }
                            .padding(.horizontal, 14).padding(.vertical, 11)
                            .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 13))
                            .padding(.horizontal, 20).padding(.bottom, 12)
                        }
                        Divider()
                    }
                    .background(Color(.systemBackground))

                    if favoriteRecipes.isEmpty {
                        VStack(spacing: 20) {
                            ZStack {
                                Circle().fill(Color(red:0.95,green:0.38,blue:0.38).opacity(0.08)).frame(width: 90, height: 90)
                                Image(systemName: "heart").font(.system(size: 38, weight: .light)).foregroundColor(Color(red:0.95,green:0.38,blue:0.38).opacity(0.5))
                            }
                            VStack(spacing: 8) {
                                Text("No Saved Recipes").font(.system(size: 18, weight: .semibold))
                                Text("Tap the heart on any recipe\nto save it here")
                                    .font(.system(size: 14)).foregroundColor(.secondary).multilineTextAlignment(.center)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVStack(spacing: 10) {
                                ForEach(favoriteRecipes) { recipe in
                                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                        QuickSuggestionRow(recipe: recipe)
                                    }.buttonStyle(PlainButtonStyle())
                                }
                            }.padding(.horizontal, 20).padding(.vertical, 16)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}
