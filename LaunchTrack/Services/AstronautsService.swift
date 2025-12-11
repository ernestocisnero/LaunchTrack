//
//  AstronautsService.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 12/10/25.
//

import Foundation

class AstronautsService {
    private let url = URL(string: "https://ll.thespacedevs.com/2.3.0/astronauts/?mode=detailed")!

    func fetchAstronauts() async throws -> [Astronaut] {
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(AstronautResponse.self, from: data)
        return response.results
    }
}
