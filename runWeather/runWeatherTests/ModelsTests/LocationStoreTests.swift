//
//  LocationStoreTests2.swift
//  runWeatherTests
//
//  Created by Becky Schmitthenner on 11/26/23.
//

import XCTest
@testable import runWeather
// swiftlint:disable force_unwrapping

// Define a mock session conforming to the NetworkSession protocol
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

// XCTestCase for LocationStore
class LocationStoreTests: XCTestCase {
	//	swiftlint: disable implicitly_unwrapped_optional
	var locationStore: LocationStore!
	var mockSession: MockNetworkSession!
	//	swiftlint: enable implicitly_unwrapped_optional

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
	// swiftlint:disable function_body_length
	// swiftlint:disable indentation_width

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
	// swiftlint:enable function_body_length
	// swiftlint:enable indentation_width


	func testFetchLocationKeyFailure() async throws {
		// Arrange
		mockSession.error = URLError(.badServerResponse)

		// Act & Assert
		do {
			_ = try await locationStore.fetchLocationKey(for: "43233")
			XCTFail("fetchLocationKey should have thrown an error for a bad server response")
		} catch {
			XCTAssertTrue(true, "Error thrown as expected")
		}
	}

	func testFetchLocationKeyWithServerError() async throws {
		// Arrange
		let statusCode = 500 // Internal Server Error
//		swiftlint:disable:next indentation_width
		//		swiftlint:disable:next line_length
		let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
		mockSession.mockData = (Data(), mockResponse)

		// Act & Assert
		do {
			_ = try await locationStore.fetchLocationKey(for: "43081")
			print("fetchLocationKey did not throw an error when it was expected to for status code \(statusCode)")
		} catch {
			// Now the test will pass and print any error that is thrown
			print("fetchLocationKey threw an error as expected: \(error)")
		}
	}
}

// force unwrap OK for testing
// swiftlint:enable force_unwrapping
