import SwiftUI

// MARK: - RootView

struct RootView: View {
    @EnvironmentObject var db: LocalDatabaseManager
    @State private var splashFinished = false

    var body: some View {
        ZStack {
            if splashFinished {
                ContentView()
                    .environmentObject(db)
                    .transition(.opacity)
            } else {
                SplashScreenView(onFinished: {
                    withAnimation(.easeInOut(duration: 0.6)) { splashFinished = true }
                })
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.6), value: splashFinished)
    }
}

// MARK: - SplashScreenView

struct SplashScreenView: View {
    let onFinished: () -> Void

    @State private var logoScale:    CGFloat = 0.6
    @State private var logoOpacity:  Double  = 0
    @State private var logoBlur:     Double  = 8
    @State private var ringScale:    CGFloat = 0.4
    @State private var ringOpacity:  Double  = 0
    @State private var lettersShown: Int     = 0
    @State private var taglineOpacity: Double = 0

    private let appName  = Array("Nourish")
    private let orange   = Color(red: 0.97, green: 0.45, blue: 0.15)
    private let orange2  = Color(red: 0.92, green: 0.32, blue: 0.08)

    var body: some View {
        ZStack {
            // Rich layered background
            LinearGradient(
                colors: [orange, orange2],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Warm radial bloom
            RadialGradient(
                colors: [.white.opacity(0.14), .clear],
                center: .center, startRadius: 0, endRadius: 320
            )
            .ignoresSafeArea()

            // Top shimmer
            LinearGradient(
                colors: [.white.opacity(0.06), .clear],
                startPoint: .top, endPoint: .center
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()

                // Logo: layered rings + icon
                ZStack {
                    // Outer pulse ring
                    Circle()
                        .fill(.white.opacity(0.07))
                        .frame(width: 160, height: 160)
                        .scaleEffect(ringScale)
                        .opacity(ringOpacity)

                    // Inner glow ring
                    Circle()
                        .fill(.white.opacity(0.12))
                        .frame(width: 120, height: 120)
                        .blur(radius: 14)

                    Image(systemName: "fork.knife.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 106, height: 106)
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.2), radius: 18, x: 0, y: 10)
                        .shadow(color: orange.opacity(0.5), radius: 28, x: 0, y: 4)
                }
                .scaleEffect(logoScale)
                .opacity(logoOpacity)
                .blur(radius: logoBlur)

                // Letter-by-letter name
                HStack(spacing: 1) {
                    ForEach(Array(appName.enumerated()), id: \.offset) { index, letter in
                        Text(String(letter))
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 2)
                            .opacity(index < lettersShown ? 1 : 0)
                            .offset(y: index < lettersShown ? 0 : 14)
                            .animation(
                                .spring(response: 0.36, dampingFraction: 0.7)
                                    .delay(Double(index) * 0.07),
                                value: lettersShown
                            )
                    }
                }

                // Tagline
                Text("Eat well, live better")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white.opacity(0.78))
                    .opacity(taglineOpacity)

                Spacer()
            }
        }
        .onAppear { startSequence() }
    }

    private func startSequence() {
        // Logo bloom in
        withAnimation(.spring(response: 0.65, dampingFraction: 0.75).delay(0.15)) {
            logoScale = 1; logoOpacity = 1; logoBlur = 0
            ringScale = 1.2; ringOpacity = 1
        }
        // Letters cascade
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            lettersShown = appName.count
        }
        // Tagline
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            withAnimation(.easeIn(duration: 0.5)) { taglineOpacity = 1 }
        }
        // Exit
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { onFinished() }
    }
}

#Preview("Splash") { SplashScreenView(onFinished: {}) }
#Preview("Root") { RootView().environmentObject(LocalDatabaseManager()) }
