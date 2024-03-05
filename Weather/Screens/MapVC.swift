//


import UIKit
import MapKit
import CoreLocation // deal with user location

class MapVC: UIViewController {
	let mapView 				= MKMapView()
	let pinImage				= UIImageView()
	let locationManager 		= CLLocationManager()
	var addressLabel			= WTTitleLabel(textAlignment: .center, fontSize: 20)
	let regionInMeters: Double 	= 10000
	var previousLocation: CLLocation?
	
	weak var delegate: HomeVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
		configureVC()
		checkLocationServices()
    }
	
	func configureVC() {
		view.backgroundColor = .systemBackground
		view.addSubview(mapView)
		view.addSubview(pinImage)
		view.addSubview(addressLabel)
		
		mapView.translatesAutoresizingMaskIntoConstraints = false
		pinImage.translatesAutoresizingMaskIntoConstraints = false
		
		pinImage.image = UIImage(named: "pin")
		pinImage.contentMode = .scaleAspectFit
		
		addressLabel.backgroundColor = .systemBackground
		
		NSLayoutConstraint.activate([
			mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			
			pinImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			pinImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -4),
			pinImage.heightAnchor.constraint(equalToConstant: 30),
			pinImage.widthAnchor.constraint(equalToConstant: 30),
			
			addressLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			addressLabel.heightAnchor.constraint(equalToConstant: 50)
		])
		
		let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
		navigationItem.leftBarButtonItem = cancelButton
		
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addToBookmarkButton))
		navigationItem.rightBarButtonItem = doneButton
	}
	
	func checkLocationServices() {
		if CLLocationManager.locationServicesEnabled() { // check if permission granted
			setupLocationManager()
			checkLocationAuth()
		} else {
			// show alert letting user know they have to turn on
			presentAlert(title: "Location Services Disabled", message: "Please enable location services to use this feature.", buttonTitle: "Cancel")
		}
	}
	
	func setupLocationManager() {
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.delegate 		= self
		mapView.delegate 				= self
	}
	
	func checkLocationAuth() {
		switch CLLocationManager().authorizationStatus {
			case .authorizedWhenInUse: // when app open
				startTackingUserLocation()
			case .authorizedAlways: // even app in background
				break
			case .notDetermined: // haven't picked allow or not allow
				locationManager.requestWhenInUseAuthorization()
			case .restricted: // cannot change app's status
				break
			case .denied: // pop out and hit not allow
				break
			@unknown default:
				break
		}
	}
	
	func startTackingUserLocation() {
		mapView.showsUserLocation = true // show blue dot on the map
		centerViewOnUserLocation()
		locationManager.startUpdatingLocation() // call the delegate func
		previousLocation = UIHelper.getCenterLocation(for: mapView)
	}
	
	func centerViewOnUserLocation() {
		if let location = locationManager.location?.coordinate {
			let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters) // how far to see
			mapView.setRegion(region, animated: true)
		}
	}
	
	@objc func addToBookmarkButton() {
		let lat = mapView.centerCoordinate.latitude
		let long = mapView.centerCoordinate.longitude
		
		showLoadingView()
		NetworkManager.shared.getLocation(lat: lat, long: long) { [weak self] result in
			guard let self = self else { return }
			self.dismissLoadingView()
			
			switch result {
				case .success(let location):
					PersistenceManager.updateWith(bookmark: location, actionType: .add) { [weak self] error in
						guard let self = self else { return }
						
						guard let error = error else {
							self.dismissVC()
							self.delegate.refreshData()
							return
						}
						
						self.presentAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
					}
					
				case .failure(let error):
					self.presentAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
	
	@objc func dismissVC() {
		DispatchQueue.main.async {
			self.dismiss(animated: true)
		}
	}
}

extension MapVC: CLLocationManagerDelegate {
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) { // do something when user change the authorizations; not allow to access location..
		checkLocationAuth()
	}
}

extension MapVC: MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) { // when screen moved, then center location and add into label
		let center = UIHelper.getCenterLocation(for: mapView)
		let geoCoder = CLGeocoder() // get location from lat long
		
		guard let previousLocation = self.previousLocation else { return }
		
		guard center.distance(from: previousLocation) > 50 else { return } // because don't want to update if just tiny move
		self.previousLocation = center
		
		geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
			guard let self = self else { return }
			
			if let _ = error {
				self.presentAlert(title: "Unable to complete your request.", message: "Please check your internet connection.", buttonTitle: "Ok")
				return
			}
			
			guard let placemark = placemarks?.first else { // option to view other details of location
				self.presentAlert(title: "Can't find this location", message: "Please try other location", buttonTitle: "Ok")
				return
			}
			
			let streetNumber = placemark.subThoroughfare ?? ""
			let streetName = placemark.thoroughfare ?? ""
			
			DispatchQueue.main.async {
				self.addressLabel.text = "\(streetNumber) \(streetName)"
			}
		}
	}
}
