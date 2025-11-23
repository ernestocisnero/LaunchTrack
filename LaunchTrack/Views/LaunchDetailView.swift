//
//  LaunchDetailView.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 11/20/25.
//

import SwiftUI

struct LaunchDetailView: View {
    let launch: Launch
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                AsyncImage(url: URL(string: launch.image ?? "")) { img in
                    img.resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                Text(launch.name)
                    .font(.title)
                    .bold()
                Divider()
                Text("\( Image(systemName:"calendar") ) \(formatDate(launch.net))")
                    .font(.subheadline)
                    .bold()
                
                if let pad = launch.pad {
                    Text("\(Image( systemName: "location.fill" )) \(pad.location?.name ?? pad.name ?? "Unknown")").font(.subheadline).bold()
                }
                
                Divider()
                
                Text("Mission")
                    .font(.title)
                    .bold()
                
                Text(launch.mission?.description ?? "No mission details.")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Launch Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func formatDate(_ iso: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: iso) {
            return date.formatted(date: .complete, time: .complete)
        }
        return iso
    }
}

#Preview {
    LaunchDetailView(launch: .sample)
}
