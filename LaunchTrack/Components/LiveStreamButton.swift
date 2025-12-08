//
//  LiveStreamButton.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 12/6/25.
//

import SwiftUI

struct LiveStreamButton: View {
    let urlData: VidURL
    let padName: String?
    let padLatitude: Double
    let padLongitude: Double
    
    @State private var showPulse: Bool = false

    
    var body: some View {
        
        NavigationStack{
            NavigationLink(destination: LiveStreamView(name:padName, title: urlData.title, streamURL: urlData.url ?? "", padLatitude: padLatitude, padLongitude: padLongitude )) {
                HStack{
                   PulsingDot()
                    Text("Watch Launch")
                    Image(systemName: "airplayvideo")
                }
                .font(.subheadline)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .foregroundStyle(Color.white)
                .background( RoundedRectangle(cornerRadius: 8).fill(Color.red.opacity(0.8)))
            }

        }
        
    }
}

#Preview {
    LiveStreamButton(
        urlData: VidURL(
        title: "Starlink Live",
        url: "https://www.youtube.com/watch?v=H5ABuDe5jag"
        ),
        padName: "",
        padLatitude: 0.0,
        padLongitude: 0.0
    )
}

   


