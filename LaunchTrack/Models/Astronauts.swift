//
//  Astronauts.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 12/10/25.
//

import Foundation

struct AstronautResponse: Codable {
    let results: [Astronaut]
}

struct Astronaut: Codable, Identifiable {
    let id: Int
    let name: String
    let status: CurrentStatus
    let agency: Agency
    let image: AstronautImage
    let date_of_birth: String?
    let date_of_death: String?
    let nationality: [Nationality]
    let bio: String?
    let flights_count: Int
    let time_in_space: String
    let age: Int
}

struct CurrentStatus: Codable {
    let name: String
}

struct Agency: Codable {
    let name: String?
    let abbrev: String
}

struct AstronautImage: Codable {
    let image_url: String?
}

struct Nationality: Codable {
    let name: String
}

// MARK: - Sample data for previews

extension Astronaut{
    static let sampleAstronaut = Astronaut(
        id: 1,
        name: "Neil Armstrong",
        status: CurrentStatus(name: "Active"),
        agency: Agency(name: "NASA", abbrev: "NASA"),
        image: AstronautImage(image_url: "https://thespacedevs-dev.nyc3.digitaloceanspaces.com/media/images/thomas2520pesquet_image_20200102120546.jpeg"),
        date_of_birth: "YYYY/MM/DD",
        date_of_death: "YYYY/MM/DD",
        nationality: [Nationality(name: "American")],
        bio:"Bio",
        flights_count: 12,
        time_in_space: "P396DT11H33M45S",
        age: 30
        )
}

