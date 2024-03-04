//


import Foundation

struct Location: Codable, Hashable, Identifiable {
	let id: Int
	let name: String
	let main: Main
	let wind: Wind
	let sys: Sys
	
	struct Main: Codable, Hashable {
		let temp: Double
		let humidity: Int
	}
	
	struct Wind: Codable, Hashable {
		let speed: Double
		let deg: Int
		let gust: Double
	}
	
	struct Sys: Codable, Hashable {
		let country: String
	}
}
