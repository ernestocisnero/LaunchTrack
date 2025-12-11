//
//  Astronauts.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 12/9/25.
//

import SwiftUI

struct Astronauts: View {
    @StateObject private var avm = AstronautsViewModel()
    
    
    var body: some View {
       
        NavigationStack {
            
            Group{
                if avm.isLoadingAstronauts{
                    ProgressView("Hold tight we're calling our heroes... 🧑‍🚀")
                }else{
                    List(avm.astronauts){ astronaut in
                        AstronautCard(astronaut: astronaut)
                    }
                }
            }
            
            
            .navigationTitle("Astronauts")
        }
        .task {
            await avm.loadAstronauts()
        }
    }
}

#Preview {
    Astronauts()
}
