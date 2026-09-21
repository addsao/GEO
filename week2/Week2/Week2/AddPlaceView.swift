//
//  AddPlaceView.swift
//  Week2
//
//  Created by MAY 02 on 21/9/26.
//

import SwiftUI
import MapKit

struct AddPlaceView: View {
    let onSave: (Place) -> Void
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var lat: String = ""
    @State private var long: String = ""
    var body: some View {
        Form {
            Section(header: Text("New Place")) {
                TextField("Name", text: $name)
                TextField("Latitude", text: $lat)
                    .keyboardType(.decimalPad)
                TextField("Longitude", text: $long)
                    .keyboardType(.decimalPad)
            }
        }
        .navigationTitle("Add Place")
        .navigationBarTitleDisplayMode( .inline )
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
                }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    if let lat = Double(lat),
                       let long = Double(long),
                       !name.isEmpty {
                        let newPlace = Place(name: name, lat: lat, long: long)
                        onSave(newPlace)
                        dismiss()
                    }
                }
            }
        }
    }
}

