//
//  LiveStreamButton.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 12/6/25.
//

import SwiftUI

struct LiveStreamButton: View {
    @State private var showPulse: Bool = false
    var body: some View {
        
        NavigationStack{
            NavigationLink(destination: LiveStreamView()) {
                HStack{
                    Circle()
                        .fill(Color.white)
                        .frame(width: 10, height: 10)
                        .scaleEffect(showPulse ? 1.2 : 0.8)
                        .animation(
                            .easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                            value: showPulse
                        ).onAppear{ showPulse = true }
                    
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
    LiveStreamButton()
}

   


