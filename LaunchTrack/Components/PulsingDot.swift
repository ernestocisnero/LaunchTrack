//
//  PulsingDot.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 12/7/25.
//

import SwiftUI

struct PulsingDot: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: 8, height: 8)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(
                    Animation.easeInOut(duration: 0.9).repeatForever(autoreverses: true)
                ) {
                    scale = 1.4
                }
            }
    }
}


#Preview {
    PulsingDot()
}
