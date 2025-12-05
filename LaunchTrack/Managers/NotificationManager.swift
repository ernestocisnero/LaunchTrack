//
//  NotificationManager.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 12/4/25.
//

import UserNotifications
import Foundation

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    // Request notification permission from user
    func requestPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Permission error: \(error.localizedDescription)")
                }
                completion(granted)
            }
        }
    }
    
    // Schedule notification for a launch
    func scheduleNotification(for launch: Launch, minutesBefore: Int) {
        // Convert ISO8601 string to Date
        guard let launchDate = ISO8601DateFormatter().date(from: launch.net) else {
            print("Failed to parse launch date")
            return
        }
        
        // Check if launch hasn't already happened
        guard launchDate > Date() else {
            print("Launch date is in the past")
            return
        }
        
        // Calculate notification time
        let notificationDate = launchDate.addingTimeInterval(-Double(minutesBefore * 60))
        
        // Don't schedule if notification time is in the past
        guard notificationDate > Date() else {
            print("Notification time would be in the past")
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = "🚀 Launch Alert"
        content.body = "\(launch.name) launching in \(minutesBefore) minutes!"
        content.sound = .default
        content.badge = 1
        
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let identifier = "launch-\(launch.id)-\(minutesBefore)"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("✓ Notification scheduled for \(launch.name) - \(minutesBefore) min before")
            }
        }
    }
    
    // Cancel specific notification
    func cancelNotification(for launch: Launch, minutesBefore: Int) {
        let identifier = "launch-\(launch.id)-\(minutesBefore)"
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        print("✗ Notification cancelled for \(launch.name) - \(minutesBefore) min")
    }
    
    // Cancel all notifications for a launch
    func cancelAllNotifications(for launch: Launch) {
        let identifiers = [5, 10, 15, 30].map { "launch-\(launch.id)-\($0)" }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    // Check if notification permission is granted
    func checkPermissionStatus(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus == .authorized)
            }
        }
    }

}
