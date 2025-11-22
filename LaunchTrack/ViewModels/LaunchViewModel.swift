//
//  LaunchViewModel.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 11/20/25.
//

import Foundation
import Combine

@MainActor
class LaunchViewModel: ObservableObject {
    @Published var launches: [Launch] = []
    @Published var isLoading = false
    
    private let service = LaunchService()
    
    func loadLaunches() async {
        isLoading = true
        do {
            launches = try await service.fetchUpcomingLaunches()
        } catch {
            print("Error fetching launches:", error)
        }
        isLoading = false
    }
}
