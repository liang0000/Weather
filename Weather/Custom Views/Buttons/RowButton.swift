//


import UIKit

class RowButton: UIButton {
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init(title: String) {
		super.init(frame: .zero)
		setTitle(title, for: .normal)
		configure()
	}
	
	private func configure() {
		configuration 				= .borderless()
		backgroundColor 			= .secondarySystemBackground
		layer.cornerRadius 			= 10
		contentHorizontalAlignment = .left
		translatesAutoresizingMaskIntoConstraints = false
	}
}
