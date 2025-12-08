//
//  LaunchDetailView.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 11/20/25.
//

import SwiftUI

struct LaunchDetailView: View {
    let launch: Launch
    @State private var pickTime: Bool = false
    @State private var selectedMinutes: Set<Int> = []
    @State private var showPermissionAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                AsyncImage(url: URL(string: launch.image?.image_url ?? "")) { img in
                    img.resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                HStack {
                    Text(launch.name)
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    // Notification Button
                    Button {
                        requestNotificationPermission()
                    } label: {
                        Image(systemName: selectedMinutes.isEmpty ? "bell" : "bell.fill")
                            .foregroundStyle(selectedMinutes.isEmpty ? Color.gray : Color.blue)
                            .font(.title2)
                    }
                    
                }
            
                Divider()
                if let urls = launch.vid_urls, !urls.isEmpty{
                    LiveStreamButton(urls: urls.first!.url ?? "")
                } else {
                    Text("No video available")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
               
                
                Text("\(Image(systemName: "calendar")) \(formatDate(launch.net))")
                    .font(.subheadline)
                    .bold()
                
                if let pad = launch.pad {
                    Text("\(Image(systemName: "location.fill")) \(pad.location?.name ?? pad.name ?? "Unknown")")
                        .font(.subheadline)
                        .bold()
                }
                
                Divider()
                
                Text("Mission")
                    .font(.title)
                    .bold()
                
                Text(launch.mission?.description ?? "No mission details.")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Launch Details")
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog("Set Launch Notifications", isPresented: $pickTime) {
            Button(selectedMinutes.contains(30) ? "✓ 30 minutes before" : "30 minutes before") {
                toggleNotification(minutes: 30)
            }
            Button(selectedMinutes.contains(15) ? "✓ 15 minutes before" : "15 minutes before") {
                toggleNotification(minutes: 15)
            }
            Button(selectedMinutes.contains(10) ? "✓ 10 minutes before" : "10 minutes before") {
                toggleNotification(minutes: 10)
            }
            Button(selectedMinutes.contains(5) ? "✓ 5 minutes before" : "5 minutes before") {
                toggleNotification(minutes: 5)
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Choose when to be notified about this launch")
        }
        .alert("Notifications Disabled", isPresented: $showPermissionAlert) {
            Button("Open Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Please enable notifications in Settings to receive launch alerts.")
        }
        .onAppear {
            loadSavedNotifications()
        }
    }
    
    // MARK: - Notification Functions
    
    func requestNotificationPermission() {
        print("Bell tapped!") // Debug
            
            NotificationManager.shared.requestPermission { granted in
                print("Permission granted: \(granted)") // Debug
                
                if granted {
                    self.pickTime = true
                } else {
                    self.showPermissionAlert = true
                }
            }
    }
    
    func toggleNotification(minutes: Int) {
        if selectedMinutes.contains(minutes) {
            // Remove notification
            selectedMinutes.remove(minutes)
            NotificationManager.shared.cancelNotification(for: launch, minutesBefore: minutes)
        } else {
            // Add notification
            selectedMinutes.insert(minutes)
            NotificationManager.shared.scheduleNotification(for: launch, minutesBefore: minutes)
        }
        saveNotificationPreferences()
    }
    
    // MARK: - Persistence Functions
    
    func saveNotificationPreferences() {
        let key = "notifications-\(launch.id)"
        UserDefaults.standard.set(Array(selectedMinutes), forKey: key)
    }
    
    func loadSavedNotifications() {
        let key = "notifications-\(launch.id)"
        if let saved = UserDefaults.standard.array(forKey: key) as? [Int] {
            selectedMinutes = Set(saved)
        }
    }
    
    // MARK: - Helper Functions
    
    func formatDate(_ iso: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: iso) {
            return date.formatted(date: .complete, time: .complete)
        }
        return iso
    }
}

#Preview {
    LaunchDetailView(launch: .sample)
}
