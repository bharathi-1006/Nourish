import SwiftUI

// MARK: - Recommended Plan View (MVVM Refactor — freeze-free)

struct RecommendedPlanView: View {
    @EnvironmentObject var db: LocalDatabaseManager
    @EnvironmentObject var modeManager: HealthModeManager
    @EnvironmentObject var profileStore: HealthProfileStore
    // ViewModel injected from MealPlannerView so state persists across sheet dismissals
    @ObservedObject var viewModel: MealPlannerViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var selectedDayIndex = 0
    @State private var showEditProfile = false

    private let dayNames     = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private let fullDayNames = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    private let mealSlots    = MealSlot.allCases.map { $0.rawValue }

    private var theme: HealthModeTheme { modeManager.theme }

    // Read-only accessors — no mutation inside body
    private var weekPlan: WeeklyPlan { viewModel.smartWeeklyPlan(for: modeManager.currentMode) }
    private var isLoading: Bool { viewModel.isGenerating }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()

                if isLoading && weekPlan.isEmpty {
                    loadingView
                } else if weekPlan.isEmpty {
                    emptyView
                } else {
                    planContent
                }

                // Translucent overlay when RE-generating over an existing plan
                if isLoading && !weekPlan.isEmpty {
                    generatingOverlay
                }
            }
            .navigationTitle("Recommended Plan")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") { dismiss() }
                        .foregroundColor(theme.primaryColor)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        triggerGeneration(force: true)
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(isLoading ? .secondary : theme.primaryColor)
                    }
                    .disabled(isLoading)
                }
            }
            .sheet(isPresented: $showEditProfile, onDismiss: {
                // Profile changed → invalidate + force-regenerate
                viewModel.invalidateSmartPlan(for: modeManager.currentMode)
                triggerGeneration(force: true)
            }) {
                HealthProfileView(mode: modeManager.currentMode)
                    .environmentObject(profileStore)
                    .environmentObject(modeManager)
            }
        }
        .onAppear {
            // Generate ONLY if not already cached (prevents loop on every appear)
            triggerGeneration(force: false)
        }
        // When generation finishes (isLoading flips to false), silently apply to planner
        .onChange(of: isLoading) { _, loading in
            if !loading { silentlyApplyToPlanner() }
        }
    }

    // MARK: - Loading / Empty

    private var loadingView: some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(1.5)
                .tint(theme.primaryColor)
            Text("Generating your personalised plan…")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.secondary)
        }
    }

    private var emptyView: some View {
        VStack(spacing: 16) {
            Image(systemName: "brain.head.profile")
                .font(.system(size: 48, weight: .light))
                .foregroundColor(theme.primaryColor.opacity(0.4))
            Text("No plan generated yet")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.primary)
            Button("Generate Plan") {
                triggerGeneration(force: true)
            }
            .foregroundColor(theme.primaryColor)
            .font(.system(size: 15, weight: .semibold))
        }
    }

    private var generatingOverlay: some View {
        ZStack {
            Color.black.opacity(0.18)
                .ignoresSafeArea()
            VStack(spacing: 12) {
                ProgressView()
                    .tint(.white)
                Text("Updating plan…")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
            }
            .padding(20)
            .background(Color.black.opacity(0.55))
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }

    // MARK: - Plan Content

    private var planContent: some View {
        VStack(spacing: 0) {
            profileBadge
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 8)

            daySelector
                .padding(.bottom, 8)

            ScrollView {
                VStack(spacing: 14) {
                    dayNutritionSummary
                    ForEach(mealSlots, id: \.self) { slot in
                        mealSlotCard(slot: slot)
                    }
                    Spacer().frame(height: 24)
                }
                .padding(.horizontal, 16)
                .padding(.top, 4)
            }
        }
    }

    private var profileBadge: some View {
        HStack(spacing: 10) {
            Image(systemName: "brain.head.profile")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(theme.primaryColor)
            Text("Based on your health profile")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(theme.primaryColor)
            Spacer()
            Button {
                showEditProfile = true
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "pencil")
                        .font(.system(size: 14))
                    Text("Edit")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundColor(.secondary)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color(.systemGray5))
                .clipShape(Capsule())
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(theme.primaryColor.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(theme.primaryColor.opacity(0.20), lineWidth: 1)
                )
        )
    }

    private var daySelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(0..<7, id: \.self) { idx in
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedDayIndex = idx
                        }
                    } label: {
                        VStack(spacing: 4) {
                            Text(dayNames[idx])
                                .font(.system(size: 14, weight: .semibold))
                            Text("\(idx + 1)")
                                .font(.system(size: 17, weight: .bold))
                        }
                        .foregroundColor(selectedDayIndex == idx ? .white : .primary)
                        .frame(width: 50, height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(selectedDayIndex == idx ? theme.primaryColor : Color(.systemGray6))
                        )
                        .shadow(
                            color: selectedDayIndex == idx ? theme.primaryColor.opacity(0.3) : .clear,
                            radius: 6, x: 0, y: 3
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }

    private var dayNutritionSummary: some View {
        let day = safeDay(at: selectedDayIndex)
        let totalCal = mealSlots.compactMap { day[$0]?.nutrition.calories }.reduce(0, +)

        return HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(fullDayNames[selectedDayIndex])
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.primary)
                Text("Recommended meals")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text("\(totalCal)")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(theme.primaryColor)
                Text("kcal / day")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }

    private func mealSlotCard(slot: String) -> some View {
        let day    = safeDay(at: selectedDayIndex)
        let recipe = day[slot]

        return VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 8) {
                Text(mealEmoji(slot))
                    .font(.system(size: 16))
                    .frame(width: 34, height: 34)
                    .background(theme.primaryColor.opacity(0.10))
                    .clipShape(RoundedRectangle(cornerRadius: 9))
                Text(slot.capitalized)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding(.horizontal, 14)
            .padding(.top, 14)
            .padding(.bottom, 8)

            if let recipe = recipe {
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(
                                    colors: [theme.primaryColor.opacity(0.85), theme.accentColor.opacity(0.6)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        Image(systemName: recipe.heroImage)
                            .font(.system(size: 16, weight: .medium))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white.opacity(0.9), .white.opacity(0.5))
                    }
                    .frame(width: 44, height: 44)

                    VStack(alignment: .leading, spacing: 3) {
                        Text(recipe.title)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.primary)
                            .lineLimit(2)
                        HStack(spacing: 6) {
                            Label("\(recipe.preparationTime + recipe.cookingTime)m", systemImage: "clock")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                            Text("·")
                                .foregroundColor(.secondary)
                                .font(.system(size: 14))
                            Text("\(recipe.nutrition.calories) kcal")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(theme.primaryColor.opacity(0.9))
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 14)
                .padding(.bottom, 14)
            } else {
                HStack {
                    Image(systemName: "fork.knife")
                        .font(.system(size: 18))
                        .foregroundColor(Color(.systemGray3))
                    Text("No recipe available")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color(.systemGray6).opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 14)
                .padding(.bottom, 14)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }

    // MARK: - Pure Helpers (no side effects)

    private func mealEmoji(_ slot: String) -> String {
        return MealSlot(rawValue: slot)?.icon ?? "🍴"
    }

    private func safeDay(at index: Int) -> [String: Recipe] {
        guard index < weekPlan.count else { return [:] }
        return weekPlan[index]
    }

    // MARK: - Actions (all logic separated from body)

    private func triggerGeneration(force: Bool) {
        let mode = modeManager.currentMode
        // GUARD: Never generate a smart plan without a completed health profile.
        // This prevents partial suggestions from appearing if the view is accessed
        // while the profile is still incomplete.
        guard profileStore.hasCompletedProfile(for: mode) else { return }
        let profile = profileStore.profile(for: mode) ?? HealthProfile()
        let recipes = db.recipes
        // generateSmartPlan is non-blocking (kicks off a Task internally)
        // ViewModel is @MainActor so this call is always safe from the View
        viewModel.generateSmartPlan(allRecipes: recipes, mode: mode, profile: profile, force: force)
    }

    // Auto-applies the week plan silently — called as soon as generation completes.
    // No user confirmation needed. Does not dismiss (user can still review).
    private func silentlyApplyToPlanner() {
        guard !weekPlan.isEmpty else { return }
        let calendar = Calendar.current
        let today    = calendar.startOfDay(for: Date())
        let weekday  = calendar.component(.weekday, from: today)
        let daysToMonday = weekday == 2 ? 0 : (weekday == 1 ? 1 : 9 - weekday)
        guard let startDate = calendar.date(byAdding: .day, value: daysToMonday, to: today) else { return }
        for (dayIdx, dayPlan) in weekPlan.enumerated() {
            guard let date = calendar.date(byAdding: .day, value: dayIdx, to: startDate) else { continue }
            for (slot, recipe) in dayPlan {
                db.addMealPlan(recipe.id, date: date, meal: slot, source: "smart")
            }
        }
    }
}

// MARK: - Preview

#Preview {
    RecommendedPlanView(viewModel: MealPlannerViewModel())
        .environmentObject(LocalDatabaseManager())
        .environmentObject(HealthModeManager())
        .environmentObject(HealthProfileStore())
}
