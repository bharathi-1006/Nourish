import SwiftUI

// MARK: - Fixed Plan Suggestion Card
// Presented from ContentView (above TabView) so it overlays the tab bar correctly.

struct FixedPlanSuggestionCard: View {
    @EnvironmentObject var db: LocalDatabaseManager
    @EnvironmentObject var modeManager: HealthModeManager

    let date: Date
    let weekday: Int
    let onDismiss: () -> Void
    let onApplied: () -> Void

    @State private var dragOffset: CGFloat = 0
    @State private var isApplied = false

    private var accentColor: Color { modeManager.theme.primaryColor }
    private let mealOrder: [FixedPlanMealSlot] = FixedPlanMealSlot.allCases

    private var entries: [FixedPlanEntry] {
        db.fixedPlanEntries(for: weekday, mode: modeManager.currentMode.rawValue)
            .sorted { lhs, rhs in
                let li = mealOrder.firstIndex(where: { $0.rawValue == lhs.meal }) ?? 99
                let ri = mealOrder.firstIndex(where: { $0.rawValue == rhs.meal }) ?? 99
                return li < ri
            }
    }

    private var weekdayName: String {
        FixedPlanWeekday(rawValue: weekday)?.displayName ?? "Today"
    }

    private var dateLabel: String {
        FixedPlanSuggestionCard.dateLabelFormatter.string(from: date)
    }
    private static let dateLabelFormatter: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "MMMM d"; return f
    }()

    var body: some View {
        // Full-screen VStack: scrim on top, card pinned to bottom.
        // Presented from ContentView (above TabView) so tab bar is covered.
        VStack(spacing: 0) {

            // ── Scrim ──────────────────────────────────────────────────────
            Color.black.opacity(0.28)
                .ignoresSafeArea()
                .onTapGesture { dismiss() }

            // ── Card ───────────────────────────────────────────────────────
            VStack(spacing: 0) {

                // Drag handle
                Capsule()
                    .fill(Color(.systemGray4))
                    .frame(width: 36, height: 4)
                    .padding(.top, 10)
                    .padding(.bottom, 16)

                // Header
                HStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .fill(accentColor.opacity(0.12))
                            .frame(width: 40, height: 40)
                        Image(systemName: "calendar.badge.clock")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(accentColor)
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Fixed Plan · \(weekdayName)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.primary)
                        Text("Suggested meals for \(dateLabel)")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Button(action: dismiss) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 22))
                            .foregroundColor(Color(.systemGray3))
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 14)

                Divider()
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)

                // Meal list
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(entries) { entry in
                            if let recipe = db.recipeIndex[entry.recipeId],
                               let slot = FixedPlanMealSlot(rawValue: entry.meal) {
                                SuggestionMealRow(
                                    recipe: recipe,
                                    slot: slot,
                                    accentColor: accentColor,
                                    isDuplicate: isDuplicate(entry: entry)
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .frame(maxHeight: 280)

                // Duplicate hint
                if hasDuplicates {
                    HStack(spacing: 5) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                        Text("Greyed items already exist on this date and won't be duplicated.")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                }

                // ── Action buttons ─────────────────────────────────────────
                HStack(spacing: 12) {
                    Button(action: dismiss) {
                        Text("Ignore")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color(.systemGray5))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .buttonStyle(.plain)

                    Button(action: applyPlan) {
                        HStack(spacing: 6) {
                            if isApplied {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 14, weight: .bold))
                                Text("Applied!")
                                    .font(.system(size: 15, weight: .semibold))
                            } else {
                                Image(systemName: "arrow.down.circle.fill")
                                    .font(.system(size: 14, weight: .semibold))
                                Text("Apply")
                                    .font(.system(size: 15, weight: .semibold))
                            }
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            isApplied
                                ? Color(red: 0.20, green: 0.78, blue: 0.35)
                                : accentColor,
                            in: RoundedRectangle(cornerRadius: 14)
                        )
                        .shadow(color: accentColor.opacity(isApplied ? 0 : 0.25),
                                radius: 5, x: 0, y: 2)
                    }
                    .buttonStyle(.plain)
                    .disabled(isApplied)
                    .animation(.easeInOut(duration: 0.2), value: isApplied)
                }
                .padding(.horizontal, 20)
                .padding(.top, 14)
                .padding(.bottom, 16)
            }
            // Card background extends below rounded corners to fill screen edge
            .background(
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.12), radius: 24, x: 0, y: -6)
                    .padding(.bottom, -50)
            )
            // Push card bottom padding below home indicator
            .ignoresSafeArea(edges: .bottom)
        }
        .offset(y: max(0, dragOffset))
        .gesture(
            DragGesture()
                .onChanged { value in dragOffset = value.translation.height }
                .onEnded { value in
                    if value.translation.height > 80 {
                        dismiss()
                    } else {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                            dragOffset = 0
                        }
                    }
                }
        )
    }

    private func isDuplicate(entry: FixedPlanEntry) -> Bool {
        // Only count as duplicate if already in the "fixed" source for this date
        db.getMealPlanForDate(date, source: "fixed").contains {
            $0.meal == entry.meal && $0.recipeId == entry.recipeId
        }
    }

    private var hasDuplicates: Bool {
        entries.contains { isDuplicate(entry: $0) }
    }

    private func applyPlan() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { isApplied = true }
        db.applyFixedPlan(for: weekday, to: date, mode: modeManager.currentMode.rawValue)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { onApplied() }
    }

    private func dismiss() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.78)) { onDismiss() }
    }
}

// MARK: - Suggestion Meal Row

private struct SuggestionMealRow: View {
    let recipe: Recipe
    let slot: FixedPlanMealSlot
    let accentColor: Color
    let isDuplicate: Bool

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(accentColor.opacity(isDuplicate ? 0.05 : 0.12))
                Image(systemName: recipe.heroImage)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(isDuplicate ? Color(.systemGray3) : accentColor)
            }
            .frame(width: 40, height: 40)

            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 4) {
                    Text(slot.icon).font(.system(size: 14))
                    Text(slot.displayName)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(isDuplicate ? .secondary : accentColor)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(isDuplicate ? Color(.systemGray4) : accentColor.opacity(0.12))
                        .clipShape(Capsule())
                    if isDuplicate {
                        Text("Already added")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.secondary)
                    }
                }
                Text(recipe.title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(isDuplicate ? .secondary : .primary)
                    .lineLimit(1)
                HStack(spacing: 4) {
                    Text("\(recipe.preparationTime + recipe.cookingTime)m")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    Text("·").foregroundColor(Color(.systemGray4)).font(.system(size: 14))
                    Text("\(recipe.nutrition.calories) kcal")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(isDuplicate ? .secondary : accentColor.opacity(0.8))
                }
            }

            Spacer(minLength: 0)

            if isDuplicate {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 16))
                    .foregroundColor(Color(.systemGray3))
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isDuplicate
                      ? Color(.systemGray6).opacity(0.4)
                      : Color(.systemGray6).opacity(0.7))
        )
        .opacity(isDuplicate ? 0.65 : 1.0)
    }
}
