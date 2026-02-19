
import SwiftUI

struct ModernAlertView: View {
    
    @ObservedObject var manager: AlertManager
    
    var body: some View {
        ZStack {
            // Particle Effects Layer
            if manager.showConfetti {
                ConfettiView()
                    .allowsHitTesting(false)
                    .transition(.opacity)
            }
            
            if manager.showFireworks {
                FireworksView()
                    .allowsHitTesting(false)
                    .transition(.opacity)
            }
            
            // Alert Card
            if manager.isShowing {
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        Image(systemName: manager.type.icon)
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundColor(manager.type.color)
                            .padding(12)
                            .background(
                                Circle()
                                    .fill(manager.type.color.opacity(0.2))
                            )
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(manager.title)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text(manager.message)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                }
                .padding(20)
                .background(
                    VisualEffectBlur(blurStyle: .systemMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .stroke(Color.white.opacity(0.5), lineWidth: 1)
                        )
                )
                .padding(.horizontal, 24)
                .offset(y: manager.isShowing ? 0 : -100)
                .modifier(ShakeEffect(animatableData: manager.shake ? 1 : 0))
                .modifier(PulseEffect(color: manager.type.color)) // Apply pulse regardless, logic inside controls it
                .onTapGesture {
                    manager.dismiss()
                }
                .transition(.move(edge: .top).combined(with: .opacity))
                .zIndex(1) // Ensure alert is above confetti if needed, though usually confetti is background or overlay
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 60) // Adjust for dynamic island / notch
        .animation(.spring(), value: manager.isShowing)
    }
}

// Helper for Glassmorphism
struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: blurStyle)
    }
}
