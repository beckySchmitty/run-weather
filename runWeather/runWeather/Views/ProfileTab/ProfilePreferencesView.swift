//
//  ProfilePreferencesView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/18/23.
//

import SwiftUI

struct ProfilePreferencesView: View {
	var body: some View {
		Spacer()
		ScrollView {
			Text("Preferences")
				.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
			Text("Customize preferred conditions for your outdoor lifestyle")
			TemperatureSelectView()
			PrecipitationSelectView()
		}
	}
}
