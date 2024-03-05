//


import UIKit

class BookmarkCell: UITableViewCell {
	static let reuseID  = "BookmarkCell"
	let locationLabel   = WTTitleLabel(textAlignment: .left, fontSize: 24)
	let latLabel   		= WTBodyLabel(textAlignment: .left)
	let longLabel   	= WTBodyLabel(textAlignment: .left)
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func set(bookmark: Location) {
		locationLabel.text = bookmark.name
		latLabel.text = "lat: " + String(bookmark.coord.lat)
		longLabel.text = "long: " + String(bookmark.coord.lon)
	}
	
	private func configure() {
		let padding: CGFloat = 12
		
		addSubview(locationLabel)
		addSubview(latLabel)
		addSubview(longLabel)
		
		accessoryType = .disclosureIndicator
		
		NSLayoutConstraint.activate([
			locationLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			locationLabel.heightAnchor.constraint(equalToConstant: 40),
			locationLabel.widthAnchor.constraint(equalToConstant: 150),
			
			latLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
			latLabel.leadingAnchor.constraint(equalTo: locationLabel.trailingAnchor, constant: padding),
			latLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			latLabel.heightAnchor.constraint(equalToConstant: 20),
			
			longLabel.topAnchor.constraint(equalTo: latLabel.bottomAnchor, constant: padding),
			longLabel.leadingAnchor.constraint(equalTo: locationLabel.trailingAnchor, constant: padding),
			longLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			longLabel.heightAnchor.constraint(equalToConstant: 20),
		])
	}

}
