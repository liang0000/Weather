//


import UIKit

protocol HomeVCDelegate: AnyObject {
	func refreshData()
}

class HomeVC: UIViewController {
	let tableView            	= UITableView()
	var bookmarks: [Location] 	= []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureVC()
		configureTableView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		getBookmarks()
	}
	
	func configureVC() {
		title 					= "Locations"
		view.backgroundColor 	= .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLocButton))
		navigationItem.rightBarButtonItem = addButton
	}
	
	func configureTableView() {
		view.addSubview(tableView)
		
		tableView.rowHeight     = 80
		tableView.delegate      = self
		tableView.dataSource    = self
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		tableView.register(BookmarkCell.self, forCellReuseIdentifier: BookmarkCell.reuseID)
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
	
	@objc func addLocButton() {
		let destVC 		= MapVC()
		destVC.delegate = self
		
		let nav = UINavigationController(rootViewController: destVC)
		present(nav, animated: true)
	}
	
	func getBookmarks() {
		PersistenceManager.retrieveBookmarks { [weak self] result in
			guard let self = self else { return }
			
			switch result {
				case .success(let bookmarks):
					if bookmarks.isEmpty {
						self.showEmptyStateView(in: self.view)
					} else  {
						self.bookmarks = bookmarks
						DispatchQueue.main.async {
							self.tableView.reloadData()
							self.view.bringSubviewToFront(self.tableView)
						}
					}
					
				case .failure(let error):
					self.presentAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // rows in array
		return bookmarks.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkCell.reuseID) as! BookmarkCell
		let bookmark = bookmarks[indexPath.row]
		cell.set(bookmark: bookmark)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let bookmark    = bookmarks[indexPath.row]
		let destVC      = CityVC(location: bookmark)
		destVC.title    = bookmark.name

		show(destVC, sender: self)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else { return }
		
		let bookmark = bookmarks[indexPath.row]
		bookmarks.remove(at: indexPath.row)
		tableView.deleteRows(at: [indexPath], with: .left)
		
		PersistenceManager.updateWith(bookmark: bookmark, actionType: .remove) { [weak self] error in
			guard let self = self else { return }
			guard let error = error else { return }
			self.presentAlert(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
		}
	}
}

extension HomeVC: HomeVCDelegate {
	func refreshData() {
		getBookmarks()
	}
}
