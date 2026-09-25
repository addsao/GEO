import SwiftUI

struct ContentView: View {
    @StateObject private var orderManager = OrderViewModel()
    @State private var showingAddOrder = false
    
    var body: some View {
        NavigationView {
            VStack {
                List(orderManager.orders) { order in
                    NavigationLink(destination: OrderDetailView(order: order)) {
                        OrderRowView(order: order)
                    }
                }
                .listStyle(PlainListStyle())
                
                VStack(spacing: 10) {
                    Button(action: {
                        showingAddOrder = true
                    }) {
                        Text("+ Thêm đơn hàng")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    Text("Tổng số đơn hàng: \(orderManager.orders.count)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 10)
                }
                .background(Color(UIColor.systemBackground).shadow(radius: 2))
            }
            .navigationTitle("Đơn Hàng Cần Giao")
            .sheet(isPresented: $showingAddOrder) {
                AddOrderView(orderManager: orderManager)
            }
        }
    }
}

struct OrderRowView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "cup.and.saucer.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .foregroundColor(.orange)
                .padding(.top, 4)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(order.restaurant.name)
                    .font(.headline)
                Text(order.restaurant.address)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Giao cho: \(order.customerName)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Text(order.deliveryAddress)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 4)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 10) {
                if let distance = order.distance {
                    Text(String(format: "%.1f km", distance))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                } else {
                    Text("Đang tính...")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Text(order.status)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(statusColor(for: order.status))
                    .clipShape(Capsule())
            }
        }
        .padding(.vertical, 8)
    }
    
    func statusColor(for status: String) -> Color {
        switch status {
        case "Chưa giao": return .black
        case "Đang giao": return .gray
        case "Đã giao": return .black
        default: return .gray
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
