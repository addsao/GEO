import SwiftUI
import MapKit

struct AddPlaceView: View {
    let onSave: (Place) -> Void
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var lat: String = ""
    @State private var long: String = ""
    
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 10.7626, longitude: 106.6601),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    var body: some View {
        Form {
            Section(header: Text("New Place")) {
                TextField("Name", text: $name)
                TextField("Latitude", text: $lat)
                    .keyboardType(.decimalPad)
                    .onChange(of: lat) { _, newValue in
                        if let newLat = Double(newValue), let currentRegion = position.region {
                            updateMap(lat: newLat, long: currentRegion.center.longitude)
                        }
                    }
                
                TextField("Longitude", text: $long)
                    .keyboardType(.decimalPad)
                    .onChange(of: long) { _, newValue in
                        if let newLong = Double(newValue), let currentRegion = position.region {
                            updateMap(lat: currentRegion.center.latitude, long: newLong)
                        }
                    }
            }
            
            Section(header: Text("Map (Move to choose)")) {
                ZStack {
                    Map(position: $position)
                        .onMapCameraChange(frequency: .continuous) { context in
                            let center = context.region.center
                            if Double(lat) != center.latitude {
                                lat = String(format: "%.6f", center.latitude)
                                long = String(format: "%.6f", center.longitude)
                            }
                        }
                    
                    Image(systemName: "mappin")
                        .font(.title)
                        .foregroundColor(.red)
                        .offset(y: -15)
                }
                .frame(height: 250)
                .cornerRadius(8)
            }
        }
        .navigationTitle("Add Place")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    if let latDouble = Double(lat), let longDouble = Double(long), !name.isEmpty {
                        onSave(Place(name: name, lat: latDouble, long: longDouble))
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func updateMap(lat: Double, long: Double) {
        position = .region(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: lat, longitude: long),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }
}
