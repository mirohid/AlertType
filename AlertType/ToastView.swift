//
//  ToastView.swift
//  AlertType
//
//  Created by Mir Ohid Ali  on 19/02/26.
//

import SwiftUI
struct ToastView: View {
    
    var type: NotificationType
    var message: String
    
    var body: some View {
        HStack(spacing: 12) {
            
            Image(systemName: type.icon)
                .font(.title2)
                .foregroundColor(.white)
            
            Text(message)
                .foregroundColor(.white)
                .font(.subheadline)
                .bold()
            
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(
                colors: [type.color, type.color.opacity(0.7)],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(16)
        .shadow(radius: 10)
        .padding(.horizontal)
        .transition(
            .move(edge: .top)
            .combined(with: .opacity)
        )
    }
}
