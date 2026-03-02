import SwiftUI

// MARK: - Health Mode Selector Button

struct HealthModeSelector: View {
    @EnvironmentObject var modeManager: HealthModeManager
    @EnvironmentObject var profileStore: HealthProfileStore
    @State private var showModeSheet = false

    var body: some View {
        Button(action: { showModeSheet = true }) {
            HStack(spacing: 6) {
                Image(systemName: modeManager.currentMode.icon)
                    .font(.system(size: 14, weight: .semibold))
                Text(modeManager.currentMode.displayName)
                    .font(.system(size: 14, weight: .semibold))
                Image(systemName: "chevron.down")
                    .font(.system(size: 14, weight: .bold))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 14).padding(.vertical, 9)
            .background(
                Capsule()
                    .fill(.white.opacity(0.22))
                    .overlay(Capsule().strokeBorder(.white.opacity(0.35), lineWidth: 1))
            )
        }
        .buttonStyle(ScaleButtonStyle())
        .sheet(isPresented: $showModeSheet) {
            HealthModePickerSheet()
                .environmentObject(modeManager)
                .environmentObject(profileStore)
        }
    }
}

// MARK: - Health Mode Picker Sheet

struct HealthModePickerSheet: View {
    @EnvironmentObject var modeManager: HealthModeManager
    @EnvironmentObject var profileStore: HealthProfileStore
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Hero header
                        ZStack(alignment: .bottomLeading) {
                            LinearGradient(
                                colors: [modeManager.theme.primaryColor, modeManager.theme.accentColor.opacity(0.8)],
                                startPoint: .topLeading, endPoint: .bottomTrailing
                            )
                            .frame(height: 160)
                            .overlay(LinearGradient(colors:[.white.opacity(0.08),.clear], startPoint:.top, endPoint:.bottom))

                            VStack(alignment: .leading, spacing: 6) {
                                Image(systemName: modeManager.currentMode.icon)
                                    .font(.system(size: 26, weight: .semibold))
                                    .foregroundColor(.white.opacity(0.85))
                                Text("Health Mode")
                                    .font(.system(size: 30, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                Text("Choose a mode tailored to your goals")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.white.opacity(0.82))
                            }
                            .padding(.horizontal, 24).padding(.bottom, 24)
                        }

                        VStack(spacing: 12) {
                            ForEach(HealthMode.allCases) { mode in
                                HealthModeCard(mode: mode, isSelected: modeManager.currentMode == mode) {
                                    withAnimation(.spring(response: 0.32, dampingFraction: 0.7)) {
                                        modeManager.currentMode = mode
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) { dismiss() }
                                }
                            }
                        }
                        .padding(.horizontal, 20).padding(.top, 24).padding(.bottom, 32)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                        .foregroundColor(modeManager.theme.primaryColor)
                        .font(.system(size: 17, weight: .semibold))
                }
            }
        }
    }
}

// MARK: - Health Mode Card

struct HealthModeCard: View {
    let mode: HealthMode
    let isSelected: Bool
    let action: () -> Void

    private var theme: HealthModeTheme { HealthModeTheme.theme(for: mode) }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                // Icon badge
                ZStack {
                    if isSelected {
                        Circle()
                            .fill(LinearGradient(colors:[theme.primaryColor, theme.accentColor], startPoint:.topLeading, endPoint:.bottomTrailing))
                            .frame(width: 54, height: 54)
                        Circle().fill(theme.primaryColor.opacity(0.28)).frame(width: 54, height: 54).blur(radius: 8)
                    } else {
                        Circle().fill(Color(.systemGray5)).frame(width: 54, height: 54)
                    }
                    Image(systemName: mode.icon)
                        .font(.system(size: 24, weight: .semibold))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            isSelected ? .white : theme.primaryColor,
                            isSelected ? .white.opacity(0.65) : theme.primaryColor.opacity(0.5)
                        )
                }
                .shadow(color: isSelected ? theme.primaryColor.opacity(0.35) : .clear, radius: 10, x: 0, y: 4)

                VStack(alignment: .leading, spacing: 4) {
                    Text(mode.displayName)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                    Text(mode.description)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(theme.primaryColor)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(isSelected
                        ? AnyShapeStyle(LinearGradient(colors:[theme.primaryColor.opacity(0.10),theme.primaryColor.opacity(0.04)], startPoint:.topLeading, endPoint:.bottomTrailing))
                        : AnyShapeStyle(Color(.systemBackground))
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .strokeBorder(isSelected ? theme.primaryColor.opacity(0.45) : Color(.systemGray5), lineWidth: isSelected ? 1.5 : 0.5)
            )
            .shadow(color: isSelected ? theme.primaryColor.opacity(0.18) : Color.black.opacity(0.04), radius: isSelected ? 14 : 4, x: 0, y: isSelected ? 5 : 2)
        }
        .buttonStyle(ModeCardButtonStyle())
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}



// MARK: - Health Mode Selector (Light Background variant)

struct HealthModeSelectorOnLight: View {
    @EnvironmentObject var modeManager: HealthModeManager
    @EnvironmentObject var profileStore: HealthProfileStore
    @State private var showModeSheet = false

    var body: some View {
        Button(action: { showModeSheet = true }) {
            HStack(spacing: 6) {
                Image(systemName: modeManager.currentMode.icon)
                    .font(.system(size: 14, weight: .semibold))
                Text(modeManager.currentMode.displayName)
                    .font(.system(size: 14, weight: .semibold))
                Image(systemName: "chevron.down")
                    .font(.system(size: 14, weight: .bold))
            }
            .foregroundColor(modeManager.theme.primaryColor)
            .padding(.horizontal, 14).padding(.vertical, 9)
            .background(
                Capsule()
                    .fill(modeManager.theme.primaryColor.opacity(0.12))
                    .overlay(Capsule().strokeBorder(modeManager.theme.primaryColor.opacity(0.4), lineWidth: 1.5))
            )
        }
        .buttonStyle(ScaleButtonStyle())
        .sheet(isPresented: $showModeSheet) {
            HealthModePickerSheet()
                .environmentObject(modeManager)
                .environmentObject(profileStore)
        }
    }
}
#Preview {
    HealthModeSelector()
        .environmentObject(HealthModeManager())
        .environmentObject(HealthProfileStore())
}
