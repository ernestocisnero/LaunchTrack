//
//  Launch.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 11/20/25.
//

import Foundation

struct LaunchResponse: Codable {
    let results: [Launch]
}

struct Launch: Codable, Identifiable {
    let id: String
    let name: String
    let net: String
    let image: String?
    let mission: Mission?
    let pad: Pad?
}

struct Mission: Codable {
    let name: String?
    let description: String?
}

struct Pad: Codable {
    let name: String?
    let location: Location?
}

struct Location: Codable {
    let name: String?
}


// MARK: - Sample data for previews
extension Launch {
    static let sample = Launch(
        id: UUID().uuidString,
        name: "Falcon 9 • Starlink 50",
        net: "2025-12-01T14:30:00Z",
        image: "https://www.nasa.gov/sites/default/files/thumbnails/image/nasa-logo-web-rgb.png",
        mission: Mission(name: "Starlink", description: "Deployment of a batch of Starlink satellites to low Earth orbit."),
        pad: Pad(name: "LC-39A", location: Location(name: "Kennedy Space Center, FL"))
    )
}
