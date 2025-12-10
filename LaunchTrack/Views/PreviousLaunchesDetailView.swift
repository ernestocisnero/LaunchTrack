//
//  PreviousLaunchesDetailView.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 12/9/25.
//

import SwiftUI

struct PreviousLaunchesDetailView: View {
    let prevLaunch: Launch
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                AsyncImage(url: URL(string: prevLaunch.image?.image_url ?? "")) { img in
                    img.resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                HStack {
                    Text(prevLaunch.name)
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                }
                
                Divider()
                if let urls = prevLaunch.vid_urls, !urls.isEmpty{
                    LiveStreamButton(urlData: urls.first!, padName: prevLaunch.pad?.name ?? "", padLatitude: prevLaunch.pad?.latitude ?? 0.0, padLongitude: prevLaunch.pad?.longitude ?? 0.0)
                } else {
                    Text("No video available")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                
                Text("\(Image(systemName: "calendar")) \(formatDate(prevLaunch.net))")
                    .font(.subheadline)
                    .bold()
                
                if let pad = prevLaunch.pad {
                    Text("\(Image(systemName: "location.fill")) \(pad.location?.name ?? pad.name ?? "Unknown")")
                        .font(.subheadline)
                        .bold()
                }
                
                Divider()
                
                Text("Mission")
                    .font(.title)
                    .bold()
                
                Text(prevLaunch.mission?.description ?? "No mission details.")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Launch Details")
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
    PreviousLaunchesDetailView(prevLaunch: .sample)
}
