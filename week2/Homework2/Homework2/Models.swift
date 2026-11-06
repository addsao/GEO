//
//  Models.swift
//  Homework2
//
//  Created by MAY 02 on 21/9/26.
//

import Foundation
import CoreLocation


class Restaurant: Identifiable {
    let id = UUID()
    var name: String
    var address: String
    var lat: Double
    var long: Double
    
    init(name: String, address: String, lat: Double, long: Double) {
        self.name = name
        self.address = address
        self.lat = lat
        self.long = long
    }
}

class Order: Identifiable {
    let id = UUID()
    var customerName: String
    var deliveryAddress: String
    var lat: Double
    var long: Double
    var status: String
    
    init(customerName: String, deliveryAddress: String, lat: Double, long: Double, status: String) {
        self.customerName = customerName
        self.deliveryAddress = deliveryAddress
        self.lat = lat
        self.long = long
        self.status = "Chua giao"
    }
}
