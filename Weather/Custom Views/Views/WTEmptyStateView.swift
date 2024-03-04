//


import UIKit

class WTEmptyStateView: UIView {
	let messageTitle = WTTitleLabel(textAlignment: .center, fontSize: 28)
	let messageBody = WTBodyLabel(textAlignment: .center)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configure() {
		let padding: CGFloat = 40
		
		addSubview(messageTitle)
		addSubview(messageBody)
		
		backgroundColor 	= .systemBackground
		messageTitle.text 	= "No Location Added"
		messageTitle.textColor = .secondaryLabel
		
		messageBody.text 	= "Add one from top right + button."
		
		NSLayoutConstraint.activate([
			messageTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
			messageTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			messageTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			
			messageBody.topAnchor.constraint(equalTo: messageTitle.bottomAnchor, constant: 10),
			messageBody.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			messageBody.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
		])
	}
}
