//
//  ProfileHeaderView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/16/23.
//
import SwiftUI

struct ProfileHeaderView: View {
		@EnvironmentObject var appSettings: AppSettings
		let user: User

		var body: some View {
				ZStack {
						RoundedCorners()
								.fill(Color.blue)
								.edgesIgnoringSafeArea(.top)
								.frame(height: 200)
						VStack(alignment: .center) {
								Image(appSettings.isTestDataEnabled ? "profile_tKelce" : "person")
										.resizable()
										.aspectRatio(contentMode: .fill)
										.frame(width: 100, height: 100)
										.clipShape(Circle())
										.overlay(Circle().stroke(Color.white, lineWidth: 4))
								Text(appSettings.isTestDataEnabled ? "Travis Kelce" : "User")
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
}
