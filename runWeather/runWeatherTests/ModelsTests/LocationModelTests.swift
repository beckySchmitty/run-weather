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
		// Ensure the JSON file is added to the test target
		guard let url = Bundle(for: type(of: self)).url(forResource: "LocationTestData", withExtension: "json"),
				let data = try? Data(contentsOf: url) else {
			XCTFail("Failed to load LocationTestData.json from test bundle")
			return
		}

		do {
			// Decode the JSON data into an array of LocationModel, since your JSON root is an array
			let locations = try JSONDecoder().decode([LocationModel].self, from: data)
			guard let location = locations.first else {
				XCTFail("No locations were decoded from the JSON data")
				return
			}

			// Perform the tests using the first location in the array
			XCTAssertEqual(location.version, 1)
			XCTAssertEqual(location.key, "18404_PC")
			XCTAssertEqual(location.type, "PostalCode")
			// ... continue with assertions for the rest of the properties
		} catch {
			XCTFail("Decoding LocationModel failed with error: \(error)")
		}
	}


	func testRegionDecoding() {
		let json = """
 {
 "ID": "NA",
 "LocalizedName": "North America",
 "EnglishName": "North America"
 }
 """.data(using: .utf8)!

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
		//		swigt
		let json = """
 {
 "ID": "US",
 "LocalizedName": "United States",
 "EnglishName": "United States"
 }
 """.data(using: .utf8)!

		do {
			let country = try JSONDecoder().decode(Country.self, from: json)
			XCTAssertEqual(country.id, "US")
			XCTAssertEqual(country.localizedName, "United States")
			XCTAssertEqual(country.englishName, "United States")
		} catch {
			XCTFail("Decoding Country failed with error: \(error)")
		}
	}

	// Add more tests here
}
