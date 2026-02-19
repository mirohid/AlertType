//
//  NotificationType.swift
//  AlertType
//
//  Created by Mir Ohid Ali  on 19/02/26.
//


import SwiftUI

enum NotificationType {
    case success, error, warning, info, celebration
    
    var color: Color {
        switch self {
        case .success: return Color.green
        case .error: return Color.red
        case .warning: return Color.orange
        case .info: return Color.blue
        case .celebration: return Color.purple
        }
    }
    
    var icon: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .info: return "info.circle.fill"
        case .celebration: return "sparkles"
        }
    }
}
