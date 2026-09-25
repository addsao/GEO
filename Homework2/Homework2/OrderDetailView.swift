import SwiftUI

struct OrderDetailView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        VStack {
            RouteMapView(source: order.restaurant.coordinate, destination: order.deliveryCoordinate)
                .frame(height: 300)
                .cornerRadius(12)
                .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Quán: \(order.restaurant.name)").font(.headline)
                Text("Giao đến: \(order.customerName) - \(order.deliveryAddress)")
                
                if let dist = order.distance, let time = order.expectedTravelTime {
                    Text("Khoảng cách: \(String(format: "%.1f", dist)) km (~ \(Int(time)) phút)")
                        .fontWeight(.bold)
                }
                
                HStack {
                    Text("Trạng thái:")
                    Text(order.status)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(statusColor(for: order.status))
                        .cornerRadius(8)
                }
                
                Button("Đánh dấu Đã Giao") {
                    order.status = "Đã giao"
                }
                .padding(.top)
            }
            .padding()
            Spacer()
        }
        .navigationTitle("Chi tiết đơn hàng")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func statusColor(for status: String) -> Color {
        switch status {
        case "Chưa giao": return .blue
        case "Đang giao": return .orange
        case "Đã giao": return .green
        default: return .gray
        }
    }
}
