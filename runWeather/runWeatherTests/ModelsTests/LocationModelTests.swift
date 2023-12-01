//
//  LocationModelTests2.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/19/23.
//

import XCTest
@testable import runWeather

class LocationModelTests: XCTestCase {
	func testLocationModelInitialization() {
		// JSON string that represents the data we want to test
		//		swiftlint:disable line_length
		//		swiftlint:disable indentation_width
		//		swiftlint:disable force_unwrapping

	let jsonString = """
 [{"Version":1,"Key":"18404_PC","Type":"PostalCode","Rank":55,"LocalizedName":"Westerville","EnglishName":"Westerville","PrimaryPostalCode":"43081","Region":{"ID":"NAM","LocalizedName":"North America","EnglishName":"North America"},"Country":{"ID":"US","LocalizedName":"United States","EnglishName":"United States"},"AdministrativeArea":{"ID":"OH","LocalizedName":"Ohio","EnglishName":"Ohio","Level":1,"LocalizedType":"State","EnglishType":"State","CountryID":"US"},"TimeZone":{"Code":"EST","Name":"America/New_York","GmtOffset":-5.0,"IsDaylightSaving":false,"NextOffsetChange":"2024-03-10T07:00:00Z"},"GeoPosition":{"Latitude":40.117,"Longitude":-82.919,"Elevation":{"Metric":{"Value":266.0,"Unit":"m","UnitType":5},"Imperial":{"Value":872.0,"Unit":"ft","UnitType":0}}},"IsAlias":false,"ParentCity":{"Key":"340047","LocalizedName":"Westerville","EnglishName":"Westerville"},"SupplementalAdminAreas":[{"Level":2,"LocalizedName":"Franklin","EnglishName":"Franklin"}],"DataSets":["AirQualityCurrentConditions","AirQualityForecasts","Alerts","DailyAirQualityForecast","DailyPollenForecast","ForecastConfidence","FutureRadar","MinuteCast","Radar"]}]
 """
		//		swiftlint:enable line_length
		// Convert the JSON string to Data
		guard let data = jsonString.data(using: .utf8) else {
			XCTFail("Could not create data from JSON string")
			return
	}

		do {
			// Decode the JSON data into an array of LocationModel
		let locations = try JSONDecoder().decode([LocationModel].self, from: data)

			// Assert that the locations array is not empty, meaning at least one location exists
			XCTAssertFalse(locations.isEmpty, "No locations were decoded from the JSON data")
		} catch {
			XCTFail("Decoding LocationModel failed with error: \(error)")
		}
}


	func testRegionDecoding() {
	let json =
 """
 {
 "ID": "NA",
 "LocalizedName": "North America",
 "EnglishName": "North America"
 }
 """
		.data(using: .utf8)!

		do {
			let region = try JSONDecoder().decode(Region.self, from: json)
			XCTAssertEqual(region.id, "NA")
			XCTAssertEqual(region.localizedName, "North America")
			XCTAssertEqual(region.englishName, "North America")
		} catch {
			XCTFail("Decoding Region failed with error: \(error)")
		}
}

	func testCountryDecoding() {
	let json = """
 {
 "ID": "US",
 "LocalizedName": "United States",
 "EnglishName": "United States"
 }
 """
		.data(using: .utf8)!

		do {
			let country = try JSONDecoder().decode(Country.self, from: json)
			XCTAssertEqual(country.id, "US")
			XCTAssertEqual(country.localizedName, "United States")
			XCTAssertEqual(country.englishName, "United States")
		} catch {
			XCTFail("Decoding Country failed with error: \(error)")
		}
	}
}
//		swiftlint:enable force_unwrapping
//	swiftlint:enable indentation_width
