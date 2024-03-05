//


import UIKit

enum PersistenceActionType {
	case add, remove
}

enum PersistenceManager {
	static private let defaults = UserDefaults.standard
	
	enum Keys {
		static let bookmarks = "bookmarks"
	}
	
	static func updateWith(bookmark: Location, actionType: PersistenceActionType, completed: @escaping (WTError?) -> Void) {
		retrieveBookmarks { result in
			switch result {
				case .success(let bookmarks):
					var retrievedBookmarks = bookmarks
					
					switch actionType {
						case .add:
							guard !retrievedBookmarks.contains(bookmark) else {
								completed(.alreadyInBookmarks)
								return
							}
							
							retrievedBookmarks.append(bookmark)
							
						case .remove:
							retrievedBookmarks.removeAll { $0.id == bookmark.id }
					}
					
					completed(save(bookmarks: retrievedBookmarks))
					
				case .failure(let error):
					completed(error)
			}
		}
	}
	
	static func retrieveBookmarks(completed: @escaping (Result<[Location], WTError>) -> Void) {
		guard let bookmarksData = defaults.object(forKey: Keys.bookmarks) as? Data else {
			completed(.success([]))
			return
		}
		
		do {
			let decoder = JSONDecoder()
			let bookmarks = try decoder.decode([Location].self, from: bookmarksData)
			completed(.success(bookmarks))
		} catch {
			completed(.failure(.unableToAddLocation))
		}
	}
	
	static func save(bookmarks: [Location]) -> WTError? {
		do {
			let encoder = JSONEncoder()
			let encodedBookmarks = try encoder.encode(bookmarks)
			defaults.set(encodedBookmarks, forKey: Keys.bookmarks)
			return nil
		} catch {
			return .unableToAddLocation
		}
	}
}
