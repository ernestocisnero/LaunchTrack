//
//  AstronautDetailSheetView.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 12/10/25.
//

import SwiftUI

struct AstronautDetailSheetView: View {
    let astronaut: Astronaut
    var body: some View {
        
        VStack{
            
            HStack {
                Text(astronaut.name).font(.largeTitle).bold(true)
            }
            .padding()
            HStack{
                VStack(alignment: .leading){
                HStack {
                    Image(systemName: "flag").padding(10)
                    VStack (alignment: .leading){
                        Text("Nationality").font(.subheadline).foregroundStyle(.secondary)
                        Text(astronaut.nationality.first?.name ?? "Unknown").font(.title2)
                    }
                }
                
                HStack {
                    Image(systemName: "clock").padding(10)
                    VStack (alignment: .leading){
                        Text("Time in Space").font(.subheadline).foregroundStyle(.secondary)
                        Text(astronaut.time_in_space).font(.subheadline)
                    }
                }
                
            }
            
            VStack (alignment: .leading){
                HStack {
                    Image(systemName: "birthday.cake").padding(10)
                    VStack (alignment: .leading){
                        Text("Date of Birth").font(.subheadline).foregroundStyle(.secondary)
                        Text(astronaut.date_of_birth ?? "Unknown").font(.title3)
                    }
                }
                
                
                HStack {
                    Image(systemName: "person").padding(10)
                    VStack (alignment: .leading){
                        Text("Age").font(.subheadline).foregroundStyle(.secondary)
                        Text("\( astronaut.age)").font(.title3)
                    }
                }
                
            }
        }
            
            ScrollView{
                Text(astronaut.bio ?? "No Bio Available")
                        .font(.body)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
            }.padding(10)
            
        }
    }
}

#Preview {
    AstronautDetailSheetView(astronaut: .sampleAstronaut)
}
