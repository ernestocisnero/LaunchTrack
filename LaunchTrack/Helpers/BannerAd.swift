//
//  BannerAdView.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 11/30/25.
//

import SwiftUI
import GoogleMobileAds


struct BannerAd: UIViewRepresentable {
    let adUnitID: String
    
    

    func makeUIView(context: Context) -> BannerView {
        let view = BannerView(adSize: AdSizeBanner)
        view.adUnitID = adUnitID
        view.rootViewController = UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow?.rootViewController }
            .first
        
        // Load non-personalized ad
                let request = Request()
                let extras = Extras()
                extras.additionalParameters = ["npa": "1"]  // Non-personalized ads
                request.register(extras)
        
        view.load(Request())
        return view
    }

    func updateUIView(_ uiView: BannerView, context: Context) { }
    
    
}

