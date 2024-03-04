//


import UIKit

extension UIViewController {
	func showEmptyStateView(in view: UIView) {
		let emptyStateView = WTEmptyStateView()
		emptyStateView.frame = view.bounds
		view.addSubview(emptyStateView)
	}
}
