//


import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
	func showEmptyStateView(in view: UIView) {
		let emptyStateView = WTEmptyStateView()
		emptyStateView.frame = view.bounds
		view.addSubview(emptyStateView)
	}
	
	func presentAlert(title: String, message: String, buttonTitle: String) {
		DispatchQueue.main.async {
			let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
			
			let action = UIAlertAction(title: buttonTitle, style: .cancel, handler: nil)
			alertController.addAction(action)
			
			self.present(alertController, animated: true)
		}
	}
	
	func presentSafariVC(with url: URL) {
		let safariVC = SFSafariViewController(url: url)
//		safariVC.preferredControlTintColor = .systemGreen
		present(safariVC, animated: true)
	}
	
	func showLoadingView() {
		containerView = UIView(frame: view.bounds)
		view.addSubview(containerView)
		
		containerView.backgroundColor = .systemBackground
		containerView.alpha = 0
		
		UIView.animate(withDuration: 0.25) {
			containerView.alpha = 0.8
		}
		
		let activityIndicator = UIActivityIndicatorView(style: .large)
		containerView.addSubview(activityIndicator)
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
		
		activityIndicator.startAnimating()
	}
	
	func dismissLoadingView() {
		DispatchQueue.main.async {
			containerView.removeFromSuperview()
			containerView = nil
		}
	}
}
