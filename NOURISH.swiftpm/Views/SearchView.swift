import SwiftUI
import Combine

// MARK: - SearchViewModel
@MainActor
final class SearchViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var filteredRecipes: [Recipe] = []
    @Published var cuisines: [String] = []
    @Published var diets: [String] = []
    @Published var selectedCuisine: String? = nil
    @Published var selectedDiet: String? = nil
    @Published var selectedMaxTime: Int? = nil
    @Published var selectedMaxCalories: Int? = nil

    private var cancellables = Set<AnyCancellable>()
    private var isConfigured = false
    private var filterTask: Task<Void, Never>?

    func configure(db: LocalDatabaseManager, modeManager: HealthModeManager) {
        guard !isConfigured else { return }
        isConfigured = true
        db.$recipes.combineLatest(modeManager.$currentMode)
            .debounce(for: .milliseconds(150), scheduler: RunLoop.main)
            .sink { [weak self] _, _ in self?.triggerFilter(db: db, modeManager: modeManager) }
            .store(in: &cancellables)
        let p0 = $searchQuery.map { _ in () }.eraseToAnyPublisher()
        let p1 = $selectedCuisine.map { _ in () }.eraseToAnyPublisher()
        let p2 = $selectedDiet.map { _ in () }.eraseToAnyPublisher()
        let p3 = $selectedMaxTime.map { _ in () }.eraseToAnyPublisher()
        let p4 = $selectedMaxCalories.map { _ in () }.eraseToAnyPublisher()
        Publishers.MergeMany([p0, p1, p2, p3, p4])
            .dropFirst().debounce(for: .milliseconds(80), scheduler: RunLoop.main)
            .sink { [weak self] in self?.triggerFilter(db: db, modeManager: modeManager) }
            .store(in: &cancellables)
        triggerFilter(db: db, modeManager: modeManager)
    }

    func triggerFilter(db: LocalDatabaseManager, modeManager: HealthModeManager) {
        let snap = db.recipes; let mode = modeManager.currentMode
        let q = searchQuery; let c = selectedCuisine; let d = selectedDiet
        let t = selectedMaxTime; let cal = selectedMaxCalories
        filterTask?.cancel()
        filterTask = Task { [weak self] in
            let (result, allC, allD) = await SearchViewModel.runFilter(recipes:snap,mode:mode,query:q,cuisine:c,diet:d,maxTime:t,maxCalories:cal)
            guard !Task.isCancelled else { return }
            await MainActor.run {
                withAnimation(.easeInOut(duration: 0.2)) {
                    self?.filteredRecipes = result
                }
                self?.cuisines = allC; self?.diets = allD
            }
        }
    }

    private nonisolated static func runFilter(recipes:[Recipe],mode:HealthMode,query:String,cuisine:String?,diet:String?,maxTime:Int?,maxCalories:Int?) async -> ([Recipe],[String],[String]) {
        let result = recipes.filter { r in
            guard r.mode == mode else { return false }
            if !query.isEmpty { let q=query.lowercased(); guard r.title.lowercased().contains(q)||r.description.lowercased().contains(q) else { return false } }
            if let c=cuisine, r.cuisine != c { return false }
            if let d=diet, r.diet != d { return false }
            if let t=maxTime, (r.preparationTime+r.cookingTime)>t { return false }
            if let cal=maxCalories, r.nutrition.calories>cal { return false }
            return true
        }
        return (result, Array(Set(result.map{$0.cuisine})).sorted(), Array(Set(result.map{$0.diet})).sorted())
    }
}

// MARK: - SearchView
struct SearchView: View {
    @EnvironmentObject var db: LocalDatabaseManager
    @EnvironmentObject var modeManager: HealthModeManager
    @StateObject private var viewModel = SearchViewModel()
    @StateObject private var speechManager = SpeechRecognizerManager()

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                VStack(spacing: 0) {

                    // ── Sticky Header ─────────────────────────────────────
                    VStack(spacing: 0) {
                        // Title bar
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Search")
                                    .font(.system(size: 32, weight: .bold, design: .rounded))
                                    .foregroundColor(.primary)
                                Text("\(viewModel.filteredRecipes.count) recipes")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            // Mode badge
                            HStack(spacing: 5) {
                                Image(systemName: modeManager.currentMode.icon)
                                    .font(.system(size: 14, weight: .semibold))
                                Text(modeManager.currentMode.displayName)
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .foregroundColor(modeManager.theme.primaryColor)
                            .padding(.horizontal, 12).padding(.vertical, 7)
                            .background(modeManager.theme.primaryColor.opacity(0.10), in: Capsule())
                        }
                        .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 14)

                        // Search bar — glassy material
                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.secondary)
                            TextField("Search recipes...", text: $viewModel.searchQuery)
                                .textFieldStyle(.plain)
                                .font(.system(size: 16, weight: .regular))
                            if !viewModel.searchQuery.isEmpty {
                                Button { viewModel.searchQuery = "" } label: {
                                    Image(systemName: "xmark.circle.fill").foregroundColor(.secondary).font(.system(size: 15))
                                }
                            }
                            MicButton(speechManager: speechManager)
                        }
                        .padding(.horizontal, 14).padding(.vertical, 12)
                        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
                        .padding(.horizontal, 20).padding(.bottom, 12)

                        // Filter chips
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                Menu {
                                    Button("All Cuisines") { withAnimation(.easeInOut(duration: 0.2)) { viewModel.selectedCuisine = nil } }
                                    Divider()
                                    ForEach(viewModel.cuisines, id: \.self) { c in Button(c) { withAnimation(.easeInOut(duration: 0.2)) { viewModel.selectedCuisine = c } } }
                                } label: { FilterChip(label: viewModel.selectedCuisine ?? "Cuisine", isActive: viewModel.selectedCuisine != nil) }

                                Menu {
                                    Button("All Diets") { withAnimation(.easeInOut(duration: 0.2)) { viewModel.selectedDiet = nil } }
                                    Divider()
                                    ForEach(viewModel.diets, id: \.self) { d in Button(d) { withAnimation(.easeInOut(duration: 0.2)) { viewModel.selectedDiet = d } } }
                                } label: { FilterChip(label: viewModel.selectedDiet ?? "Diet", isActive: viewModel.selectedDiet != nil) }

                                Menu {
                                    Button("Any Time") { withAnimation(.easeInOut(duration: 0.2)) { viewModel.selectedMaxTime = nil } }
                                    Divider()
                                    Button("15 min") { withAnimation(.easeInOut(duration: 0.2)) { viewModel.selectedMaxTime = 15 } }
                                    Button("30 min") { withAnimation(.easeInOut(duration: 0.2)) { viewModel.selectedMaxTime = 30 } }
                                    Button("60 min") { withAnimation(.easeInOut(duration: 0.2)) { viewModel.selectedMaxTime = 60 } }
                                    Button("90 min") { withAnimation(.easeInOut(duration: 0.2)) { viewModel.selectedMaxTime = 90 } }
                                } label: { FilterChip(label: viewModel.selectedMaxTime.map { "\($0)m" } ?? "Time", isActive: viewModel.selectedMaxTime != nil) }

                                Menu {
                                    Button("Any Calories") { withAnimation(.easeInOut(duration: 0.2)) { viewModel.selectedMaxCalories = nil } }
                                    Divider()
                                    Button("200 cal") { withAnimation(.easeInOut(duration: 0.2)) { viewModel.selectedMaxCalories = 200 } }
                                    Button("300 cal") { withAnimation(.easeInOut(duration: 0.2)) { viewModel.selectedMaxCalories = 300 } }
                                    Button("400 cal") { withAnimation(.easeInOut(duration: 0.2)) { viewModel.selectedMaxCalories = 400 } }
                                    Button("500 cal") { withAnimation(.easeInOut(duration: 0.2)) { viewModel.selectedMaxCalories = 500 } }
                                    Button("600 cal") { withAnimation(.easeInOut(duration: 0.2)) { viewModel.selectedMaxCalories = 600 } }
                                } label: { FilterChip(label: viewModel.selectedMaxCalories.map { "\($0) cal" } ?? "Calories", isActive: viewModel.selectedMaxCalories != nil) }
                            }
                            .padding(.horizontal, 20)
                        }
                        .scrollClipDisabled()
                        .padding(.bottom, 12)

                        Divider()
                    }
                    .background(Color(.systemBackground))

                    // ── Results ───────────────────────────────────────────
                    if viewModel.filteredRecipes.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 44, weight: .light))
                                .foregroundColor(modeManager.theme.primaryColor.opacity(0.4))
                            Text("No Recipes Found")
                                .font(.system(size: 18, weight: .semibold))
                            Text("Try different filters or a new search")
                                .font(.system(size: 14)).foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.opacity.combined(with: .scale(scale: 0.96)))
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)], spacing: 14) {
                                ForEach(viewModel.filteredRecipes) { recipe in
                                    NavigationLink(value: recipe) {
                                        RecipeGridCard(recipe: recipe)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, 20).padding(.vertical, 16)
                            .animation(.easeInOut(duration: 0.22), value: viewModel.filteredRecipes.map { $0.id })
                        }
                        .navigationDestination(for: Recipe.self) { recipe in
                            RecipeDetailView(recipe: recipe)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                viewModel.configure(db: db, modeManager: modeManager)
                speechManager.requestPermissions { _ in }
            }
            .onDisappear { speechManager.stopRecording() }
            .onChange(of: speechManager.recognizedText) { _, newText in
                guard !newText.isEmpty else { return }
                viewModel.searchQuery = newText
            }
        }
    }
}

// MARK: - MicButton
private struct MicButton: View {
    @ObservedObject var speechManager: SpeechRecognizerManager
    @State private var isPressed = false
    var body: some View {
        ZStack {
            if speechManager.isRecording {
                Circle().fill(Color.red.opacity(0.15)).frame(width: 36, height: 36)
                    .scaleEffect(isPressed ? 1.0 : 1.3)
                    .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: speechManager.isRecording)
            }
            Image(systemName: speechManager.isRecording ? "mic.fill" : "mic")
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(speechManager.isRecording ? .red : .secondary)
                .frame(width: 32, height: 32).contentShape(Rectangle())
        }
        .gesture(DragGesture(minimumDistance: 0)
            .onChanged { _ in
                guard !isPressed else { return }; isPressed = true
                if speechManager.permissionsGranted { speechManager.startRecording() }
                else { speechManager.requestPermissions { granted in if granted { speechManager.startRecording() } } }
            }
            .onEnded { _ in isPressed = false; speechManager.stopRecording() }
        )
        .onChange(of: speechManager.isRecording) { _, recording in isPressed = recording }
    }
}

// MARK: - FilterChip
struct FilterChip: View {
    @EnvironmentObject var modeManager: HealthModeManager
    let label: String
    let isActive: Bool
    var body: some View {
        HStack(spacing: 5) {
            Text(label).font(.system(size: 14, weight: .semibold))
            if isActive { Image(systemName: "chevron.down").font(.system(size: 14, weight: .bold)) }
        }
        .foregroundColor(isActive ? .white : .primary)
        .padding(.horizontal, 14).padding(.vertical, 9)
        .background(isActive ? modeManager.theme.primaryColor : Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
    }
}

// MARK: - RecipeGridCard
struct RecipeGridCard: View {
    @EnvironmentObject var modeManager: HealthModeManager
    let recipe: Recipe
    private var cardColor: Color {
        switch recipe.category.lowercased() {
        case "breakfast": return Color(red:1.0,green:0.72,blue:0.25)
        case "lunch":     return Color(red:0.30,green:0.78,blue:0.47)
        case "dinner":    return Color(red:0.36,green:0.54,blue:0.96)
        case "dessert":   return Color(red:0.93,green:0.42,blue:0.62)
        case "snacks":    return Color(red:0.93,green:0.62,blue:0.22)
        case "beverages": return Color(red:0.28,green:0.74,blue:0.92)
        default:          return modeManager.theme.primaryColor
        }
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                LinearGradient(colors:[cardColor.opacity(0.9),cardColor.opacity(0.55)], startPoint:.topLeading, endPoint:.bottomTrailing)
                LinearGradient(colors:[.white.opacity(0.18),.clear], startPoint:.top, endPoint:.center)
                Image(systemName: recipe.heroImage).font(.system(size: 38, weight: .light))
                    .symbolRenderingMode(.palette).foregroundStyle(.white.opacity(0.95), .white.opacity(0.5))
            }
            .frame(height: 128).clipShape(RoundedRectangle(cornerRadius: 14))
            .shadow(color: cardColor.opacity(0.28), radius: 8, x: 0, y: 4)

            VStack(alignment: .leading, spacing: 5) {
                Text(recipe.title).font(.system(size: 14, weight: .semibold)).lineLimit(2).foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true).frame(minHeight: 34, alignment: .topLeading)
                HStack(spacing: 4) {
                    Image(systemName: "star.fill").font(.system(size: 14)).foregroundColor(.orange)
                    Text(String(format: "%.1f", recipe.rating)).font(.system(size: 14, weight: .medium)).foregroundColor(.primary)
                }
                HStack(spacing: 4) {
                    Image(systemName: "clock.fill").font(.system(size: 14)).foregroundColor(.secondary)
                    Text("\(recipe.preparationTime+recipe.cookingTime) min").font(.system(size: 14)).foregroundColor(.secondary)
                }
            }
            .padding(.horizontal, 12).padding(.vertical, 12)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 3)
        .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Color(.systemGray5).opacity(0.5), lineWidth: 0.5))
    }
}

#Preview { SearchView().environmentObject(LocalDatabaseManager()).environmentObject(HealthModeManager()) }
