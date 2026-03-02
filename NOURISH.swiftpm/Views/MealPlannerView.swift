import SwiftUI

// MARK: - Meal Planner View

struct MealPlannerView: View {
    @EnvironmentObject var db:             LocalDatabaseManager
    @EnvironmentObject var modeManager:    HealthModeManager
    @EnvironmentObject var plannerOverlay: PlannerOverlayState
    @EnvironmentObject var profileStore:   HealthProfileStore
    @StateObject private var vm = MealPlannerViewModel()

    @State private var selectedDate        = Date()
    @State private var showRecipeSelector  = false
    @State private var selectedMealSlot    = MealSlot.breakfast
    @State private var showPlannedMeals    = false
    @State private var planMode: PlanMode  = {
        let raw = UserDefaults.standard.string(forKey: "mealPlannerMode") ?? "Regular"
        return PlanMode(rawValue: raw) ?? .regular
    }()

    @State private var showFixedPlanSetup  = false
    @State private var showSmartPlanSetup  = false   // health profile form
    @State private var showRecommendedPlan = false   // view/edit generated plan

    let calendar = Calendar.current

    // MARK: - Dates

    var dateRange: [Date] {
        let today = calendar.startOfDay(for: Date())
        return (-2...7).compactMap { calendar.date(byAdding: .day, value: $0, to: today) }
    }

    var outOfRangeMealPlan: [MealPlanItem] {
        let rangeSet = Set(dateRange.map { calendar.startOfDay(for: $0) })
        return db.mealPlan
            .filter { !rangeSet.contains(calendar.startOfDay(for: $0.date)) && $0.source == activeSource }
            .sorted { $0.date < $1.date }
    }
    var hasOutOfRangeMeals: Bool { !outOfRangeMealPlan.isEmpty }

    private var activeSource: String { planMode.rawValue.lowercased() }

    func getMealsForDate(_ date: Date) -> [MealPlanItem] {
        db.getMealPlanForDate(date, source: activeSource)
    }

    // MARK: - Nutrition

    // Meals for the selected date — computed once, used by both summary card and meal slots
    private var selectedDateMeals: [MealPlanItem] {
        getMealsForDate(selectedDate)
    }
    private var plannedRecipes: [Recipe] {
        selectedDateMeals.compactMap { db.recipeIndex[$0.recipeId] }
    }
    private var totalCalories: Int    { plannedRecipes.reduce(0)   { $0 + $1.nutrition.calories } }
    private var totalProtein:  Double { plannedRecipes.reduce(0.0) { $0 + vm.parseNutritionValue($1.nutrition.protein) } }
    private var totalCarbs:    Double { plannedRecipes.reduce(0.0) { $0 + vm.parseNutritionValue($1.nutrition.carbs) } }
    private var totalFat:      Double { plannedRecipes.reduce(0.0) { $0 + vm.parseNutritionValue($1.nutrition.fat) } }

    private func intakeDateLabel(for date: Date) -> String {
        if calendar.isDateInToday(date)     { return "Today's Intake" }
        if calendar.isDateInYesterday(date) { return "Yesterday's Intake" }
        if calendar.isDateInTomorrow(date)  { return "Tomorrow's Intake" }
        return MealPlannerView.intakeDateFormatter.string(from: date)
    }
    private static let intakeDateFormatter: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "EEEE, MMM d"; return f
    }()

    // MARK: - Plan Mode Switching

    private func savePlanMode(_ mode: PlanMode) {
        vm.planMode = mode
        withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) { planMode = mode }
    }

    private func handleRegularTap() {
        savePlanMode(.regular)
    }

    private func handleFixedTap() {
        let hasSetup = db.fixedPlan.contains { $0.mode == modeManager.currentMode.rawValue }
        if planMode == .fixed {
            showFixedPlanSetup = true
        } else {
            savePlanMode(.fixed)
            if !hasSetup {
                showFixedPlanSetup = true
            } else {
                triggerFixedSuggestionIfNeeded(for: selectedDate)
            }
        }
    }

    /// Smart tap logic:
    /// - No profile for this mode → open profile form (block until filled)
    /// - Profile exists, not yet in smart mode → switch + fill all dates
    /// - Already in smart mode → open recommended plan view to edit
    private func handleSmartTap() {
        let mode       = modeManager.currentMode
        let hasProfile = profileStore.hasCompletedProfile(for: mode)

        if planMode == .smart {
            // Already active: let user view / edit the plan
            if hasProfile {
                showRecommendedPlan = true
            } else {
                showSmartPlanSetup = true
            }
        } else {
            if !hasProfile {
                // Must fill profile before smart activates
                savePlanMode(.smart)
                showSmartPlanSetup = true
            } else {
                // Profile already on file: switch and fill immediately
                savePlanMode(.smart)
                activateSmartPlan(for: mode)
            }
        }
    }

    // MARK: - Smart Plan Activation

    /// Generates the plan (if needed) then fills ALL visible dates.
    /// This is the single entry point for all smart fill operations.
    private func activateSmartPlan(for mode: HealthMode) {
        guard profileStore.hasCompletedProfile(for: mode) else { return }
        let profile = profileStore.profile(for: mode) ?? HealthProfile()

        // Step 1: Generate the 7-day scored plan (no-op if already cached for this mode)
        vm.generateSmartPlan(
            allRecipes: db.recipes,
            mode: mode,
            profile: profile,
            force: false
        )

        // Step 2: Fill all visible dates once generation finishes
        // We observe isGenerating in .onChange below
        // If plan was already cached, generation is instant — fill directly
        if vm.hasSmartPlan(for: mode) {
            fillAllDates(for: mode, profile: profile)
        }
        // else: .onChange(of: vm.isGenerating) fires when Task finishes → fillAllDates called there
    }

    /// Writes smart meals for every date in dateRange.
    private func fillAllDates(for mode: HealthMode, profile: HealthProfile) {
        vm.fillSmartMealsForAllDates(
            dates: dateRange,
            mode: mode,
            profile: profile,
            allRecipes: db.recipes,
            existingMealPlan: db.mealPlan
        ) { recipeId, date, slotRaw in
            db.addMealPlan(recipeId, date: date, meal: slotRaw, source: "smart")
        }
    }

    // MARK: - Fixed Plan Suggestion

    private func triggerFixedSuggestionIfNeeded(for date: Date) {
        let wd           = calendar.component(.weekday, from: date)
        let hasMeals     = !getMealsForDate(date).isEmpty
        let hasFixedPlan = db.hasFixedPlan(for: wd, mode: modeManager.currentMode.rawValue)
        if plannerOverlay.shouldShowSuggestion(for: date, hasFixedPlan: hasFixedPlan, hasMeals: hasMeals) {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                plannerOverlay.suggestionDate = date
            }
        }
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()

                VStack(spacing: 0) {

                    // ── Header ──────────────────────────────────────────────
                    VStack(spacing: 0) {
                        HStack(alignment: .center, spacing: 10) {
                            Text("Meal Planner")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .foregroundColor(.primary)
                                .layoutPriority(1)

                            Spacer(minLength: 4)

                            ThreePlanSwitch(
                                current: planMode,
                                accentColor: modeManager.theme.primaryColor,
                                isNormalMode: modeManager.currentMode == .normal,
                                onRegular: handleRegularTap,
                                onFixed:   handleFixedTap,
                                onSmart:   handleSmartTap
                            )

                            if hasOutOfRangeMeals {
                                Button { showPlannedMeals = true } label: {
                                    Image(systemName: "calendar.badge.clock")
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(modeManager.theme.primaryColor)
                                        .padding(7)
                                        .background(modeManager.theme.primaryColor.opacity(0.10), in: Circle())
                                }
                                .buttonStyle(.plain)
                                .overlay(alignment: .topTrailing) {
                                    Text("\(outOfRangeMealPlan.count)")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(3)
                                        .background(modeManager.theme.primaryColor, in: Circle())
                                        .offset(x: 3, y: -3)
                                }
                                .transition(.scale(scale: 0.8).combined(with: .opacity))
                            }
                        }
                        .padding(.horizontal, 16).padding(.vertical, 13)
                        .animation(.spring(response: 0.35, dampingFraction: 0.75), value: hasOutOfRangeMeals)
                    }
                    .background(Color(.systemGray6))
                    .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)

                    // ── Date Strip ──────────────────────────────────────────
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(dateRange, id: \.self) { date in
                                DayTabButton(
                                    date: date,
                                    isSelected: calendar.isDate(selectedDate, inSameDayAs: date),
                                    hasMeals: !getMealsForDate(date).isEmpty,
                                    accentColor: modeManager.theme.primaryColor
                                ) {
                                    withAnimation(.spring(response: 0.28, dampingFraction: 0.78)) {
                                        selectedDate = date
                                    }
                                    if planMode == .fixed {
                                        triggerFixedSuggestionIfNeeded(for: date)
                                    }
                                    // Smart: no action on date tap — meals already filled for all dates
                                }
                            }
                        }
                        .padding(.horizontal, 16).padding(.vertical, 12)
                    }
                    .background(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)

                    // ── Meal Content ────────────────────────────────────────
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {

                            // Smart mode: block all content until profile is complete
                            if planMode == .smart && !profileStore.hasCompletedProfile(for: modeManager.currentMode) {
                                SmartPlanProfileRequiredView(
                                    accentColor: modeManager.theme.primaryColor,
                                    onTapSetup: { showSmartPlanSetup = true }
                                )
                                .padding(.top, 40)
                                .transition(.opacity.combined(with: .move(edge: .bottom)))
                            } else {
                            if !plannedRecipes.isEmpty {
                                let wellness = vm.wellnessMessage(
                                    calories: totalCalories,
                                    protein:  totalProtein,
                                    plannedCount: plannedRecipes.count
                                )
                                DailyIntakeSummaryCard(
                                    totalCalories: totalCalories,
                                    totalProtein:  totalProtein,
                                    totalCarbs:    totalCarbs,
                                    totalFat:      totalFat,
                                    wellnessMessage: wellness,
                                    accentColor:   modeManager.theme.primaryColor,
                                    dateLabel:     intakeDateLabel(for: selectedDate)
                                )
                                .transition(.opacity.combined(with: .scale(scale: 0.97)))
                            }

                            ForEach(MealSlot.allCases) { slot in
                                MealTypeSection(
                                    mealType: slot.rawValue,
                                    date: selectedDate,
                                    items: selectedDateMeals.filter { $0.meal == slot.rawValue },
                                    onAddTap: {
                                        selectedMealSlot   = slot
                                        showRecipeSelector = true
                                    },
                                    onDelete: { itemId in
                                        withAnimation(.easeOut(duration: 0.22)) {
                                            db.removeMealPlan(itemId)
                                        }
                                    }
                                )
                            }
                            }  // end else (profile complete)
                        }
                        .padding(16)
                        .animation(.easeInOut(duration: 0.25), value: plannedRecipes.count)
                        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: planMode)
                    }
                }
            }

            // ── Sheets ──────────────────────────────────────────────────────
            .sheet(isPresented: $showRecipeSelector) {
                MealPlanRecipeSelectorView(
                    date: selectedDate,
                    mealType: selectedMealSlot.rawValue,
                    source: activeSource
                )
                .environmentObject(db)
                .environmentObject(modeManager)
            }
            .sheet(isPresented: $showPlannedMeals) {
                PlannedMealsView(items: outOfRangeMealPlan)
                    .environmentObject(db).environmentObject(modeManager)
            }
            .sheet(isPresented: $showFixedPlanSetup, onDismiss: {
                triggerFixedSuggestionIfNeeded(for: selectedDate)
            }) {
                FixedPlanView()
                    .environmentObject(db).environmentObject(modeManager)
            }
            // Profile form — only opens when profile not yet filled for this mode
            .sheet(isPresented: $showSmartPlanSetup, onDismiss: {
                let mode = modeManager.currentMode
                // Only activate if profile was actually completed
                if profileStore.hasCompletedProfile(for: mode) {
                    activateSmartPlan(for: mode)
                } else {
                    // User dismissed without completing — revert to regular
                    savePlanMode(.regular)
                }
            }) {
                HealthProfileView(mode: modeManager.currentMode)
                    .environmentObject(profileStore).environmentObject(modeManager)
            }
            // Recommended plan view — shows generated plan, lets user regenerate
            .sheet(isPresented: $showRecommendedPlan, onDismiss: {
                let mode = modeManager.currentMode
                if profileStore.hasCompletedProfile(for: mode) {
                    // Re-fill all dates after any edits
                    let profile = profileStore.profile(for: mode) ?? HealthProfile()
                    fillAllDates(for: mode, profile: profile)
                }
            }) {
                RecommendedPlanView(viewModel: vm)
                    .environmentObject(db).environmentObject(modeManager).environmentObject(profileStore)
            }
            .navigationBarTitleDisplayMode(.inline)

            // ── Lifecycle ───────────────────────────────────────────────────
            .onAppear {
                let mode = modeManager.currentMode
                // Normal mode cannot use Smart
                if mode == .normal && planMode == .smart {
                    savePlanMode(.regular)
                    return
                }
                // If returning to smart mode with a valid profile, ensure all dates are filled
                if planMode == .smart && profileStore.hasCompletedProfile(for: mode) {
                    activateSmartPlan(for: mode)
                }
            }
            // When health mode changes:
            .onChange(of: modeManager.currentMode) { _, newMode in
                if newMode == .normal && planMode == .smart {
                    savePlanMode(.regular)
                    return
                }
                // If user is in smart mode and switches health mode:
                // check if the new mode has its own profile; if not, require profile entry
                if planMode == .smart {
                    if profileStore.hasCompletedProfile(for: newMode) {
                        activateSmartPlan(for: newMode)
                    } else {
                        // New mode has no profile — open profile form
                        showSmartPlanSetup = true
                    }
                }
            }
            // When smart plan generation finishes → fill all dates
            .onChange(of: vm.isGenerating) { _, generating in
                if !generating && planMode == .smart {
                    let mode = modeManager.currentMode
                    if vm.hasSmartPlan(for: mode),
                       profileStore.hasCompletedProfile(for: mode) {
                        let profile = profileStore.profile(for: mode) ?? HealthProfile()
                        fillAllDates(for: mode, profile: profile)
                    }
                }
            }
        }
    }
}

// MARK: - Compact Three-Way Plan Picker

private struct ThreePlanSwitch: View {
    let current:      PlanMode
    let accentColor:  Color
    let isNormalMode: Bool
    let onRegular:    () -> Void
    let onFixed:      () -> Void
    let onSmart:      () -> Void

    @Namespace private var pillNS

    var body: some View {
        HStack(spacing: 0) {
            pill(title: "Regular", mode: .regular, action: onRegular)
            pill(title: "Fixed",   mode: .fixed,   action: onFixed)
            if !isNormalMode {
                pill(title: "Smart", mode: .smart, action: onSmart)
            }
        }
        .padding(3)
        .background(Color(.systemGray5), in: RoundedRectangle(cornerRadius: 10))
    }

    @ViewBuilder
    private func pill(title: String, mode: PlanMode, action: @escaping () -> Void) -> some View {
        let active = current == mode
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                action()
            }
        }) {
            Text(title)
                .font(.system(size: 13, weight: active ? .semibold : .medium))
                .foregroundColor(active ? .primary : Color(.systemGray))
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background {
                    if active {
                        RoundedRectangle(cornerRadius: 7)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.10), radius: 3, x: 0, y: 1)
                            .matchedGeometryEffect(id: "activePill", in: pillNS)
                    }
                }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Planned Meals View

struct PlannedMealsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var db: LocalDatabaseManager
    @EnvironmentObject var modeManager: HealthModeManager

    let items: [MealPlanItem]

    private var accentColor: Color { modeManager.theme.primaryColor }
    private let calendar = Calendar.current

    private var groupedByDate: [(key: Date, values: [MealPlanItem])] {
        Dictionary(grouping: items) { calendar.startOfDay(for: $0.date) }
            .sorted { $0.key < $1.key }
            .map { (key: $0.key, values: $0.value) }
    }

    private func headerLabel(for date: Date) -> String {
        let sameYear = calendar.isDate(date, equalTo: Date(), toGranularity: .year)
        let fmt = sameYear ? PlannedMealsView.shortFmt : PlannedMealsView.longFmt
        return fmt.string(from: date)
    }
    private static let shortFmt: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "EEEE, MMM d"; return f
    }()
    private static let longFmt: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "EEEE, MMM d · yyyy"; return f
    }()

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                if groupedByDate.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "calendar.badge.checkmark")
                            .font(.system(size: 48, weight: .light))
                            .foregroundColor(accentColor.opacity(0.45))
                        Text("No upcoming planned meals")
                            .font(.system(size: 16, weight: .semibold))
                        Text("Meals planned beyond the active week\nwill appear here.")
                            .font(.system(size: 14)).foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }.padding()
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            ForEach(groupedByDate, id: \.key) { group in
                                PlannedDateSection(
                                    headerLabel: headerLabel(for: group.key),
                                    items: group.values,
                                    accentColor: accentColor
                                )
                            }
                        }
                        .padding(16)
                        .animation(.easeInOut(duration: 0.22), value: db.mealPlan.count)
                    }
                }
            }
            .navigationTitle("Planned Meals")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }.foregroundColor(accentColor)
                }
            }
        }
    }
}

// MARK: - Planned Date Section

private struct PlannedDateSection: View {
    @EnvironmentObject var db: LocalDatabaseManager

    let headerLabel: String
    let items: [MealPlanItem]
    let accentColor: Color

    private var orderedItems: [MealPlanItem] {
        let order = MealSlot.allCases.map { $0.rawValue }
        return items.sorted {
            (order.firstIndex(of: $0.meal) ?? 99) < (order.firstIndex(of: $1.meal) ?? 99)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: "calendar").font(.system(size: 14, weight: .semibold)).foregroundColor(accentColor)
                Text(headerLabel).font(.system(size: 14, weight: .semibold)).foregroundColor(accentColor)
                Spacer()
                Text("\(items.count) meal\(items.count == 1 ? "" : "s")").font(.system(size: 14)).foregroundColor(.secondary)
            }
            .padding(.horizontal, 14).padding(.top, 14).padding(.bottom, 10)

            VStack(spacing: 8) {
                ForEach(orderedItems) { item in
                    if let recipe = db.recipeIndex[item.recipeId] {
                        PlannedMealRow(recipe: recipe, mealType: item.meal, accentColor: accentColor,
                                      onDelete: { withAnimation(.easeOut(duration: 0.22)) { db.removeMealPlan(item.id) } })
                    }
                }
            }
            .padding(.horizontal, 14).padding(.bottom, 14)
        }
        .background(RoundedRectangle(cornerRadius: 18).fill(Color(.systemBackground))
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 3))
        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(Color(.systemGray5).opacity(0.5), lineWidth: 0.5))
    }
}

// MARK: - Planned Meal Row

private struct PlannedMealRow: View {
    let recipe: Recipe
    let mealType: String
    let accentColor: Color
    let onDelete: () -> Void

    @State private var isPressed = false

    private var mealIcon: String { MealSlot(rawValue: mealType)?.icon ?? "🍴" }

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(colors: [accentColor.opacity(0.85), accentColor.opacity(0.55)],
                                        startPoint: .topLeading, endPoint: .bottomTrailing))
                Image(systemName: recipe.heroImage)
                    .font(.system(size: 15, weight: .medium))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white.opacity(0.95), .white.opacity(0.6))
            }
            .frame(width: 42, height: 42)
            .shadow(color: accentColor.opacity(0.25), radius: 5, x: 0, y: 2)

            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 4) {
                    Text(mealIcon).font(.system(size: 14))
                    Text(mealType.capitalized)
                        .font(.system(size: 14, weight: .semibold)).foregroundColor(accentColor)
                        .padding(.horizontal, 6).padding(.vertical, 2)
                        .background(accentColor.opacity(0.10)).clipShape(Capsule())
                }
                Text(recipe.title).font(.system(size: 14, weight: .semibold)).foregroundColor(.primary).lineLimit(1)
                HStack(spacing: 6) {
                    Label("\(recipe.preparationTime + recipe.cookingTime)m", systemImage: "clock")
                        .font(.system(size: 14)).foregroundColor(.secondary)
                    Text("·").foregroundColor(Color(.systemGray3)).font(.system(size: 14))
                    Text(recipe.difficulty).font(.system(size: 14)).foregroundColor(.secondary)
                    Text("·").foregroundColor(Color(.systemGray3)).font(.system(size: 14))
                    Text("\(recipe.nutrition.calories) kcal")
                        .font(.system(size: 14, weight: .medium)).foregroundColor(accentColor.opacity(0.8))
                }
            }
            Spacer(minLength: 0)
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill").font(.system(size: 19)).foregroundColor(Color(.systemGray3))
            }.buttonStyle(.plain)
        }
        .padding(.horizontal, 12).padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6).opacity(0.7)))
        .scaleEffect(isPressed ? 0.985 : 1.0)
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isPressed)
        .onLongPressGesture(minimumDuration: .infinity, pressing: { isPressed = $0 }, perform: {})
    }
}

// MARK: - Day Tab Button

private struct DayTabButton: View {
    let date: Date
    let isSelected: Bool
    let hasMeals: Bool
    let accentColor: Color
    let onTap: () -> Void

    private var cal: Calendar { .current }
    private var isToday: Bool { cal.isDateInToday(date) }

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 5) {
                Text(dayName)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(isSelected ? .white : .secondary)
                Text("\(cal.component(.day, from: date))")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(isSelected ? .white : (isToday ? accentColor : .primary))
                Circle()
                    .fill(isSelected ? Color.white.opacity(0.7) : accentColor.opacity(hasMeals ? 0.7 : 0))
                    .frame(width: 5, height: 5)
            }
            .frame(width: 50, height: 68)
            .background(RoundedRectangle(cornerRadius: 14)
                .fill(isSelected ? accentColor : (isToday ? accentColor.opacity(0.08) : Color(.systemGray6))))
            .overlay(RoundedRectangle(cornerRadius: 14)
                .strokeBorder(isToday && !isSelected ? accentColor.opacity(0.35) : Color.clear, lineWidth: 1.5))
            .shadow(color: isSelected ? accentColor.opacity(0.25) : Color.clear, radius: 6, x: 0, y: 3)
            .animation(.spring(response: 0.28, dampingFraction: 0.78), value: isSelected)
        }
        .buttonStyle(.plain)
    }

    private var dayName: String {
        DayTabButton.dayNameFormatter.string(from: date)
    }
    private static let dayNameFormatter: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "EEE"; return f
    }()
}

// MARK: - Daily Intake Summary Card

private struct DailyIntakeSummaryCard: View {
    let totalCalories:   Int
    let totalProtein:    Double
    let totalCarbs:      Double
    let totalFat:        Double
    let wellnessMessage: (icon: String, text: String, color: Color)
    let accentColor:     Color
    let dateLabel:       String

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                Image(systemName: "chart.bar.fill")
                    .font(.system(size: 14, weight: .semibold)).foregroundColor(accentColor)
                Text(dateLabel).font(.system(size: 14, weight: .semibold)).foregroundColor(.primary)
                Spacer()
                HStack(spacing: 5) {
                    Image(systemName: wellnessMessage.icon).font(.system(size: 14, weight: .semibold))
                    Text(wellnessMessage.text).font(.system(size: 14, weight: .semibold)).lineLimit(1)
                }
                .foregroundColor(wellnessMessage.color)
                .padding(.horizontal, 10).padding(.vertical, 5)
                .background(wellnessMessage.color.opacity(0.10))
                .clipShape(Capsule())
            }

            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Text("\(totalCalories)")
                    .font(.system(size: 38, weight: .bold, design: .rounded)).foregroundColor(.primary)
                Text("kcal")
                    .font(.system(size: 16, weight: .medium)).foregroundColor(.secondary).padding(.bottom, 2)
            }

            HStack(spacing: 10) {
                MacroPill(label: "Protein", value: "\(Int(totalProtein))g", color: Color(red: 0.95, green: 0.38, blue: 0.38))
                MacroPill(label: "Carbs",   value: "\(Int(totalCarbs))g",   color: Color(red: 0.20, green: 0.78, blue: 0.35))
                MacroPill(label: "Fat",     value: "\(Int(totalFat))g",     color: Color(red: 0.95, green: 0.58, blue: 0.15))
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 18).fill(Color(.systemBackground))
            .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 4))
        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(accentColor.opacity(0.12), lineWidth: 1))
    }
}

// MARK: - Macro Pill

private struct MacroPill: View {
    let label: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 3) {
            Text(value).font(.system(size: 15, weight: .bold, design: .rounded)).foregroundColor(color)
            Text(label).font(.system(size: 14, weight: .medium)).foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity).padding(.vertical, 10)
        .background(color.opacity(0.09))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(color.opacity(0.18), lineWidth: 1))
    }
}

// MARK: - Meal Type Section

struct MealTypeSection: View {
    let mealType: String
    let date: Date
    let items: [MealPlanItem]
    let onAddTap: () -> Void
    let onDelete: (String) -> Void

    @EnvironmentObject var db: LocalDatabaseManager
    @EnvironmentObject var modeManager: HealthModeManager

    private var slot: MealSlot { MealSlot(rawValue: mealType) ?? .breakfast }
    private var iconTint: Color { modeManager.theme.primaryColor }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 10) {
                Text(slot.icon)
                    .font(.system(size: 18))
                    .frame(width: 36, height: 36)
                    .background(iconTint.opacity(0.10))
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                Text(slot.displayName)
                    .font(.system(size: 16, weight: .semibold)).foregroundColor(.primary)

                if !items.isEmpty {
                    let cal = items.compactMap { item in
                        db.recipeIndex[item.recipeId]?.nutrition.calories
                    }.reduce(0, +)
                    Text("· \(cal) kcal")
                        .font(.system(size: 14, weight: .regular)).foregroundColor(.secondary)
                }
                Spacer()
                Button(action: onAddTap) {
                    Image(systemName: "plus.circle.fill").font(.system(size: 22)).foregroundColor(iconTint)
                }.buttonStyle(.plain)
            }
            .padding(.horizontal, 14).padding(.top, 14).padding(.bottom, 10)

            if items.isEmpty {
                VStack(spacing: 6) {
                    Image(systemName: "fork.knife").font(.system(size: 22)).foregroundColor(Color(.systemGray3))
                    Text("No meal planned").font(.system(size: 14)).foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity).frame(height: 80)
                .background(Color(.systemGray6).opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 14).padding(.bottom, 14)
            } else {
                VStack(spacing: 8) {
                    ForEach(items) { item in
                        if let recipe = db.recipeIndex[item.recipeId] {
                            MealPlanRow(recipe: recipe, accentColor: iconTint, onDelete: { onDelete(item.id) })
                        }
                    }
                }
                .padding(.horizontal, 14).padding(.bottom, 14)
            }
        }
        .background(RoundedRectangle(cornerRadius: 18).fill(Color(.systemBackground))
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 3))
        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(Color(.systemGray5).opacity(0.5), lineWidth: 0.5))
    }
}

// MARK: - Meal Plan Row

private struct MealPlanRow: View {
    let recipe: Recipe
    let accentColor: Color
    let onDelete: () -> Void

    @State private var isPressed = false

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(accentColor.opacity(0.10))
                Image(systemName: recipe.heroImage).font(.system(size: 15, weight: .medium)).foregroundColor(accentColor)
            }
            .frame(width: 42, height: 42)

            VStack(alignment: .leading, spacing: 3) {
                Text(recipe.title).font(.system(size: 14, weight: .semibold)).foregroundColor(.primary).lineLimit(1)
                HStack(spacing: 6) {
                    Label("\(recipe.preparationTime + recipe.cookingTime)m", systemImage: "clock")
                        .font(.system(size: 14)).foregroundColor(.secondary)
                    Text("·").foregroundColor(Color(.systemGray3)).font(.system(size: 14))
                    Text(recipe.difficulty).font(.system(size: 14)).foregroundColor(.secondary)
                    Text("·").foregroundColor(Color(.systemGray3)).font(.system(size: 14))
                    Text("\(recipe.nutrition.calories) kcal")
                        .font(.system(size: 14, weight: .medium)).foregroundColor(accentColor.opacity(0.8))
                }
            }
            Spacer(minLength: 0)
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill").font(.system(size: 19)).foregroundColor(Color(.systemGray3))
            }.buttonStyle(.plain)
        }
        .padding(.horizontal, 12).padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6).opacity(0.7)))
        .scaleEffect(isPressed ? 0.985 : 1.0)
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isPressed)
        .onLongPressGesture(minimumDuration: .infinity, pressing: { isPressed = $0 }, perform: {})
    }
}

// MARK: - Recipe Selector Sheet

struct MealPlanRecipeSelectorView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var db: LocalDatabaseManager
    @EnvironmentObject var modeManager: HealthModeManager

    let date: Date
    let mealType: String
    var source: String = "regular"

    private var slot: MealSlot { MealSlot(rawValue: mealType) ?? .breakfast }

    var availableRecipes: [Recipe] {
        modeManager.recipes(for: slot, from: db.recipes)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Select Recipe").font(.system(size: 20, weight: .bold)).foregroundColor(.primary)
                        Text("for \(slot.displayName)").font(.system(size: 14)).foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16).background(Color(.systemGray6))

                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 12) {
                            ForEach(availableRecipes) { recipe in
                                Button(action: {
                                    db.addMealPlan(recipe.id, date: date, meal: mealType, source: source)
                                    dismiss()
                                }) {
                                    HStack(spacing: 12) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6))
                                            Image(systemName: recipe.heroImage).font(.system(size: 20)).foregroundColor(.gray)
                                        }
                                        .frame(width: 60, height: 60)

                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(recipe.title).font(.system(size: 15, weight: .semibold)).foregroundColor(.primary).lineLimit(2)
                                            HStack(spacing: 12) {
                                                Label("\(recipe.preparationTime + recipe.cookingTime)m", systemImage: "clock.fill")
                                                    .font(.system(size: 14)).foregroundColor(.secondary)
                                                Label(recipe.diet, systemImage: "leaf.fill")
                                                    .font(.system(size: 14)).foregroundColor(.secondary)
                                            }
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right").font(.system(size: 14, weight: .semibold)).foregroundColor(.secondary)
                                    }
                                    .padding(12).background(Color(.systemGray6)).cornerRadius(10)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(16)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }.foregroundColor(.blue)
                }
            }
        }
    }
}

// MARK: - Nutrition Pill

struct NutritionInfoPill: View {
    let label: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(label).font(.system(size: 14, weight: .medium)).foregroundColor(.secondary)
            Text(value).font(.system(size: 14, weight: .bold)).foregroundColor(color)
        }
        .frame(maxWidth: .infinity).padding(.vertical, 8)
        .background(color.opacity(0.1)).cornerRadius(8)
    }
}

// MARK: - Smart Plan: Profile Required Placeholder

/// Shown inside the meal content area when Smart mode is active
/// but the health profile for the current mode has not been completed.
/// Provides clear user feedback and a direct action to fill the profile.
private struct SmartPlanProfileRequiredView: View {
    let accentColor: Color
    let onTapSetup: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.text.rectangle")
                .font(.system(size: 52, weight: .light))
                .foregroundColor(accentColor.opacity(0.45))

            VStack(spacing: 8) {
                Text("Health Profile Required")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)

                Text("Update your health profile to enable Smart Planning.")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Button(action: onTapSetup) {
                HStack(spacing: 8) {
                    Image(systemName: "person.badge.plus")
                        .font(.system(size: 14, weight: .semibold))
                    Text("Set Up Health Profile")
                        .font(.system(size: 15, weight: .semibold))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: accentColor.opacity(0.30), radius: 8, x: 0, y: 4)
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity)
        .padding(32)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 12, x: 0, y: 4)
        )
        .padding(.horizontal, 16)
    }
}

#Preview {
    MealPlannerView()
        .environmentObject(LocalDatabaseManager())
        .environmentObject(HealthModeManager())
        .environmentObject(HealthProfileStore())
}
