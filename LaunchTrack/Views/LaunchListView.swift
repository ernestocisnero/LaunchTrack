//
//  LaunchListView.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 11/20/25.
//

import SwiftUI
import Combine

struct LaunchListView: View {
    @StateObject private var vm = LaunchViewModel()
    @State private var now = Date()
    
    
    
    var body: some View {
        NavigationStack {
            Group {
                if vm.isLoading {
                    ProgressView("Loading launches…")
                } else {
                    List(vm.launches) { launch in
                        NavigationLink {
                            LaunchDetailView(launch: launch)
                        } label: {
                            HStack(spacing: 15) {
                                AsyncImage(url: URL(string: launch.image ?? "")) { img in
                                    img.resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    let timeremaining = timeRemainingString(to: launch.net, now: now)
                                    
                                    Text(launch.name)
                                        .font(.headline)
                                    Text(formatDate(launch.net))
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    HStack {
                                        Text(timeremaining)
                                            .font(.caption)
                                            .foregroundStyle(Color.black)
                                    }
                                    .padding(5)
                                    .background( RoundedRectangle(cornerRadius: 20).fill( timeremaining == "Launched" ? Color.green.opacity(0.2) : Color.blue.opacity(0.2)))
                                    
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Upcoming Launches")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: AboutView()){
                        Image(systemName: "info")
                    }
                    
                }
            }
            .task {
                await vm.loadLaunches()
            }
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                now = Date()
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

#Preview{
    LaunchListView()
}

