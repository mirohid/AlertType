
import SwiftUI

struct PulseEffect: ViewModifier {
    @State private var isPulsing = false
    var color: Color = .blue
    
    func body(content: Content) -> some View {
        content
            .shadow(color: isPulsing ? color.opacity(0.8) : color.opacity(0.0), radius: isPulsing ? 20 : 0)
            .scaleEffect(isPulsing ? 1.05 : 1.0)
            .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isPulsing)
            .onAppear {
                isPulsing = true
            }
    }
}
