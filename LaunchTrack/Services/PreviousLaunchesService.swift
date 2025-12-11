//
//  PreviousLaunchesService.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 12/9/25.
//



import Foundation

class PreviousLaunchesService {
    private let url = URL(string: "https://ll.thespacedevs.com/2.3.0/launches/previous/?mode=detailed")!

    func fetchPreviousLaunches() async throws -> [Launch] {
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(LaunchResponse.self, from: data)
        return response.results
    }
}
