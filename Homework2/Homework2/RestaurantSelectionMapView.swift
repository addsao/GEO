import SwiftUI
import MapKit

struct RestaurantSelectionMapView: View {
    @Binding var selectedRestaurant: Restaurant?
    var restaurants: [Restaurant]
    
    // Tọa độ trung tâm mặc định khi mở map
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 10.7766, longitude: 106.6673),
        span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
    )
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: restaurants) { restaurant in
            MapAnnotation(coordinate: restaurant.coordinate) {
                VStack {
                    Image(systemName: "mappin.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        // Đổi màu thành Đỏ nếu quán được chọn, Xanh nếu chưa chọn
                        .foregroundColor(selectedRestaurant?.id == restaurant.id ? .red : .blue)
                    
                    Text(restaurant.name)
                        .font(.caption)
                        .padding(4)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                }
                .onTapGesture {
                    // Cập nhật quán ăn được chọn khi người dùng bấm vào
                    selectedRestaurant = restaurant
                }
            }
        }
    }
}
