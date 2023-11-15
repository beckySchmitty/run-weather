//
//  HourlyWeatherStore.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//
import Foundation

@MainActor
class HourlyWeatherStore: ObservableObject {
	@Published var hourlyWeather = [HourlyWeather]()

	func loadWeatherData(locationKey: String) {
		Task {
			do {
				self.hourlyWeather = try await fetchHourlyWeather(locationKey: locationKey)
				print(">>>> setting hourly weather")
			} catch {
				print("Error fetching data: \(error)")
			}
		}
	}
	func loadTestData() {
		TestDataLoader.loadWeatherTestData(into: self)
	}
}

func fetchHourlyWeather(locationKey: String) async throws -> [HourlyWeather] {
	let urlString = "https://dataservice.accuweather.com/forecasts/v1/hourly/12hour/\(locationKey)?apikey=\(apiKey)"
	guard let url = URL(string: urlString) else {
		throw URLError(.badURL)
	}

	let (data, response) = try await URLSession.shared.data(from: url)
	guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
		throw URLError(.badServerResponse)
	}

	let weatherDataArray = try JSONDecoder().decode([HourlyWeatherData].self, from: data)
	return weatherDataArray.map { HourlyWeather(from: $0) }
}
