//
//  LocationStore.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import Foundation
// API Docs: https://developer.accuweather.com/accuweather-locations-api/apis
let baseURL = "https://dataservice.accuweather.com/locations/v1/postalcodes/us/"

class LocationStore: ObservableObject {
	@Published var errorMessage: String?
	@Published var hasError = false

	func fetchLocationKey(for zipCode: String) async throws -> String {
		let urlString = "\(baseURL)search?apikey=\(apiKey)&q=\(zipCode)"
		guard let url = URL(string: urlString) else {
			throw LocationError.invalidURL
		}

		let (data, response) = try await URLSession.shared.data(from: url)

		guard let httpResponse = response as? HTTPURLResponse else {
			throw LocationError.other(URLError(.badServerResponse))
		}

		guard httpResponse.statusCode == 200 else {
			throw LocationError.serverError(statusCode: httpResponse.statusCode)
		}

		do {
			let locations = try JSONDecoder().decode([LocationResponse].self, from: data)
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
