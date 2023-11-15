//
//  LocationModel.swif
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import Foundation

struct LocationResponse: Decodable {
    let version: Int
    let key: String
    let type: String
    let rank: Int
    let localizedName: String
    let englishName: String
    let primaryPostalCode: String
    let region: Region
    let country: Country
    let administrativeArea: AdministrativeArea
    let timeZone: TimeZoneInfo
    let geoPosition: GeoPosition
    let isAlias: Bool
    let parentCity: ParentCity
    let supplementalAdminAreas: [SupplementalAdminArea]
    let dataSets: [String]

    enum CodingKeys: String, CodingKey {
        case version = "Version"
        case key = "Key"
        case type = "Type"
        case rank = "Rank"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
        case primaryPostalCode = "PrimaryPostalCode"
        case region = "Region"
        case country = "Country"
        case administrativeArea = "AdministrativeArea"
        case timeZone = "TimeZone"
        case geoPosition = "GeoPosition"
        case isAlias = "IsAlias"
        case parentCity = "ParentCity"
        case supplementalAdminAreas = "SupplementalAdminAreas"
        case dataSets = "DataSets"
    }
}

struct Region: Decodable {
    let id: String
    let localizedName: String
    let englishName: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}

struct Country: Decodable {
    let id: String
    let localizedName: String
    let englishName: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}

struct AdministrativeArea: Decodable {
    let id: String
    let localizedName: String
    let englishName: String
    let level: Int
    let localizedType: String
    let englishType: String
    let countryID: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
        case level = "Level"
        case localizedType = "LocalizedType"
        case englishType = "EnglishType"
        case countryID = "CountryID"
    }
}

struct TimeZoneInfo: Decodable {
    let code: String
    let name: String
    let gmtOffset: Double
    let isDaylightSaving: Bool
    let nextOffsetChange: String?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case name = "Name"
        case gmtOffset = "GmtOffset"
        case isDaylightSaving = "IsDaylightSaving"
        case nextOffsetChange = "NextOffsetChange"
    }
}

struct GeoPosition: Decodable {
    let latitude: Double?
    let longitude: Double?
    let elevation: Elevation?
}

struct Elevation: Decodable {
    let metric: ElevationMeasurement
    let imperial: ElevationMeasurement
}

struct ElevationMeasurement: Decodable {
    let value: Double
    let unit: String
    let unitType: Int
}

struct ParentCity: Decodable {
    let key: String
    let localizedName: String
    let englishName: String

    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}

struct SupplementalAdminArea: Decodable {
    let level: Int
    let localizedName: String
    let englishName: String

    enum CodingKeys: String, CodingKey {
        case level = "Level"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}
