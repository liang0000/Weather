//


import UIKit

class SettingVC: UIViewController {
	let clearButton = RowButton(title: "Clear All Bookmarked Location")
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureVC()
		configureClearButton()
    }
	
	func configureVC() {
		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	func configureClearButton() {
		let padding: CGFloat = 20
		
		view.addSubview(clearButton)
		clearButton.addTarget(self, action: #selector(clickClearButton), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			clearButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
			clearButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
			clearButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
			clearButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	@objc func clickClearButton() {
		presentOptionAlert(title: "Clear all bookmarked location", message: "Are you sure to clear?", buttonTitle: "Clear") { _ in
			
		}
	}
}
