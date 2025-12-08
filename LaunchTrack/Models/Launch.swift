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
    let image: LaunchImage?
    let mission: Mission?
    let pad: Pad?
    let vid_urls: [VidURL]?
}

struct Mission: Codable {
    let name: String?
    let description: String?
    
    
}

struct Pad: Codable {
    let name: String?
    let location: Location?
    //let latitude: String?
    //let longitude: String?
}

struct VidURL: Codable {
    let source: String?
    let publisher: String?
    let title: String?
    let url: String?
}

struct Location: Codable {
    let name: String?
}

struct LaunchImage: Codable {
    let image_url: String?
}



// MARK: - Sample data for previews
extension Launch {
    static let sample = Launch(
        id: UUID().uuidString,
        name: "Falcon 9 • Starlink 50",
        net: "2025-12-01T14:30:00Z",
        image: LaunchImage(image_url: "https://www.nasa.gov/sites/default/files/thumbnails/image/nasa-logo-web-rgb.png"),
        mission: Mission(name: "Starlink", description: "Deployment of a batch of Starlink satellites to low Earth orbit."),
        pad: Pad(name: "LC-39A", location: Location(name: "Kennedy Space Center, FL")),
        vid_urls: [VidURL(
            source: "youtube.com",
            publisher: "Space Affairs",
            title: "Starlink Live",
            url: "https://www.youtube.com/watch?v=H5ABuDe5jag"
        )]
    )
}
