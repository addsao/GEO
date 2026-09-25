import SwiftUI
import CoreLocation

struct AddOrderView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var orderManager: OrderViewModel
    
    @State private var customerName: String = ""
    @State private var deliveryAddress: String = ""
    @State private var selectedRestaurant: Restaurant?
    
    @State private var isGeocoding: Bool = false
    @State private var geocodeError: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("1. Chọn quán ăn trên bản đồ")) {
                    RestaurantSelectionMapView(selectedRestaurant: $selectedRestaurant, restaurants: orderManager.availableRestaurants)
                        .frame(height: 250)
                        .listRowInsets(EdgeInsets())
                    
                    if let res = selectedRestaurant {
                        Text("Quán đã chọn: \(res.name)")
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                    } else {
                        Text("Vui lòng chạm vào một biểu tượng trên bản đồ để chọn quán.")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                Section(header: Text("2. Thông tin người nhận")) {
                    TextField("Tên khách hàng", text: $customerName)
                    TextField("Địa chỉ giao đến (vd: 1 Lê Duẩn, Q1)", text: $deliveryAddress)
                }
                
                if geocodeError {
                    Text("Không tìm thấy tọa độ cho địa chỉ này, vui lòng nhập rõ hơn (Thêm Quận, TP).")
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            .navigationTitle("Thêm Đơn Hàng")
            .navigationBarItems(
                leading: Button("Hủy") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button(action: {
                    saveOrder()
                }) {
                    if isGeocoding {
                        ProgressView()
                    } else {
                        Text("Lưu")
                            .fontWeight(.bold)
                    }
                }
                .disabled(customerName.isEmpty || deliveryAddress.isEmpty || selectedRestaurant == nil || isGeocoding)
            )
        }
    }
    
    func saveOrder() {
        guard let restaurant = selectedRestaurant else { return }
        
        isGeocoding = true
        geocodeError = false
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(deliveryAddress) { placemarks, error in
            isGeocoding = false
            
            if let coordinate = placemarks?.first?.location?.coordinate {
                let newOrder = Order(
                    restaurant: restaurant,
                    customerName: customerName,
                    deliveryAddress: deliveryAddress,
                    latitude: coordinate.latitude,
                    longitude: coordinate.longitude
                )
                
                orderManager.addOrder(newOrder)
                presentationMode.wrappedValue.dismiss()
                
            } else {
                geocodeError = true
            }
        }
    }
}
