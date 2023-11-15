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

    func fetchLocationKey(for zipCode: String) async throws -> String? {
        let urlString = "\(baseURL)search?apikey=\(apiKey)&q=\(zipCode)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Invalid response from server: Response: \(response)")
            return nil
        }

        do {
            let locations = try JSONDecoder().decode([LocationResponse].self, from: data)
            return locations.first?.key
        } catch {
            // Print out the error and the raw JSON for debugging
            print("Error decoding JSON:", error)
            print("Received JSON String:", String(data: data, encoding: .utf8) ?? "Invalid JSON")
            throw error
        }
    }
}
