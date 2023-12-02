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
		HStack {
			if userStore.isTestDataEnabled {
				Image("testDataUser")
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: horizontalSizeClass == .compact && verticalSizeClass == .regular ? 100 : 90, height: horizontalSizeClass == .compact && verticalSizeClass == .regular ? 100 : 90)
					.clipShape(Circle())
					.overlay(Circle().stroke(Color("backgroundBlueOpposite"), lineWidth: 4))
					.padding()
			} else {
				Image(systemName: "person.fill")
					.resizable()
					.foregroundColor(Color("backgroundBlueOpposite"))
					.aspectRatio(contentMode: .fill)
					.frame(width: horizontalSizeClass == .compact && verticalSizeClass == .regular ? 100 : 90, height: horizontalSizeClass == .compact && verticalSizeClass == .regular ? 100 : 90)
					.clipShape(Circle())
					.overlay(Circle().stroke(Color("backgroundBlueOpposite"), lineWidth: 4))
					.padding()
			}
			VStack {
				Text(userStore.isTestDataEnabled ? "Travis Kelce" : "New User")
					.font(.title)
					.foregroundColor(Color("backgroundBlueOpposite"))
				Text(userStore.zipCode.isEmpty ? " - " : userStore.zipCode)
					.font(.headline)
					.frame(width: 80, height: 30)
					.background(Color("backgroundBlueOpposite"))
					.foregroundColor(Color("backgroundBlue"))
					.accentColor(Color("backgroundBlue"))
					.cornerRadius(Constants.General.cornerRadiusClassic)
			}
		}
		.padding()
	}
}
//	swiftlint:enable line_length
