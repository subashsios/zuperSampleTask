//
//  extensionModel.swift
//  SubashzZuperTask
//
//  Created by Apple  on 12/07/25.
//

import SwiftUI

extension Priority {
    var color: Color {
        switch self {
        case .low: return .green
        case .medium: return .yellow
        case .high: return .orange
        case .critical: return .red
        }
    }
}


extension Service {
    var formattedDate: String {
        guard let date = ISO8601DateFormatter().date(from: scheduledDate) else { return "" }
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"

        if calendar.isDateInTomorrow(date) {
            return "Tomorrow, \(formatter.string(from: date))"
        } else if calendar.isDateInToday(date) {
            return "Today, \(formatter.string(from: date))"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday, \(formatter.string(from: date))"
        } else {
            formatter.dateFormat = "dd/MM/yyyy, h:mm a"
            return formatter.string(from: date)
        }
    }

    var formattedDay: String {
        guard let date = ISO8601DateFormatter().date(from: scheduledDate) else { return "Unknown Date" }
        let calendar = Calendar.current
        let formatter = DateFormatter()

        if calendar.isDateInTomorrow(date) {
            return "Tomorrow"
        } else if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: date)
        }
    }
}

