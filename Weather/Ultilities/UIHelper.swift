//


import UIKit
import MapKit
import CoreLocation

struct UIHelper {
	static func getCenterLocation(for mapView: MKMapView) -> CLLocation {
		let latitude = mapView.centerCoordinate.latitude
		let longitude = mapView.centerCoordinate.longitude
		
		return CLLocation(latitude: latitude, longitude: longitude)
	}
}
