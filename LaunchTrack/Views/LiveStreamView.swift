//
//  LiveStreamView.swift
//  LaunchTrack
//
//  Created by Ernesto Cisnero on 12/6/25.
//


import SwiftUI
import WebKit
import MapKit

struct LiveStreamView: View {
    let name: String?
    let title: String?
    let streamURL: String
    let padLatitude: Double
    let padLongitude: Double
    
    @State var position = MapCameraPosition.region(MKCoordinateRegion( center: CLLocationCoordinate2D( latitude:0, longitude:0), span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)))

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // MARK: - Live Badge
                HStack {
                    
                    Spacer()
                }
                .padding(.horizontal)

                // MARK: - Video Player
                WebView(url: streamURL)
                    .frame(height: 260)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .padding(.horizontal)

                // MARK: - Info Card
                VStack(alignment: .leading, spacing: 10) {

                    HStack(alignment: .firstTextBaseline){
                        Image(systemName: "arrowtriangle.right.square.fill")
                            
                        
                        Text(title ?? "Livestream")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.top, 20)
                    }
                    
                    Divider()
                    
                    Text("Pad Location")
                        .font(.subheadline)
                        .bold()
                    
                    Divider()
                }
                .padding(.horizontal)
            }
            
            //MARK: Map Location
            VStack{
                Map( position: $position ){
                    Marker("\(name ?? "Unknown")", coordinate: CLLocationCoordinate2D( latitude: padLatitude, longitude: padLongitude))
                }
                    .mapStyle(.standard)
                    .frame(height: 310)
            }
            .onAppear {
                // Updates the loation on Appear action
                position = .region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: padLatitude, longitude: padLongitude),
                        span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
                    )
                )
            }
        }
        .navigationTitle("Watch Launch")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//MARK: - WebView Wrapper

struct WebView: UIViewRepresentable {
    let url: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: url) else { return }
        uiView.load(URLRequest(url: url))
    }
}



#Preview {
    LiveStreamView(name: "Unknown", title: "Unknown", streamURL:"https://www.youtube.com/watch?v=H5ABuDe5jag", padLatitude:38.8830649 , padLongitude:-77.0162786)
}
