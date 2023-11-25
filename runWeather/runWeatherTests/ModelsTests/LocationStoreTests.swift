//
//  LocationStoreTests.swift
//  runWeatherTests
//
//  Created by Becky Schmitthenner on 11/25/23.
//

import XCTest
@testable import runWeather

let apiStringURL = "https://example.com"

// Define a mock session that conforms to NetworkSession
class MockNetworkSession: NetworkSession {

	var data: Data?
	var response: URLResponse?
	var error: Error?

	func sessionData(from url: URL) async throws -> (Data, URLResponse) {
		if let error = error {
			throw error
		}
		if let data = data, let response = response {
			return (data, response)
		} else {
			throw URLError(.cannotLoadFromNetwork)
		}
	}
}


class LocationStoreTests: XCTestCase {

	var locationStore: LocationStore!
	var mockSession: MockNetworkSession!

	override func setUpWithError() throws {
		super.setUp()
		mockSession = MockNetworkSession()
		locationStore = LocationStore(session: mockSession)
	}

	override func tearDownWithError() throws {
		locationStore = nil
		mockSession = nil
		super.tearDown()
	}

	func testFetchLocationKey_Success() async throws {
		let testZipCode = "43081"
		let expectedKey = "18404_PC"

		// Prepare mock data for a successful response
//		swiftlint:disable line_length
		let mockJSON = """
	[{"Version":1,"Key":"18404_PC","Type":"PostalCode","Rank":55,"LocalizedName":"Westerville","EnglishName":"Westerville","PrimaryPostalCode":"43081","Region":{"ID":"NAM","LocalizedName":"North America","EnglishName":"North America"},"Country":{"ID":"US","LocalizedName":"United States","EnglishName":"United States"},"AdministrativeArea":{"ID":"OH","LocalizedName":"Ohio","EnglishName":"Ohio","Level":1,"LocalizedType":"State","EnglishType":"State","CountryID":"US"},"TimeZone":{"Code":"EST","Name":"America/New_York","GmtOffset":-5.0,"IsDaylightSaving":false,"NextOffsetChange":"2024-03-10T07:00:00Z"},"GeoPosition":{"Latitude":40.117,"Longitude":-82.919,"Elevation":{"Metric":{"Value":266.0,"Unit":"m","UnitType":5},"Imperial":{"Value":872.0,"Unit":"ft","UnitType":0}}},"IsAlias":false,"ParentCity":{"Key":"340047","LocalizedName":"Westerville","EnglishName":"Westerville"},"SupplementalAdminAreas":[{"Level":2,"LocalizedName":"Franklin","EnglishName":"Franklin"}],"DataSets":["AirQualityCurrentConditions","AirQualityForecasts","Alerts","DailyAirQualityForecast","DailyPollenForecast","ForecastConfidence","FutureRadar","MinuteCast","Radar"]}]
	""".data(using: .utf8)!

		mockSession.data = mockJSON
		mockSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!,
																					 statusCode: 200,
																					 httpVersion: nil,
																					 headerFields: nil)

		do {
			let key = try await locationStore.fetchLocationKey(for: testZipCode)
			XCTAssertEqual(key, expectedKey, "The fetched location key should match the expected key.")
		} catch {
			XCTFail("The request should not have failed: \(error)")
		}
	}

	func testFetchLocationKey_Failure_InvalidZipCode() async throws {
		let testZipCode = "InvalidZip"

		// Prepare mock data for an error response
		mockSession.response = HTTPURLResponse(url: URL(string: apiStringURL)!,
																					 statusCode: 404,
																					 httpVersion: nil,
																					 headerFields: nil)

		do {
			_ = try await locationStore.fetchLocationKey(for: testZipCode)
			XCTFail("The request should have failed with an invalid ZIP code.")
		} catch LocationError.serverError(let statusCode) {
			XCTAssertEqual(statusCode, 404, "The error should have a 404 status code.")
		} catch {
			print("*****Error: \(error)")
			XCTFail("The request should fail with a serverError, not another type of error.")
		}
	}

	func testFetchLocationKey_NetworkError() async throws {
		let testZipCode = "12345"

		// Simulate a network error
		mockSession.error = URLError(.notConnectedToInternet)

		do {
			_ = try await locationStore.fetchLocationKey(for: testZipCode)
			XCTFail("The request should have failed due to a network error.")
		} catch {
			// Check if the error is a URLError and the notConnectedToInternet case
			if let urlError = error as? URLError {
				XCTAssertEqual(urlError.code, .notConnectedToInternet)
			} else {
				XCTFail("The error should be of type URLError with notConnectedToInternet code.")
			}
		}
	}

	func testFetchLocationKey_DecodingError() async throws {
		let testZipCode = "12345"

		// Prepare mock data that cannot be decoded
		let mockJSON = """
	{ "invalid": "data" }
	""".data(using: .utf8)!

		mockSession.data = mockJSON
		mockSession.response = HTTPURLResponse(url: URL(string: apiStringURL)!,
																					 statusCode: 200,
																					 httpVersion: nil,
																					 headerFields: nil)

		do {
			_ = try await locationStore.fetchLocationKey(for: testZipCode)
			XCTFail("The request should have failed due to a decoding error.")
		} catch {
			// Check if the error is a decoding error
			XCTAssertTrue(error is DecodingError, "The error should be a DecodingError.")
		}
	}

	func testFetchLocationKey_InvalidURL() async throws {
		let testZipCode = "1234\\5"  // Backslash should trigger invalid URL

		do {
			_ = try await locationStore.fetchLocationKey(for: testZipCode)
			XCTFail("The request should have failed due to an invalid URL.")
		} catch LocationError.invalidURL {
			// Success: Correct error type was thrown
			XCTAssertTrue(true, "Invalid URL error was correctly identified.")
		} catch {
			XCTFail("The error should be of type LocationError.invalidURL.")
		}

		func testFetchLocationKey_Timeout() async throws {
			let testZipCode = "12345"

			// Simulate a timeout error
			mockSession.error = URLError(.timedOut)

			do {
				_ = try await locationStore.fetchLocationKey(for: testZipCode)
				XCTFail("The request should have failed due to a timeout error.")
			} catch {
				// Check if the error is a URLError and the timedOut case
				if let urlError = error as? URLError {
					XCTAssertEqual(urlError.code, .timedOut, "The error code should indicate a timeout.")
				} else {
					XCTFail("The error should be of type URLError with a timedOut code.")
				}
			}
		}

		func testFetchLocationKey_UnauthorizedAccess() async throws {
			let testZipCode = "12345"

			// Prepare mock data for an unauthorized access response
			let mockResponse = HTTPURLResponse(url: URL(string: apiStringURL)!,
																				 statusCode: 401,
																				 httpVersion: nil,
																				 headerFields: nil)

			mockSession.response = mockResponse

			do {
				_ = try await locationStore.fetchLocationKey(for: testZipCode)
				XCTFail("The request should have failed due to unauthorized access.")
			} catch LocationError.serverError(let statusCode) {
				XCTAssertEqual(statusCode, 401, "The error should have a 401 status code for unauthorized access.")
			} catch {
				XCTFail("The request should fail with a serverError for unauthorized access, not another type of error.")
			}
		}
	}
}
