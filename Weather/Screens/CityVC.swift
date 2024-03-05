//


import UIKit

class CityVC: UIViewController {
	let latInfoView 		= WTItemInfoView()
	let longInfoView 		= WTItemInfoView()
	let tempInfoView 		= WTItemInfoView()
	let humiInfoView 		= WTItemInfoView()
	let windSpeedInfoView 	= WTItemInfoView()
	let windDegInfoView 	= WTItemInfoView()
	let windGustInfoView 	= WTItemInfoView()
	let countryCodeView 	= WTItemInfoView()
	var itemViews: [UIView] = []
	
	var location: Location!
	
	init(location: Location) {
		super.init(nibName: nil, bundle: nil)
		self.location = location
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		configureItems()
		configureVC()
    }
	
	private func configureItems() {
		latInfoView.set(title: "Latitude:", info: String(location.coord.lat))
		longInfoView.set(title: "Longitude:", info: String(location.coord.lon))
		tempInfoView.set(title: "Temperature:", info: "\(location.main.temp) °C")
		humiInfoView.set(title: "Humidity:", info: "\(location.main.humidity)%")
		windSpeedInfoView.set(title: "Wind speed:", info: "\(location.wind.speed ?? 0) meter/sec")
		windDegInfoView.set(title: "Wind direction:", info: "\(location.wind.deg ?? 0) degrees")
		windGustInfoView.set(title: "Wind gust:", info: "\(location.wind.gust ?? 0) meter/sec")
		countryCodeView.set(title: "Country code:", info: location.sys.country ?? "")
	}
	
	private func configureVC() {
		let padding: CGFloat 		= 20
		let itemSpacing: CGFloat	= 25
		itemViews = [latInfoView, longInfoView, tempInfoView, humiInfoView, windSpeedInfoView, windDegInfoView, windGustInfoView, countryCodeView]
		
		for itemView in itemViews {
			view.addSubview(itemView)
			itemView.translatesAutoresizingMaskIntoConstraints = false
			
			NSLayoutConstraint.activate([
				itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
				itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding),
			])
		}
		
		NSLayoutConstraint.activate([
			latInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
			longInfoView.topAnchor.constraint(equalTo: latInfoView.bottomAnchor, constant: itemSpacing),
			tempInfoView.topAnchor.constraint(equalTo: longInfoView.bottomAnchor, constant: itemSpacing),
			humiInfoView.topAnchor.constraint(equalTo: tempInfoView.bottomAnchor, constant: itemSpacing),
			windSpeedInfoView.topAnchor.constraint(equalTo: humiInfoView.bottomAnchor, constant: itemSpacing),
			windDegInfoView.topAnchor.constraint(equalTo: windSpeedInfoView.bottomAnchor, constant: itemSpacing),
			windGustInfoView.topAnchor.constraint(equalTo: windDegInfoView.bottomAnchor, constant: itemSpacing),
			countryCodeView.topAnchor.constraint(equalTo: windGustInfoView.bottomAnchor, constant: itemSpacing)
		])
	}
}
