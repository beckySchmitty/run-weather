//
//  ProfileHeaderView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/16/23.
//

import SwiftUI

struct ProfileHeaderView: View {
	@ObservedObject var user: User
	@EnvironmentObject var locationStore: LocationStore
	var body: some View {
		HStack {
			if user.isTestDataEnabled {
					Image("profile_tKelce")
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(width: 100, height: 100)
							.clipShape(Circle())
							.overlay(Circle().stroke(Color.white, lineWidth: 4))
			} else {
					Circle()
							.strokeBorder(Color.white, lineWidth: 4)
							.frame(width: 100, height: 100)
			}
			Text(user.isTestDataEnabled ? "Travis Kelce" : "User")
				.font(.title)
				.foregroundColor(.white)
			Text("Zip Code: \(user.zipCode)")
				.font(.subheadline)
				.foregroundColor(.white)
			Text("Location Key: \(user.locationKey)")
				.font(.subheadline)
				.foregroundColor(.white)
		}
	}
}
