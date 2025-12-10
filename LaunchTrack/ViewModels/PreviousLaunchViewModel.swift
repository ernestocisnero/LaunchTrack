//
//  PreviousLaunchViewModel.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 12/9/25.
//


import Foundation
import Combine

@MainActor
class PreviousLaunchViewModel: ObservableObject {
    @Published var Previouslaunches: [Launch] = []
    @Published var isLoadingPrevious = false
    
    private let service = PreviousLaunchesService()
    
    func loadLaunches() async {
        isLoadingPrevious = true
        do {
            Previouslaunches = try await service.fetchPreviousLaunches()
        } catch {
            print("Error fetching launches:", error)
        }
        isLoadingPrevious = false
    }
}
