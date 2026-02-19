
import SwiftUI

struct ContentView: View {
    
    @StateObject private var alertManager = AlertManager()
    
    var body: some View {
        ZStack {
            // Main Content
            VStack(spacing: 40) {
                
                Text("Modern Alert UI")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    
                    AlertButton(title: "Success", color: .green, icon: "checkmark.circle.fill") {
                        alertManager.show(type: .success, message: "Transaction completed successfully!")
                    }
                    
                    AlertButton(title: "Error", color: .red, icon: "xmark.circle.fill") {
                        alertManager.show(type: .error, title: "Failed", message: "Network connection lost. Please try again.")
                    }
                    
                    AlertButton(title: "Warning", color: .orange, icon: "exclamationmark.triangle.fill") {
                        alertManager.show(type: .warning, message: "Your storage is almost full.")
                    }
                    
                    AlertButton(title: "Info", color: .blue, icon: "info.circle.fill") {
                        alertManager.show(type: .info, message: "New update available available v2.0.")
                    }
                    
                    AlertButton(title: "Celebrate", color: .purple, icon: "sparkles") {
                        alertManager.show(type: .celebration, title: "Level Up!", message: "You reached level 10!")
                    }
                }
                .padding()
                
                Spacer()
            }
            .blur(radius: alertManager.isShowing ? 5 : 0)
            .animation(.easeInOut, value: alertManager.isShowing)
            .disabled(alertManager.isShowing)
            
            // Alert Overlay
            ModernAlertView(manager: alertManager)
        }
    }
}

struct AlertButton: View {
    let title: String
    let color: Color
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.largeTitle)
                Text(title)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 24)
            .background(color.opacity(0.1))
            .foregroundColor(color)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(color.opacity(0.3), lineWidth: 1)
            )
        }
    }
}
