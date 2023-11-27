//
//  TestDataLoader.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/15/23.
//

import Foundation

@MainActor
enum TestDataLoader {
	static func setTestUserDetails(user: User) {
		print("####### TestDataLoader setting test data...")
		user.zipCode = "43081"
		user.locationKey = "18404_PC"
	}

	static func emptyUserDetails(user: User) {
		user.zipCode = ""
		user.locationKey = ""
	}

	static func loadWeatherTestData(into store: HourlyWeatherStore) async {
		// swiftlint:disable line_length
		//		swiftlint:disable indentation_width
		let testData = """
 [{"DateTime":"2023-11-15T00:00:00-05:00","EpochDateTime":1700024400,"WeatherIcon":34,"IconPhrase":"Rainy","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":31.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=0&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=0&lang=en-us"},{"DateTime":"2023-11-15T01:00:00-05:00","EpochDateTime":1700028000,"WeatherIcon":12,"IconPhrase":"Showers","HasPrecipitation":true,"IsDaylight":false,"Temperature":{"Value":36.0,"Unit":"F","UnitType":18},"PrecipitationProbability":50,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=1&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=1&lang=en-us"},{"DateTime":"2023-11-15T02:00:00-05:00","EpochDateTime":1700031600,"WeatherIcon":34,"IconPhrase":"Sunny","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":36.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=2&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=2&lang=en-us"},{"DateTime":"2023-11-15T03:00:00-05:00","EpochDateTime":1700035200,"WeatherIcon":34,"IconPhrase":"Mostly clear","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":36.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=3&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=3&lang=en-us"},{"DateTime":"2023-11-15T04:00:00-05:00","EpochDateTime":1700038800,"WeatherIcon":19,"IconPhrase":"Flurries","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":36.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=4&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=4&lang=en-us"},{"DateTime":"2023-11-15T05:00:00-05:00","EpochDateTime":1700042400,"WeatherIcon":34,"IconPhrase":"Mostly clear","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":36.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=5&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=5&lang=en-us"},{"DateTime":"2023-11-15T06:00:00-05:00","EpochDateTime":1700046000,"WeatherIcon":34,"IconPhrase":"Mostly clear","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":36.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=6&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=6&lang=en-us"},{"DateTime":"2023-11-15T07:00:00-05:00","EpochDateTime":1700049600,"WeatherIcon":34,"IconPhrase":"Mostly clear","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":37.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=7&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=7&lang=en-us"},{"DateTime":"2023-11-15T08:00:00-05:00","EpochDateTime":1700053200,"WeatherIcon":2,"IconPhrase":"Mostly sunny","HasPrecipitation":false,"IsDaylight":true,"Temperature":{"Value":38.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=8&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=8&lang=en-us"},{"DateTime":"2023-11-15T09:00:00-05:00","EpochDateTime":1700056800,"WeatherIcon":2,"IconPhrase":"Mostly sunny","HasPrecipitation":false,"IsDaylight":true,"Temperature":{"Value":40.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=9&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=9&lang=en-us"},{"DateTime":"2023-11-15T10:00:00-05:00","EpochDateTime":1700060400,"WeatherIcon":2,"IconPhrase":"Mostly sunny","HasPrecipitation":false,"IsDaylight":true,"Temperature":{"Value":47.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=10&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=10&lang=en-us"},{"DateTime":"2023-11-15T11:00:00-05:00","EpochDateTime":1700064000,"WeatherIcon":2,"IconPhrase":"Mostly rainy","HasPrecipitation":false,"IsDaylight":true,"Temperature":{"Value":54.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=11&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=11&lang=en-us"}]
 """
		// swiftlint:enable line_length
		// swiftlint:enable indentation_width

		// swiftlint:disable:next force_unwrapping
			.data(using: .utf8)!

		do {
			let weatherDataArray = try JSONDecoder().decode([HourlyWeatherData].self, from: testData)
			await MainActor.run {
				store.hourlyWeather = weatherDataArray.map { HourlyWeather(from: $0) }
				print("###### setting test data")
			}
		} catch {
			print("Error decoding test data: \(error)")
		}
	}
	static func emptyTestData(user: User, store: HourlyWeatherStore) {
		emptyUserDetails(user: user)
		store.hourlyWeather = []
	}
	static func setTestData(user: User, store: HourlyWeatherStore) async {
		setTestUserDetails(user: user)
		await loadWeatherTestData(into: store)
	}
}
