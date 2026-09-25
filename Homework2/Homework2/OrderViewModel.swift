import Foundation
import SwiftUI
import Combine

class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = []
    let availableRestaurants: [Restaurant] = [
            Restaurant(name: "Phở 24", address: "10 Nguyễn Văn Linh, Q.7", latitude: 10.7303, longitude: 106.7042),
            Restaurant(name: "Highlands Coffee", address: "72 Lê Lợi, Q.1", latitude: 10.7733, longitude: 106.7015),
            Restaurant(name: "Lotteria", address: "285 CMT8, Q.10", latitude: 10.7766, longitude: 106.6673),
            Restaurant(name: "Pizza Hut", address: "1 Võ Văn Ngân, Thủ Đức", latitude: 10.8500, longitude: 106.7500)
        ]
    init() {
        let pho24 = Restaurant(name: "Phở 24", address: "10 Nguyễn Văn Linh, Q.7", latitude: 10.7303, longitude: 106.7042)
        let highlands = Restaurant(name: "Highlands Coffee", address: "72 Lê Lợi, Q.1", latitude: 10.7733, longitude: 106.7015)
        
        let order1 = Order(restaurant: pho24, customerName: "Nguyễn Văn A", deliveryAddress: "123 Lê Văn Sỹ, Q.3", latitude: 10.7892, longitude: 106.6775, status: "Chưa giao")
        let order2 = Order(restaurant: highlands, customerName: "Trần Thị B", deliveryAddress: "456 Điện Biên Phủ, Q.10", latitude: 10.7711, longitude: 106.6751, status: "Đang giao")
        
        self.orders = [order1, order2]
        
        for order in orders {
            calculateRoute(for: order)
        }
    }
    
    func calculateRoute(for order: Order) {
        MapService.getRoute(from: order.restaurant.coordinate, to: order.deliveryCoordinate) { distance, time in
            DispatchQueue.main.async {
                order.distance = distance
                order.expectedTravelTime = time
                self.objectWillChange.send()
            }
        }
    }
    func addOrder(_ order: Order) {
            orders.append(order)
            calculateRoute(for: order) // Tự động tính khoảng cách cho đơn mới
        }
}
