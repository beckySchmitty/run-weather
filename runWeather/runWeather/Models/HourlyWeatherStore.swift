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
		// swiftlint:disable line_length
		let testData = """
 [{"DateTime":"2023-11-15T00:00:00-05:00","EpochDateTime":1700024400,"WeatherIcon":34,"IconPhrase":"Rainy","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":31.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=0&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=0&lang=en-us"},{"DateTime":"2023-11-15T01:00:00-05:00","EpochDateTime":1700028000,"WeatherIcon":34,"IconPhrase":"Mostly sunny","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":36.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=1&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=1&lang=en-us"},{"DateTime":"2023-11-15T02:00:00-05:00","EpochDateTime":1700031600,"WeatherIcon":34,"IconPhrase":"Sunny","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":36.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=2&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=2&lang=en-us"},{"DateTime":"2023-11-15T03:00:00-05:00","EpochDateTime":1700035200,"WeatherIcon":34,"IconPhrase":"Mostly clear","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":36.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=3&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=3&lang=en-us"},{"DateTime":"2023-11-15T04:00:00-05:00","EpochDateTime":1700038800,"WeatherIcon":34,"IconPhrase":"Mostly clear","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":36.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=4&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=4&lang=en-us"},{"DateTime":"2023-11-15T05:00:00-05:00","EpochDateTime":1700042400,"WeatherIcon":34,"IconPhrase":"Mostly clear","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":36.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=5&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=5&lang=en-us"},{"DateTime":"2023-11-15T06:00:00-05:00","EpochDateTime":1700046000,"WeatherIcon":34,"IconPhrase":"Mostly clear","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":36.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=6&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=6&lang=en-us"},{"DateTime":"2023-11-15T07:00:00-05:00","EpochDateTime":1700049600,"WeatherIcon":34,"IconPhrase":"Mostly clear","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":37.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=7&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=7&lang=en-us"},{"DateTime":"2023-11-15T08:00:00-05:00","EpochDateTime":1700053200,"WeatherIcon":2,"IconPhrase":"Mostly sunny","HasPrecipitation":false,"IsDaylight":true,"Temperature":{"Value":38.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=8&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=8&lang=en-us"},{"DateTime":"2023-11-15T09:00:00-05:00","EpochDateTime":1700056800,"WeatherIcon":2,"IconPhrase":"Mostly sunny","HasPrecipitation":false,"IsDaylight":true,"Temperature":{"Value":40.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=9&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=9&lang=en-us"},{"DateTime":"2023-11-15T10:00:00-05:00","EpochDateTime":1700060400,"WeatherIcon":2,"IconPhrase":"Mostly sunny","HasPrecipitation":false,"IsDaylight":true,"Temperature":{"Value":47.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=10&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=10&lang=en-us"},{"DateTime":"2023-11-15T11:00:00-05:00","EpochDateTime":1700064000,"WeatherIcon":2,"IconPhrase":"Mostly rainy","HasPrecipitation":false,"IsDaylight":true,"Temperature":{"Value":54.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=11&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=11&lang=en-us"}]
 """
			.data(using: .utf8)!

		do {
			let weatherDataArray = try JSONDecoder().decode([HourlyWeatherData].self, from: testData)
			self.hourlyWeather = weatherDataArray.map { HourlyWeather(from: $0) }
		} catch {
			print("Error decoding test data: \(error)")
		}
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
