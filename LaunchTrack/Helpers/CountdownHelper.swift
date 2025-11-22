//
//  CountdownHelper.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 11/20/25.
//

import Foundation

/// Format the difference between now and an ISO date into a string T–HH:MM:SS
func timeRemainingString(to isoDate: String, now: Date) -> String {
    let formatter = ISO8601DateFormatter()
    
    // From ISO to Date
    guard let targetDate = formatter.date(from: isoDate) else {
        return "T–Unknown"
    }
    
    let now = Date()
    let diff = targetDate.timeIntervalSince(now)
    
    // Date is due
    if diff <= 0 {
        return "Launched"
    }
    
    
    let hours = Int(diff) / 3600
    let minutes = (Int(diff) % 3600) / 60
    let seconds = Int(diff) % 60
    
    // Format T–03:12:55
    return String(format: "T–%02d:%02d:%02d", hours, minutes, seconds)
}
