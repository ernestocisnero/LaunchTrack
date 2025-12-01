//
//  LaunchTrackApp.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 11/20/25.
//

import SwiftUI
import GoogleMobileAds
@main
struct LaunchTrackApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    init(){
        MobileAds.shared.start()
        MobileAds.shared.requestConfiguration.testDeviceIdentifiers = [ "e52cf4ac44dd962186055c646a8f51d5" ]
    }

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

