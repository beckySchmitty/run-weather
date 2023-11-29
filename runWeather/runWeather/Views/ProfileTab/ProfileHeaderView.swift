//
//  ProfileHeaderView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/16/23.
//

// TODO:Remove if I keep the other style
// import SwiftUI
//
// struct ProfileHeaderView: View {
//	@ObservedObject var userStore: UserStore
//	@EnvironmentObject var locationStore: LocationStore
//	@Environment(\.verticalSizeClass) 
//	var verticalSizeClass
//
//	var body: some View {
//		VStack {
//			ZStack {
//				RoundedRectangle(cornerRadius: 25, style: .continuous)
//					.foregroundColor(Color("profileBlue"))
//					.edgesIgnoringSafeArea(.top)
//				VStack {
//					Spacer()
//					VStack(spacing: 8) {
//						Text("Location")
//							.font(.largeTitle)
//							.fontWeight(.bold)
//							.foregroundColor(Color("profileLocationText"))
//						Text("Please enter your Zip Code")
//							.foregroundColor(Color("profileLocationText"))
////						TODO: add in real zip code view
//						TextField("Zipe Code", text: $userStore.user.zipCode)
//							.padding()
//							.background(Color.white)
//							.cornerRadius(5.0)
//							.padding(.horizontal)
//							.shadow(radius: 3)
//					}
//					Spacer()
//				}
//			}
//			.frame(height: verticalSizeClass == .regular ? 200 : 150)
//		}
//	}
// }

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
	var body: some View {
		HStack {
			if userStore.isTestDataEnabled {
				Image("testDataUser")
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: 100, height: 100)
					.clipShape(Circle())
					.overlay(Circle().stroke(Color("mainBlueText"), lineWidth: 4))
			} else {
				Circle()
					.strokeBorder(Color("mainBlueText"), lineWidth: 4)
					.frame(width: 100, height: 100)
			}
			Text(userStore.isTestDataEnabled ? "Travis Kelce" : "User")
				.font(.title)
				.foregroundColor(Color("mainBlueText"))
			Text("Zip Code: \(userStore.zipCode)")
				.font(.subheadline)
				.foregroundColor(Color("mainBlueText"))
			Text("Location Key: \(userStore.locationKey)")
				.font(.subheadline)
				.foregroundColor(Color("mainBlueText"))
		}
	}
}
