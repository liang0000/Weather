//


import UIKit

class NetworkManager {
	static let shared 			= NetworkManager()
	static private let apiKey 	= "c6e381d8c7fF98f0fee43775817cf6ad"
	private let baseURL 		= "https://api.openweathermap.org/data/2.5/weather?appid=\(apiKey)&units=metric"
	
	private init() {}
	
	func getLocation(lat: Double, long: Double, completed: @escaping (Result<Location, WTError>) -> Void) {
		let endpoint = baseURL + "&lat=\(lat)&lon=\(long)"
		
		guard let url = URL(string: endpoint) else {
			completed(.failure(.invalidLatLong))
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let _ = error {
				completed(.failure(.unableToComplete))
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completed(.failure(.invalidResponse))
				return
			}
			
			guard let data = data else {
				completed(.failure(.invalidData))
				return
			}
			
			do {
				let decoder = JSONDecoder()
				let location = try decoder.decode(Location.self, from: data)
				completed(.success(location))
			} catch {
				completed(.failure(.invalidData))
			}
		}
		
		task.resume()
	}
}
