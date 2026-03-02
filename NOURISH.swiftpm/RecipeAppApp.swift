import SwiftUI

@main
struct RecipeApp: App {
    @StateObject private var db = LocalDatabaseManager()
    @StateObject private var modeManager = HealthModeManager()
    @StateObject private var profileStore = HealthProfileStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(db)
                .environmentObject(modeManager)
                .environmentObject(profileStore)
        }
    }
}

// MARK: - Planner Overlay State

final class PlannerOverlayState: ObservableObject {
    @Published var suggestionDate: Date? = nil

    func shouldShowSuggestion(for date: Date, hasFixedPlan: Bool, hasMeals: Bool) -> Bool {
        return hasFixedPlan && !hasMeals
    }

    func dismiss() { suggestionDate = nil }
}

// MARK: - Content View (Tab Bar — Apple-style glassy bottom bar)

struct ContentView: View {
    @EnvironmentObject var db: LocalDatabaseManager
    @EnvironmentObject var modeManager: HealthModeManager
    @EnvironmentObject var profileStore: HealthProfileStore
    @State private var selectedTab = 0
    @StateObject private var plannerOverlay = PlannerOverlayState()

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem { Label("Home", systemImage: "house.fill") }
                    .tag(0)

                SearchView()
                    .tabItem { Label("Search", systemImage: "magnifyingglass") }
                    .tag(1)

                MealPlannerView()
                    .environmentObject(plannerOverlay)
                    .environmentObject(profileStore)
                    .tabItem { Label("Planner", systemImage: "calendar") }
                    .tag(2)

                ShoppingListView()
                    .tabItem { Label("List", systemImage: "cart.fill") }
                    .tag(3)

                FavoritesView()
                    .tabItem { Label("Saved", systemImage: "heart.fill") }
                    .tag(4)
            }
            .accentColor(modeManager.theme.primaryColor)

            // Fixed Plan suggestion card — floats above tab bar
            if let suggestionDate = plannerOverlay.suggestionDate {
                let cal = Calendar.current
                FixedPlanSuggestionCard(
                    date: suggestionDate,
                    weekday: cal.component(.weekday, from: suggestionDate),
                    onDismiss: {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.78)) {
                            plannerOverlay.suggestionDate = nil
                        }
                    },
                    onApplied: {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.78)) {
                            plannerOverlay.suggestionDate = nil
                        }
                    }
                )
                .environmentObject(db)
                .environmentObject(modeManager)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(999)
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: plannerOverlay.suggestionDate != nil)
    }
}

#Preview {
    ContentView()
        .environmentObject(LocalDatabaseManager())
        .environmentObject(HealthModeManager())
        .environmentObject(HealthProfileStore())
}
