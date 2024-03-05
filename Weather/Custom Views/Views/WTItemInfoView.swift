//


import UIKit

class WTItemInfoView: UIView {
	let titleLabel 	= WTTitleLabel(textAlignment: .left, fontSize: 14)
	let infoLabel	= WTTitleLabel(textAlignment: .left, fontSize: 14)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure() {
		addSubview(titleLabel)
		addSubview(infoLabel)
		
		NSLayoutConstraint.activate([
			titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			titleLabel.heightAnchor.constraint(equalToConstant: 18),
			titleLabel.widthAnchor.constraint(equalToConstant: 120),
			
			infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			infoLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			infoLabel.heightAnchor.constraint(equalToConstant: 18)
		])
	}
	
	func set(title: String, info: String) {
		titleLabel.text = title
		infoLabel.text	= info
	}
}
