//
//  AstronautsViewModel.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 12/10/25.
//



import Foundation
import Combine

@MainActor
class AstronautsViewModel: ObservableObject {
    @Published var astronauts: [Astronaut] = []
    @Published var isLoadingAstronauts = false
    
    private let service = AstronautsService()
    
    func loadAstronauts() async {
        isLoadingAstronauts = true
        do {
            astronauts = try await service.fetchAstronauts()
            
        } catch {
            print("Error fetching Astronauts Data:", error)
        }
        isLoadingAstronauts = false
    }
}
