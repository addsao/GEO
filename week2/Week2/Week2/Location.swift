//
//  Location.swift
//  Week2
//
//  Created by MAY 02 on 21/9/26.
//

import Foundation

class Place: Identifiable {
    let id: UUID = UUID()
    var name: String
    var lat: Double
    var long: Double

    init(name: String, lat: Double, long: Double) {
        self.name = name
        self.lat = lat
        self.long = long
    }
}

