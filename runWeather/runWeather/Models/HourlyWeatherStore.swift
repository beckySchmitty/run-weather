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
		} catch let error as URLError where error.code == .badURL {
			errorMessage = WeatherError.badURL.localizedDescription
		} catch let error as URLError where error.code == .badServerResponse {
			//			swiftlint:disable:next line_length
			errorMessage = WeatherError.serverError(statusCode: (error as? HTTPURLResponse)?.statusCode ?? 500).localizedDescription
		} catch let error as DecodingError {
			errorMessage = WeatherError.decodingError(underlyingError: error).localizedDescription
		} catch {
			errorMessage = WeatherError.other(error).localizedDescription
		}
	}

	func loadTestData() async {
		TestDataLoader.loadWeatherTestData(into: self)
	}
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
