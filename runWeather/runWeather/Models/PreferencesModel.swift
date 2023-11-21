//
//  PreferencesModel.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/21/23.
//

import Foundation

struct Preferences: Codable {
	var selectedTemperature: String = "32°F"
	var selectedPrecipitation: String = "< 20%"
}
