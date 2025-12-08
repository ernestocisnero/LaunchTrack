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
                                            .background( RoundedRectangle(cornerRadius: 8).fill( timeremaining == "Launched" ? Color.green.opacity(0.2) : Color.blue.opacity(0.2)))
                                        }
                                        
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

        //Prod UnitID: ca-app-pub-4315973313313037/4851585583
        //Dev UnitID: ca-app-pub-3940256099942544/2934735716
        BannerAd(adUnitID: "ca-app-pub-3940256099942544/2934735716" )
            .frame(height: 50)
            .background(Color.clear)
        
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


