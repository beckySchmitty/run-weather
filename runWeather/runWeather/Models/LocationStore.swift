//
//  LocationStore.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import Foundation

protocol NetworkSession {
	func sessionData(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {
	func sessionData(from url: URL) async throws -> (Data, URLResponse) {
		return try await self.data(from: url)
	}
}

// API Docs: https://developer.accuweather.com/accuweather-locations-api/apis
let baseURL = "https://dataservice.accuweather.com/locations/v1/postalcodes/us/"

class LocationStore: ObservableObject {
	@Published var errorMessage: String?
	@Published var hasError = false
	var session: NetworkSession

	// Dependency injection in initializer
	init(session: NetworkSession = URLSession.shared) {
		self.session = session
	}
	// Function to fetch the location key from the AccuWeather API
	func fetchLocationKey(for zipCode: String) async throws -> String {
		// Construct the URL for the API request
		let urlString = "\(baseURL)search?apikey=\(apiKey)&q=\(zipCode)"
		guard let url = URL(string: urlString) else {
			throw LocationError.invalidURL
		}

		// Perform the network request
		let (data, response) = try await session.sessionData(from: url)


		// Check for non-200 HTTP responses
		guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
			throw LocationError.serverError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 500)
		}

		// Decode the JSON response
		let decoder = JSONDecoder()
		do {
			let locations = try decoder.decode([LocationModel].self, from: data)
			guard let locationKey = locations.first?.key else {
				throw LocationError.locationNotFound
			}
			return locationKey
		} catch let error as DecodingError {
			throw LocationError.decodingError(underlyingError: mapDecodingError(error))
		}
	}

	// Helper function to map a DecodingError to a more descriptive NSError
	private func mapDecodingError(_ error: DecodingError) -> NSError {
		switch error {
		case let .keyNotFound(key, context):
			let errorMsg = "Key '\(key.stringValue)' not found in JSON: \(context.debugDescription)"
			return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMsg])
			// Add cases for other types of DecodingError if needed
		default:
			let errorMsg = "Decoding error: \(error.localizedDescription)"
			return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMsg])
		}
	}
}
