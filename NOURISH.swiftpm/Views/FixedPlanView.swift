import SwiftUI

// MARK: - Fixed Plan View
// ─────────────────────────────────────────────────────────────────────────────
// Allows the user to define a weekly recurring meal template.
// Data is stored in db.fixedPlan via LocalDatabaseManager.
// This view does NOT modify the live calendar — it only edits the template.
// ─────────────────────────────────────────────────────────────────────────────

struct FixedPlanView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var db: LocalDatabaseManager
    @EnvironmentObject var modeManager: HealthModeManager

    // Currently selected weekday tab
    @State private var selectedWeekday: FixedPlanWeekday = {
        // Default to today's weekday so the UI opens on the relevant day
        let wd = Calendar.current.component(.weekday, from: Date())
        return FixedPlanWeekday(rawValue: wd) ?? .monday
    }()

    // Controls the recipe picker sheet
    @State private var pickingSlot: FixedPlanMealSlot? = nil

    private var accentColor: Color { modeManager.theme.primaryColor }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()

                VStack(spacing: 0) {
                    // ── Weekday selector strip ─────────────────────────────────
                    WeekdayTabStrip(
                        selected: $selectedWeekday,
                        accentColor: accentColor,
                        hasEntriesFor: { wd in db.hasFixedPlan(for: wd.rawValue, mode: modeManager.currentMode.rawValue) }
                    )
                    .background(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.04), radius: 6, x: 0, y: 3)

                    // ── Meal slots for selected weekday ───────────────────────
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 14) {
                            // Contextual note
                            HStack(spacing: 8) {
                                Image(systemName: "info.circle.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(accentColor.opacity(0.7))
                                Text("This template is suggested each time you tap a day in the planner.")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 14)

                            ForEach(FixedPlanMealSlot.allCases) { slot in
                                FixedPlanSlotCard(
                                    weekday: selectedWeekday,
                                    slot: slot,
                                    accentColor: accentColor,
                                    onPick: { pickingSlot = slot }
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 24)
                        .animation(.easeInOut(duration: 0.2), value: selectedWeekday)
                    }
                    .id(selectedWeekday) // force refresh on tab change
                }
            }
            .navigationTitle("Fixed Plan")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                        .fontWeight(.semibold)
                        .foregroundColor(accentColor)
                }
            }
            // Recipe picker sheet — reuses existing selector pattern
            .sheet(item: $pickingSlot) { slot in
                FixedPlanRecipePickerView(
                    weekday: selectedWeekday,
                    slot: slot
                )
                .environmentObject(db)
                .environmentObject(modeManager)
            }
        }
    }
}

// MARK: - Weekday Tab Strip

private struct WeekdayTabStrip: View {
    @Binding var selected: FixedPlanWeekday
    let accentColor: Color
    let hasEntriesFor: (FixedPlanWeekday) -> Bool

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(FixedPlanWeekday.allCases) { wd in
                    WeekdayTab(
                        weekday: wd,
                        isSelected: selected == wd,
                        hasEntries: hasEntriesFor(wd),
                        accentColor: accentColor
                    ) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selected = wd
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
    }
}

private struct WeekdayTab: View {
    let weekday: FixedPlanWeekday
    let isSelected: Bool
    let hasEntries: Bool
    let accentColor: Color
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 5) {
                Text(weekday.shortName)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(isSelected ? .white : .secondary)
                Text(String(weekday.displayName.prefix(1)))
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(isSelected ? .white : (hasEntries ? accentColor : .primary))
                Circle()
                    .fill(isSelected
                          ? Color.white.opacity(0.7)
                          : accentColor.opacity(hasEntries ? 0.7 : 0))
                    .frame(width: 5, height: 5)
            }
            .frame(width: 50, height: 68)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(isSelected ? accentColor : Color(.systemGray6))
            )
            .shadow(color: isSelected ? accentColor.opacity(0.25) : .clear,
                    radius: 6, x: 0, y: 3)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Fixed Plan Slot Card

private struct FixedPlanSlotCard: View {
    @EnvironmentObject var db: LocalDatabaseManager
    @EnvironmentObject var modeManager: HealthModeManager

    let weekday: FixedPlanWeekday
    let slot: FixedPlanMealSlot
    let accentColor: Color
    let onPick: () -> Void

    // Looks up the current fixed entry for this weekday+slot AND current health mode
    private var entry: FixedPlanEntry? {
        db.fixedPlan.first {
            $0.weekday == weekday.rawValue &&
            $0.meal == slot.rawValue &&
            $0.mode == modeManager.currentMode.rawValue
        }
    }

    private var recipe: Recipe? {
        guard let e = entry else { return nil }
        return db.recipeIndex[e.recipeId]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header row
            HStack(spacing: 10) {
                Text(slot.icon)
                    .font(.system(size: 18))
                    .frame(width: 36, height: 36)
                    .background(accentColor.opacity(0.10))
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                Text(slot.displayName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)

                Spacer()

                // Add / Edit button
                Button(action: onPick) {
                    Image(systemName: recipe == nil ? "plus.circle.fill" : "pencil.circle.fill")
                        .font(.system(size: 22))
                        .foregroundColor(accentColor)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 14)
            .padding(.top, 14)
            .padding(.bottom, recipe == nil ? 0 : 10)

            if let recipe {
                // Filled slot — show recipe row with remove button
                FixedSlotRecipeRow(
                    recipe: recipe,
                    accentColor: accentColor,
                    onRemove: {
                        withAnimation(.easeOut(duration: 0.2)) {
                            db.removeFixedPlanEntry(weekday: weekday.rawValue, meal: slot.rawValue, mode: modeManager.currentMode.rawValue)
                        }
                    }
                )
                .padding(.horizontal, 14)
                .padding(.bottom, 14)
            } else {
                // Empty slot
                HStack(spacing: 8) {
                    Image(systemName: "plus")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(.systemGray3))
                    Text("Tap + to add a \(slot.displayName.lowercased()) recipe")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 52)
                .padding(.horizontal, 14)
                .background(Color(.systemGray6).opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 14)
                .padding(.bottom, 14)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 3)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .strokeBorder(Color(.systemGray5).opacity(0.5), lineWidth: 0.5)
        )
        .animation(.easeInOut(duration: 0.18), value: entry?.recipeId)
    }
}

// MARK: - Fixed Slot Recipe Row

private struct FixedSlotRecipeRow: View {
    let recipe: Recipe
    let accentColor: Color
    let onRemove: () -> Void

    @State private var isPressed = false

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(accentColor.opacity(0.10))
                Image(systemName: recipe.heroImage)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(accentColor)
            }
            .frame(width: 42, height: 42)

            VStack(alignment: .leading, spacing: 3) {
                Text(recipe.title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                HStack(spacing: 6) {
                    Label("\(recipe.preparationTime + recipe.cookingTime)m",
                          systemImage: "clock")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    Text("·")
                        .foregroundColor(Color(.systemGray3))
                        .font(.system(size: 14))
                    Text(recipe.difficulty)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    Text("·")
                        .foregroundColor(Color(.systemGray3))
                        .font(.system(size: 14))
                    Text("\(recipe.nutrition.calories) kcal")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(accentColor.opacity(0.8))
                }
            }

            Spacer(minLength: 0)

            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 19))
                    .foregroundColor(Color(.systemGray3))
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6).opacity(0.7))
        )
        .scaleEffect(isPressed ? 0.985 : 1.0)
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isPressed)
        .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
    }
}

// MARK: - Fixed Plan Recipe Picker View
// Uses the same visual pattern as MealPlanRecipeSelectorView

struct FixedPlanRecipePickerView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var db: LocalDatabaseManager
    @EnvironmentObject var modeManager: HealthModeManager

    let weekday: FixedPlanWeekday
    let slot: FixedPlanMealSlot

    private var accentColor: Color { modeManager.theme.primaryColor }

    // Filter by health mode and slot category via ModeContext — single source of truth.
    // FixedPlanMealSlot and MealSlot share the same rawValues so the cast is safe.
    private var availableRecipes: [Recipe] {
        let mealSlot = MealSlot(rawValue: slot.rawValue) ?? .breakfast
        return ModeContext.recipes(for: modeManager.currentMode, slot: mealSlot, from: db.recipes)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()

                VStack(spacing: 0) {
                    // Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Select Recipe")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.primary)
                        Text("for \(slot.displayName) · \(weekday.displayName)")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .background(Color(.systemGray6))

                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 12) {
                            ForEach(availableRecipes) { recipe in
                                Button {
                                    db.setFixedPlanEntry(
                                        weekday: weekday.rawValue,
                                        meal: slot.rawValue,
                                        recipeId: recipe.id,
                                        mode: modeManager.currentMode.rawValue
                                    )
                                    dismiss()
                                } label: {
                                    HStack(spacing: 12) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color(.systemGray6))
                                            Image(systemName: recipe.heroImage)
                                                .font(.system(size: 20))
                                                .foregroundColor(.gray)
                                        }
                                        .frame(width: 60, height: 60)

                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(recipe.title)
                                                .font(.system(size: 15, weight: .semibold))
                                                .foregroundColor(.primary)
                                                .lineLimit(2)
                                            HStack(spacing: 12) {
                                                Label(
                                                    "\(recipe.preparationTime + recipe.cookingTime)m",
                                                    systemImage: "clock.fill"
                                                )
                                                .font(.system(size: 14))
                                                .foregroundColor(.secondary)
                                                Label(recipe.diet, systemImage: "leaf.fill")
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
                                    .cornerRadius(10)
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
                    Button("Cancel") { dismiss() }
                        .foregroundColor(accentColor)
                }
            }
        }
    }
}

// FixedPlanMealSlot must conform to Identifiable for .sheet(item:) — already satisfied via enum.
// Extend to satisfy SwiftUI's sheet(item:) which requires Identifiable.
extension FixedPlanMealSlot: Hashable {}
