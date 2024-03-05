//


import Foundation

struct Location: Codable, Hashable, Identifiable {
	let id: Int
	let name: String
	let coord: Coord
	let main: Main
	let wind: Wind
	let sys: Sys
	
	struct Coord: Codable, Hashable {
		let lat: Double
		let lon: Double
	}
	
	struct Main: Codable, Hashable {
		let temp: Double
		let humidity: Int
	}
	
	struct Wind: Codable, Hashable {
		var speed: Double?
		var deg: Int?
		var gust: Double?
	}
	
	struct Sys: Codable, Hashable {
		var country: String?
	}
}
