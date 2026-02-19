
import SwiftUI
import Combine

final class AlertManager: ObservableObject {
    
    @Published var isShowing = false
    @Published var message = ""
    @Published var title = ""
    @Published var type: NotificationType = .success
    
    // Animation triggers
    @Published var showConfetti = false
    @Published var showFireworks = false
    @Published var shake = false
    @Published var pulse = false
    
    private var timer: AnyCancellable?
    
    func show(type: NotificationType, title: String = "", message: String) {
        self.type = type
        self.message = message
        self.title = title.isEmpty ? type.defaultTitle : title
        
        // Reset previous states
        self.showConfetti = false
        self.showFireworks = false
        self.shake = false
        self.pulse = false
        
        withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
            self.isShowing = true
        }
        
        // Haptic Feedback
        switch type {
        case .success, .celebration:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        case .warning:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        case .info:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
        
        // Trigger specific animations
        triggerAnimation(for: type)
        
        // Auto dismiss
        timer?.cancel()
        timer = Just(())
            .delay(for: .seconds(3), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.dismiss()
            }
    }
    
    func dismiss() {
        withAnimation(.easeOut) {
            self.isShowing = false
            self.showConfetti = false
            self.showFireworks = false
        }
    }
    
    private func triggerAnimation(for type: NotificationType) {
        switch type {
        case .success:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.showConfetti = true
            }
        case .celebration:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.showFireworks = true
            }
        case .error:
            withAnimation(.default) {
                self.shake = true
            }
            // Reset shake after animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.shake = false
            }
        case .warning:
            withAnimation {
                self.pulse = true
            }
        default:
            break
        }
    }
}

extension NotificationType {
    var defaultTitle: String {
        switch self {
        case .success: return "Success"
        case .error: return "Error"
        case .warning: return "Warning"
        case .info: return "Info"
        case .celebration: return "Celebration"
        }
    }
}
