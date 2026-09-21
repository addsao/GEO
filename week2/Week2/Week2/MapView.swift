//
//  MapView.swift
//  Week2
//
//  Created by MAY 02 on 21/9/26.
//

import SwiftUI
import MapKit

struct MapView: View {
    let place: Place
    
    @State private var region: MKCoordinateRegion
    
    init(place: Place) {
        self.place = place
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: place.lat,
                longitude: place.long),
            span: MKCoordinateSpan(
                latitudeDelta: 0.05,
                longitudeDelta: 0.05))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [place]) {item in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                VStack {
                    Image(systemName: "mappin")
                        .foregroundColor(Color.black)
                        .font(.title)
                    Text(place.name)
                        .font(.caption)
                        .padding(6)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 1)
                }
            }
        }
            .navigationTitle(Text(place.name))
            .navigationBarTitleDisplayMode(.inline)
    }
}

