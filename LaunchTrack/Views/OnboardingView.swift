//
//  OnboardingView.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 11/20/25.
//

import SwiftUI

// MARK: - Onboarding data
let onboardingSlides = [
    OnboardingSlide(
        image: "launch",
        title: "LaunchTrack",
        description: "Follow upcoming space launches instantly."
    ),
    OnboardingSlide(
        image: "space_calendar",
        title: "Never miss a launch",
        description: "Countdowns and details of each mission."
    ),
    OnboardingSlide(
        image: "space",
        title: "Explore and learn",
        description: "Access complete information on rockets and missions."
    )
]

struct OnboardingView: View {
    @State private var currentIndex = 0
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(Array(onboardingSlides.enumerated()), id: \.offset) { index, slide in
                    VStack(spacing: 30) {
                        Image(slide.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 250)
                        
                        Text(slide.title)
                            .font(.largeTitle.bold())
                            .multilineTextAlignment(.center)
                        
                        Text(slide.description)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 20)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentIndex)
            
            // Dots indicators
            HStack(spacing: 8) {
                ForEach(0..<onboardingSlides.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color(red: 96 / 255.0, green: 89 / 255.0, blue: 227 / 255.0):Color.gray.opacity(0.4))
                        .frame(width: 10, height: 10)
                        .animation(.easeInOut, value: currentIndex)
                }
            }
            .padding(.top, 20)
            
            Spacer()
            
            // Next / Get Started
            Button(action: {
                if currentIndex < onboardingSlides.count - 1 {
                    currentIndex += 1
                } else {
                    // Onboarding has been seen
                    hasSeenOnboarding = true
                }
            }) {
                Text(currentIndex < onboardingSlides.count - 1 ? "Next" : "Get Started")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 96 / 255.0, green: 89 / 255.0, blue: 227 / 255.0))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 40)
        }
        .ignoresSafeArea()
    }
}

#Preview{
    OnboardingView()
}


