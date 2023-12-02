//
//  LocationStoreTests2.swift
//  runWeatherTests
//
//  Created by Becky Schmitthenner on 11/26/23.
//

import XCTest
@testable import runWeather
// swiftlint:disable force_unwrapping
//	swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable function_body_length
// swiftlint:disable indentation_width

class MockNetworkSession: NetworkSession {
	var mockData: (Data, URLResponse)?
	var error: Error?

	func sessionData(from url: URL) async throws -> (Data, URLResponse) {
		if let error = error {
			throw error
		}
		if let mockData = mockData {
			return mockData
		}
		throw URLError(.badServerResponse)
	}
}

@MainActor
class LocationStoreTests: XCTestCase {
	var locationStore: LocationStore!
	var mockSession: MockNetworkSession!

	override func setUpWithError() throws {
		try super.setUpWithError()
		mockSession = MockNetworkSession()
		locationStore = LocationStore(session: mockSession)
	}

	override func tearDownWithError() throws {
		locationStore = nil
		mockSession = nil
		try super.tearDownWithError()
	}

	func testFetchLocationKeySuccess() async throws {
		// Arrange
		let expectedKey = "18404_PC"
		let mockJSON = """
 [
 {
 "Version": 1,
 "Key": "\(expectedKey)",
 "Type": "PostalCode",
 "Rank": 55,
 "LocalizedName": "Westerville",
 "EnglishName": "Westerville",
 "PrimaryPostalCode": "43081",
 "Region": {
 "ID": "NAM",
 "LocalizedName": "North America",
 "EnglishName": "North America"
 },
 "Country": {
 "ID": "US",
 "LocalizedName": "United States",
 "EnglishName": "United States"
 },
 "AdministrativeArea": {
 "ID": "OH",
 "LocalizedName": "Ohio",
 "EnglishName": "Ohio",
 "Level": 1,
 "LocalizedType": "State",
 "EnglishType": "State",
 "CountryID": "US"
 },
 "TimeZone": {
 "Code": "EST",
 "Name": "America/New_York",
 "GmtOffset": -5.0,
 "IsDaylightSaving": false,
 "NextOffsetChange": "2024-03-10T07:00:00Z"
 },
 "GeoPosition": {
 "Latitude": 40.117,
 "Longitude": -82.919,
 "Elevation": {
 "Metric": {
 "Value": 266.0,
 "Unit": "m",
 "UnitType": 5
 },
 "Imperial": {
 "Value": 872.0,
 "Unit": "ft",
 "UnitType": 0
 }
 }
 },
 "IsAlias": false,
 "ParentCity": {
 "Key": "340047",
 "LocalizedName": "Westerville",
 "EnglishName": "Westerville"
 },
 "SupplementalAdminAreas": [
 {
 "Level": 2,
 "LocalizedName": "Franklin",
 "EnglishName": "Franklin"
 }
 ],
 "DataSets": [
 "AirQualityCurrentConditions",
 "AirQualityForecasts",
 "Alerts",
 "DailyAirQualityForecast",
 "DailyPollenForecast",
 "ForecastConfidence",
 "FutureRadar",
 "MinuteCast",
 "Radar"
 ]
 }
 ]
 """
		let mockData = Data(mockJSON.utf8)
		let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
		mockSession.mockData = (mockData, mockResponse)

		// Act
		let key = try await locationStore.fetchLocationKey(for: "43081")
		// Assert
		XCTAssertEqual(key, expectedKey)
	}


	func testFetchLocationKeyFailure() async throws {
		// Arrange
		mockSession.error = URLError(.badServerResponse)

		// Act & Assert
		do {
			_ = try await locationStore.fetchLocationKey(for: "43233")
			XCTFail("fetchLocationKey should have thrown an error")
		} catch {
			XCTAssertTrue(true, "Error thrown as expected")
		}
	}
}

// swiftlint:enable force_unwrapping
//	swiftlint:enable implicitly_unwrapped_optional
// swiftlint:enable function_body_length
// swiftlint:enable indentation_width
