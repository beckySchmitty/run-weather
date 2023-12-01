//
//  DateTimeHelpers.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/15/23.
//

import Foundation

// convert date string to "Month, Day - Year" format
func convertToMonthDayYear(_ dateString: String) -> String? {
	let inputFormatter = DateFormatter()
	inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
	inputFormatter.locale = Locale(identifier: "en_US_POSIX")

	guard let date = inputFormatter.date(from: dateString) else {
		print("Invalid date string")
		return nil
	}
	let outputFormatter = DateFormatter()
	outputFormatter.dateFormat = "MMMM dd, yyyy"
	return outputFormatter.string(from: date)
}

// convert date string to "12 pm EST" format
func convertToHourWithTimeZone(_ dateString: String) -> String? {
	let inputFormatter = DateFormatter()
	inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
	inputFormatter.locale = Locale(identifier: "en_US_POSIX")

	guard let date = inputFormatter.date(from: dateString) else {
		return nil
	}

	let outputFormatter = DateFormatter()
	outputFormatter.dateFormat = "h a"

	// Note: This is a simplification. Time zone conversion can be more complex.
	outputFormatter.timeZone = TimeZone(abbreviation: "EST")

	return outputFormatter.string(from: date) + " EST"
}
