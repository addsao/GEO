import Foundation
import MapKit

class MapService {
    static func getRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping (Double?, TimeInterval?) -> Void) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else {
                completion(nil, nil)
                return
            }
            let distance = route.distance / 1000.0
            let time = route.expectedTravelTime / 60.0
            completion(distance, time)
        }
    }
}
