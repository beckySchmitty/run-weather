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

@MainActor
class LocationStore: ObservableObject {
	@Published var errorMessage: String?
	@Published var hasError = false
	var session: NetworkSession

	// Dependency injection in initializer
	init(session: NetworkSession = URLSession.shared) {
		self.session = session
	}

	func fetchLocationKey(for zipCode: String) async throws -> String {
		let urlString = "\(baseURL)search?apikey=\(apiKey)&q=\(zipCode)"
		guard let url = URL(string: urlString) else {
			throw LocationError.invalidURL
		}
		do {
			//			let (data, response) = try await URLSession.shared.data(from: url)
			let (data, response) = try await session.sessionData(from: url)

			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
				throw LocationError.serverError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 500)
			}

			let locations = try JSONDecoder().decode([LocationModel].self, from: data)
			guard let locationKey = locations.first?.key else {
				throw LocationError.locationNotFound
			}
			return locationKey
		} catch let error as URLError where error.code == .notConnectedToInternet {
			// Handling specific network-related errors
			throw LocationError.networkUnavailable
		} catch let error as DecodingError {
			// Handle decoding errors
			throw LocationError.decodingError(underlyingError: error)
		} catch {
			// Handle all other errors
			throw LocationError.other(error)
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
