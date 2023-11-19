//
//  DarkModeToggleView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/19/23.
//

import SwiftUI

struct DarkModeToggleView: View {
	var user: User  // Add user object
	@Binding var isDarkModeEnabled: Bool

	var body: some View {
		Toggle("Dark Mode", isOn: $isDarkModeEnabled)
			.onChange(of: isDarkModeEnabled) { _, newValue in
				user.updateDarkModePreference(to: newValue)
			}
			.padding()
	}
}
