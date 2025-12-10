//
//  TestMenuView.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 12/9/25.
//

import SwiftUI

struct TopMenu: View {
    var body: some View {
        NavigationStack {
                    
                    Menu {
                        NavigationLink(destination: PreviousLaunchesListView()) {
                            HStack{
                                Text("Previous Launches")
                                Image(systemName: "airplayvideo")
                            }
                        }
                               
                        NavigationLink(destination: Astronauts()) {
                            HStack{
                                Text("Astronauts")
                                Image(systemName: "airplayvideo")
                            }
                        }
                        
                        NavigationLink(destination: AboutView()) {
                            HStack{
                                Text("About")
                                Image(systemName: "info.circle")
                            }
                        }
                                            
                    } label: {
                        Circle()
                            .fill(.gray.opacity(0.15))
                            .frame(width: 30, height: 30)
                            .overlay {
                                Image(systemName: "ellipsis")
                                    .font(.system(size: 13.0, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding()
                            }
                    }
                    
                }
    }
}

#Preview {
    TopMenu()
}
