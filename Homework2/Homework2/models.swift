import Foundation
import CoreLocation
import Combine

class Restaurant: Identifiable {
    let id = UUID()
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, address: String, latitude: Double, longitude: Double) {
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

class Order: Identifiable, ObservableObject {
    let id = UUID()
    var restaurant: Restaurant
    var customerName: String
    var deliveryAddress: String
    var latitude: Double
    var longitude: Double
    
    @Published var status: String
    @Published var distance: Double?
    @Published var expectedTravelTime: TimeInterval?
    
    init(restaurant: Restaurant, customerName: String, deliveryAddress: String, latitude: Double, longitude: Double, status: String = "Chưa giao") {
        self.restaurant = restaurant
        self.customerName = customerName
        self.deliveryAddress = deliveryAddress
        self.latitude = latitude
        self.longitude = longitude
        self.status = status
    }
    
    var deliveryCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
