//
//  HourlyWeatherModel.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import Foundation

struct HourlyWeatherData: Decodable {
    let dateTime: String
    let epochDateTime: Int
    let weatherIcon: Int
    let iconPhrase: String
    let hasPrecipitation: Bool
    let isDaylight: Bool
    let temperature: Temperature
    let precipitationProbability: Int
    let mobileLink: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
        case epochDateTime = "EpochDateTime"
        case weatherIcon = "WeatherIcon"
        case iconPhrase = "IconPhrase"
        case hasPrecipitation = "HasPrecipitation"
        case isDaylight = "IsDaylight"
        case temperature = "Temperature"
        case precipitationProbability = "PrecipitationProbability"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}

struct Temperature: Decodable {
    let value: Double
    let unit: String
    let unitType: Int
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}
