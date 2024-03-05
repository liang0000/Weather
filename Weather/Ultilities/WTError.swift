//


import Foundation

enum WTError: String, Error {
	case invalidLatLong 		= "This lat-long created an invalid request. Please try again."
	case unableToComplete 		= "Unable to complete your request. Please check your internet connection."
	case invalidResponse 		= "Invalid response from the server. Please try again."
	case invalidData 			= "The data received from the server was invalid. Please try again."
	case unableToAddLocation   	= "There was an error adding this location. Please try again."
	case alreadyInBookmarks 	= "You've already bookmarked this location."
}
