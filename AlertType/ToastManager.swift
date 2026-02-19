//
//  ToastManager.swift
//  AlertType
//
//  Created by Mir Ohid Ali  on 19/02/26.
//


import SwiftUI
import Combine

final class ToastManager: ObservableObject {
    
    @Published var isShowing = false
    @Published var message = ""
    @Published var type: NotificationType = .success
    
    func show(type: NotificationType, message: String) {
        self.type = type
        self.message = message
        
        withAnimation(.spring()) {
            isShowing = true
        }
        
        // Haptic
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        // Auto dismiss
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeInOut) {
                self.isShowing = false
            }
        }
    }
}
