//
//  AstronautCard.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 12/10/25.
//

import SwiftUI

struct AstronautCard: View {
    @State private var showDetails: Bool = false
    let astronaut: Astronaut
    

    var body: some View {
        VStack{
            HStack(alignment: .top, spacing:16){
                HStack{
                    AsyncImage(url: URL(string: astronaut.image.image_url ?? "")) { img in
                        if let image = img.image {
                            image.resizable().scaledToFill()
                        } else if img.error != nil {
                            Color.gray.opacity(0.3)
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(width: 100, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay( RoundedRectangle(cornerRadius: 14).stroke(Color.white.opacity(0.1), lineWidth: 1))
                }
                .padding(12)
  
                VStack(alignment: .leading){
                    Text(astronaut.name)
                        .font(.title2)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        Image(systemName: "flag")
                        Text(astronaut.nationality.first?.name ?? "Unknown").font(.headline).foregroundStyle(.secondary)
                    }
                    Text(astronaut.agency.name ?? "Unknown Agency").font(.footnote).foregroundStyle(.secondary)
                    Text(astronaut.agency.abbrev).font(.headline).foregroundStyle(.secondary)
                    Spacer()
                    HStack {
                        Text("\(Image(systemName: "star")) Flights: \(astronaut.flights_count)")
                        Spacer()
                        
                        Text(astronaut.status.name).foregroundStyle(
                            astronaut.status.name == "Active" ? Color.green : Color.red
                        )
                    }
                    
                }.padding(.vertical,12)
                Spacer()
            }.onTapGesture { showDetails = true }
            
                .sheet(isPresented: $showDetails){
                    AstronautDetailSheetView(astronaut: astronaut)
                        .presentationDetents([.medium]).presentationDragIndicator(.visible)
                }

        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    AstronautCard(astronaut: .sampleAstronaut)
}


