//
//  TestDataLoader.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/15/23.
//

import Foundation

@MainActor
enum TestDataLoader {
	static func setTestUserDetails(userStore: UserStore) {
		userStore.zipCode = "43081"
		userStore.locationKey = "18404_PC"
	}

	static func emptyUserDetails(userStore: UserStore) {
		userStore.zipCode = ""
		userStore.locationKey = ""
	}

	static func loadWeatherTestData(into store: HourlyWeatherStore) async {
		// swiftlint:disable line_length
		//		swiftlint:disable indentation_width
		let testData = """
 [{"DateTime":"2023-11-27T00:00:00-05:00","EpochDateTime":1701061200,"WeatherIcon":12,"IconPhrase":"Showers","HasPrecipitation":true,"PrecipitationType":"Rain","PrecipitationIntensity":"Light","IsDaylight":false,"Temperature":{"Value":38.0,"Unit":"F","UnitType":18},"PrecipitationProbability":90,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=0&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=0&lang=en-us"},{"DateTime":"2023-11-27T01:00:00-05:00","EpochDateTime":1701064800,"WeatherIcon":7,"IconPhrase":"Showers","HasPrecipitation":true,"IsDaylight":false,"Temperature":{"Value":36.0,"Unit":"F","UnitType":18},"PrecipitationProbability":80,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=1&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=1&lang=en-us"},{"DateTime":"2023-11-27T02:00:00-05:00","EpochDateTime":1701068400,"WeatherIcon":7,"IconPhrase":"Cloudy","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":35.0,"Unit":"F","UnitType":18},"PrecipitationProbability":20,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=2&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=2&lang=en-us"},{"DateTime":"2023-11-27T03:00:00-05:00","EpochDateTime":1701072000,"WeatherIcon":7,"IconPhrase":"Cloudy","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":34.0,"Unit":"F","UnitType":18},"PrecipitationProbability":20,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=3&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=3&lang=en-us"},{"DateTime":"2023-11-27T04:00:00-05:00","EpochDateTime":1701075600,"WeatherIcon":7,"IconPhrase":"Cloudy","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":32.0,"Unit":"F","UnitType":18},"PrecipitationProbability":20,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=4&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=4&lang=en-us"},{"DateTime":"2023-11-27T05:00:00-05:00","EpochDateTime":1701079200,"WeatherIcon":38,"IconPhrase":"Mostly cloudy","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":31.0,"Unit":"F","UnitType":18},"PrecipitationProbability":20,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=5&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=5&lang=en-us"},{"DateTime":"2023-11-27T06:00:00-05:00","EpochDateTime":1701082800,"WeatherIcon":7,"IconPhrase":"Cloudy","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":68.0,"Unit":"F","UnitType":18},"PrecipitationProbability":13,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=6&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=6&lang=en-us"},{"DateTime":"2023-11-27T07:00:00-05:00","EpochDateTime":1701086400,"WeatherIcon":35,"IconPhrase":"Partly cloudy","HasPrecipitation":false,"IsDaylight":false,"Temperature":{"Value":67.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=7&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=7&lang=en-us"},{"DateTime":"2023-11-27T08:00:00-05:00","EpochDateTime":1701090000,"WeatherIcon":3,"IconPhrase":"Partly sunny","HasPrecipitation":false,"IsDaylight":true,"Temperature":{"Value":30.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=8&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=8&lang=en-us"},{"DateTime":"2023-11-27T09:00:00-05:00","EpochDateTime":1701093600,"WeatherIcon":3,"IconPhrase":"Partly sunny","HasPrecipitation":false,"IsDaylight":true,"Temperature":{"Value":29.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=9&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=9&lang=en-us"},{"DateTime":"2023-11-27T10:00:00-05:00","EpochDateTime":1701097200,"WeatherIcon":3,"IconPhrase":"Partly sunny","HasPrecipitation":false,"IsDaylight":true,"Temperature":{"Value":32.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=10&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=10&lang=en-us"},{"DateTime":"2023-11-27T11:00:00-05:00","EpochDateTime":1701100800,"WeatherIcon":3,"IconPhrase":"Partly sunny","HasPrecipitation":false,"IsDaylight":true,"Temperature":{"Value":33.0,"Unit":"F","UnitType":18},"PrecipitationProbability":0,"MobileLink":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=11&lang=en-us","Link":"http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=2&hbhhour=11&lang=en-us"}]
 """
		// swiftlint:enable line_length
		// swiftlint:enable indentation_width

		// swiftlint:disable:next force_unwrapping
			.data(using: .utf8)!

		do {
			let weatherDataArray = try JSONDecoder().decode([HourlyWeatherData].self, from: testData)
			await MainActor.run {
				store.hourlyWeather = weatherDataArray.map { HourlyWeather(from: $0) }
			}
		} catch {
			print("Error decoding test data: \(error)")
		}
	}

//	clears all test data
	static func emptyTestData(userStore: UserStore, store: HourlyWeatherStore) {
		emptyUserDetails(userStore: userStore)
		store.hourlyWeather = []
	}

// clears test data only related to the user
	static func disableUserTestData(userStore: UserStore) {
		userStore.isTestDataEnabled = false
		print("***** test data enabled =  \(userStore.isTestDataEnabled)")
	}


	static func setTestData(userStore: UserStore, store: HourlyWeatherStore) async {
		setTestUserDetails(userStore: userStore)
		await loadWeatherTestData(into: store)
	}
}
