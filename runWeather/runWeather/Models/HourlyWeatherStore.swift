//
//  HourlyWeatherStore.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//
import Foundation

@MainActor
class HourlyWeatherStore: ObservableObject {
	@Published var hourlyWeather: [HourlyWeather] = []
	@Published var errorMessage: String?
	@Published var hasError = false

	func loadWeatherData(locationKey: String) async {
		do {
			self.hourlyWeather = try await fetchHourlyWeather(locationKey: locationKey)
			self.hasError = false
			self.errorMessage = nil
		} catch let error as URLError {
			switch error.code {
			case .notConnectedToInternet, .networkConnectionLost, .cannotFindHost, .cannotConnectToHost:
				self.errorMessage = "Network connection is unavailable. Please check your internet settings."
			default:
				self.errorMessage = "An unknown network error occurred."
			}
			self.hasError = true
		} catch {
			self.errorMessage = "An unexpected error occurred."
			self.hasError = true
		}
	}

	func loadTestData() async {
		await TestDataLoader.loadWeatherTestData(into: self)
	}


	func fetchHourlyWeather(locationKey: String) async throws -> [HourlyWeather] {
		let urlString = "https://dataservice.accuweather.com/forecasts/v1/hourly/12hour/\(locationKey)?apikey=\(apiKey)"
		guard let url = URL(string: urlString) else {
			throw WeatherError.badURL
		}

		let (data, response) = try await URLSession.shared.data(from: url)
		guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
			print("Response was not 200: \(response)")
			throw WeatherError.serverError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 500)
		}

		do {
			let weatherDataArray = try JSONDecoder().decode([HourlyWeatherData].self, from: data)
			return weatherDataArray.map { HourlyWeather(from: $0) }
		} catch {
			throw WeatherError.decodingError(underlyingError: error)
		}
	}
}


protocol HourlyWeatherStoreProtocol {
	var hourlyWeather: [HourlyWeather] { get set }
}
