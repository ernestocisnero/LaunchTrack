//
//  LaunchTrackApp.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 11/20/25.
//

import SwiftUI

@main
struct LaunchTrackApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                LaunchListView()
            } else {
                OnboardingView()
            }
        }
    }
}

