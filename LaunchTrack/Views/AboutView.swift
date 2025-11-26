//
//  AboutView.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 11/22/25.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack{
            
            Image("about")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 150)
            
                Text("LaunchTrack")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
            
            Text("LaunchTrack displays upcomings space launches infromation.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 20)
            
            Link("Privacy Policy", destination: URL(string: "https://ernestocisnero.vercel.app")!)
                .font(.body)
                .foregroundColor(Color(red: 96 / 255.0, green: 89 / 255.0, blue: 227 / 255.0))
                .padding(.top, 20)
            
        }
    }
}

#Preview {
    AboutView()
}
