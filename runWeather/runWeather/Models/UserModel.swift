//
//  UserModel.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/27/23.
//

import Foundation

struct UserModel {
	var zipCode: String = ""
	var locationKey: String = ""
	var localizedName: String = ""
	var isTestDataEnabled = false
	var autoDisableTestData = false
	var preferences = Preferences()
}
