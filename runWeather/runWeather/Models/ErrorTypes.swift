//
//  ErrorTypes.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/17/23.
//

import Foundation

enum LocationError: Error {
	case invalidURL
	case serverError(statusCode: Int)
	case decodingError(underlyingError: Error)
	case other(Error)

	var localizedDescription: String {
		switch self {
		case .invalidURL:
			return "The URL provided was invalid."
		case .serverError(let statusCode):
			return "The server responded with an error. Status code: \(statusCode)."
		case .decodingError(let underlyingError):
			return "There was a problem decoding the data: \(underlyingError.localizedDescription)"
		case .other(let error):
			return "An unknown error occurred: \(error.localizedDescription)"
		}
	}
}

enum WeatherError: Error {
	case badURL
	case serverError(statusCode: Int)
	case decodingError(underlyingError: Error)
	case other(Error)

	var localizedDescription: String {
		switch self {
		case .badURL:
			return "The URL to fetch weather data was invalid."
		case .serverError(let statusCode):
			return "The server responded with an error. Status code: \(statusCode)."
		case .decodingError(let underlyingError):
			return "There was a problem decoding the weather data: \(underlyingError.localizedDescription)"
		case .other(let error):
			return "An unknown error occurred: \(error.localizedDescription)"
		}
	}
}
