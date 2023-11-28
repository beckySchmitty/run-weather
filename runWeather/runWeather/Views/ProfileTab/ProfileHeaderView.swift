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
	@Environment(\.verticalSizeClass) var verticalSizeClass

	var body: some View {
		VStack {
			ZStack {
				RoundedRectangle(cornerRadius: 25, style: .continuous)
					.foregroundColor(Color("profileBlue"))
					.edgesIgnoringSafeArea(.top)
				VStack {
					HStack {
						Image(systemName: "person.fill")
							.resizable()
							.scaledToFit()
							.frame(width: verticalSizeClass == .regular ? 48 : 24, height: verticalSizeClass == .regular ? 48 : 24)
							.padding(.leading, verticalSizeClass == .regular ? 16 : 8)
							.foregroundColor(.white)
						Text("User")
							.font(.title)
							.foregroundColor(.white)
						Spacer()
					}
					.padding(.top, verticalSizeClass == .regular ? 20 : 10)
					Spacer()
					VStack(spacing: 8) {
						Text("Location")
							.font(.largeTitle)
							.fontWeight(.bold)
							.foregroundColor(.white)
						Text("Please enter your Zip Code")
							.foregroundColor(.white.opacity(0.7))
//						TODO: add in real zip code view
						TextField("Zipe Code", text: $userStore.user.zipCode)
							.padding()
							.background(Color.white)
							.cornerRadius(5.0)
							.padding(.horizontal)
							.shadow(radius: 3)
					}
					Spacer()
				}
			}
			.frame(height: verticalSizeClass == .regular ? 300 : 150)
		}
	}
}
