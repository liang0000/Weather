//


import UIKit

class HomeVC: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		configureVC()
	}
	
	func configureVC() {
		title 					= "Locations"
		view.backgroundColor 	= .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true
		
		showEmptyStateView(in: view)
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLocButton))
		navigationItem.rightBarButtonItem = addButton
	}
	
	@objc func addLocButton() {
		print(#function, "[\(Self.self)]")
	}
}

