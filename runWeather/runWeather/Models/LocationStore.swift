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

	// The session property for network calls
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
		let (data, response) = try await session.sessionData(from: url)

		guard let httpResponse = response as? HTTPURLResponse else {
			throw LocationError.other(URLError(.badServerResponse))
		}

		guard httpResponse.statusCode == 200 else {
			throw LocationError.serverError(statusCode: httpResponse.statusCode)
		}

		do {
			let locations = try JSONDecoder().decode([LocationModel].self, from: data)
			guard let key = locations.first?.key else {
				//				swiftlint:disable:next line_length
				throw LocationError.decodingError(underlyingError: DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Key not found in response")))
			}
			return key
		} catch {
			throw LocationError.decodingError(underlyingError: error)
		}
	}
}
