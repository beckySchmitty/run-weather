//
//  ProfileHeaderView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/16/23.
//

import SwiftUI

struct ProfileHeaderView: View {
	@ObservedObject var userStore: UserStore
	@EnvironmentObject var locationStore: LocationStore
	@Environment(\.horizontalSizeClass)
	var horizontalSizeClass
	@Environment(\.verticalSizeClass)
	var verticalSizeClass

	//	swiftlint:disable line_length
	var body: some View {
		VStack {
			if userStore.isTestDataEnabled {
				Image("testDataUser")
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: horizontalSizeClass == .compact && verticalSizeClass == .regular ? 100 : 60, height: horizontalSizeClass == .compact && verticalSizeClass == .regular ? 100 : 80)
					.clipShape(Circle())
					.overlay(Circle().stroke(Color("mainBlueText"), lineWidth: 4))
					.padding()
			} else {
				Image(systemName: "person.fill")
					.resizable()
					.foregroundColor(Color("mainBlueText"))
					.aspectRatio(contentMode: .fill)
					.frame(width: horizontalSizeClass == .compact && verticalSizeClass == .regular ? 100 : 80, height: horizontalSizeClass == .compact && verticalSizeClass == .regular ? 100 : 80)
					.clipShape(Circle())
					.overlay(Circle().stroke(Color("mainBlueText"), lineWidth: 4))
					.padding()
			}
			Text(userStore.isTestDataEnabled ? "Travis Kelce" : "New User")
				.font(.title)
				.foregroundColor(Color("mainBlueText"))
			Text("Zip Code: \(userStore.zipCode)")
				.font(.subheadline)
				.foregroundColor(Color("mainBlueText"))
			Text("Location Key: \(userStore.locationKey)")
				.font(.subheadline)
				.foregroundColor(Color("mainBlueText"))
		}
		.padding()
	}
}
//	swiftlint:enable line_length
