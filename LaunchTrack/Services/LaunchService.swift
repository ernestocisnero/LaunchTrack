//
//  LaunchService.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 11/20/25.
//

import Foundation
class LaunchService {
    private let url = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/upcoming/")!

    func fetchUpcomingLaunches() async throws -> [Launch] {
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(LaunchResponse.self, from: data)
        return response.results
    }
}

