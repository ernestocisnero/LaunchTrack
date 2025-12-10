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
                            .font(.subheadline)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .foregroundStyle(Color.white)
                            .background( RoundedRectangle(cornerRadius: 8).fill(Color.red.opacity(0.8)))
                        }
                               
                        NavigationLink(destination: Astronauts()) {
                            HStack{
                                Text("Astronauts")
                                Image(systemName: "airplayvideo")
                            }
                            .font(.subheadline)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .foregroundStyle(Color.white)
                            .background( RoundedRectangle(cornerRadius: 8).fill(Color.red.opacity(0.8)))
                        }
                        
                        NavigationLink(destination: AboutView()) {
                            HStack{
                                Text("About")
                                Image(systemName: "info.circle")
                            }
                            .font(.subheadline)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .foregroundStyle(Color.white)
                            .background( RoundedRectangle(cornerRadius: 8).fill(Color.red.opacity(0.8)))
                        }
                                            
                    } label: {
                        Circle()
                            .fill(.gray.opacity(0.15))
                            .frame(width: 30, height: 30)
                            .overlay {
                                Image(systemName: "ellipsis")
                                    .font(.system(size: 13.0, weight: .semibold))
                                    .foregroundColor(.pink)
                                    .padding()
                            }
                    }
                    
                }
    }
}

#Preview {
    TopMenu()
}
