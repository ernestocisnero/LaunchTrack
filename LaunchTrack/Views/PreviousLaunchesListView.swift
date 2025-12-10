//
//  PreviousLaunchesListView.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 12/9/25.
//

import SwiftUI
import Combine

struct PreviousLaunchesListView: View {
    @StateObject private var vm = PreviousLaunchViewModel()
    @State private var now = Date()
    
    
    var body: some View {
        
        NavigationStack {
            Group {
                if vm.isLoadingPrevious {
                    ProgressView("Hold tight we're getting to the moon! 🌕 ")
                } else {
                    List(vm.Previouslaunches) { launch in
                        NavigationLink {
                            PreviousLaunchesDetailView(prevLaunch: launch)
                        } label: {
                            HStack(spacing: 15) {
                                //Launch Image
                                AsyncImage(url: URL(string: launch.image?.image_url ?? "")) { img in
                                    img.resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ZStack {
                                        Color(white: 0.15)
                                        ProgressView()
                                            .tint(.white.opacity(0.5))
                                    }
                                }
                                .frame(width: 70, height: 70)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                )
                                
                                //Launch Info
                                VStack(alignment: .leading, spacing: 4) {
                                    let timeremaining = timeRemainingString(to: launch.net, now: now)
                                    
                                    Text(launch.name)
                                        .font(.headline)
                                    Text(formatDate(launch.net))
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    HStack {
                                        VStack {
                                            Text(timeremaining)
                                                .font(.caption)
                                                .foregroundStyle(Color.black)
                                        }
                                        .padding(8)
                                        .background( RoundedRectangle(cornerRadius: 8).fill(Color.green.opacity(0.2)))
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Previous Launches")
            .task {
                await vm.loadLaunches()
            }
        }
        
        
    }
    
    func formatDate(_ iso: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: iso) {
            return date.formatted(date: .abbreviated, time: .shortened)
        }
        return iso
    }
}

#Preview {
    PreviousLaunchesListView()
}
