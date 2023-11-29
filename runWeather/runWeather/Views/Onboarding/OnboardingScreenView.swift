//
//  OnboardingScreenView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/27/23.
//

import SwiftUI

struct OnboardingScreenView: View {
	var screenData: OnboardingDataModel
	@AppStorage("isOnboarding")
	var isOnboarding = true
	var horizontalSizeClass: UserInterfaceSizeClass?

	var body: some View {
		VStack(spacing: 20) {
			Image(screenData.image)
				.resizable()
				.scaledToFit()
				.frame(height: horizontalSizeClass == .compact ? 140 : 200)
			Text(screenData.title)
				.font(.title)
				.fontWeight(.bold)
				.foregroundColor(Color("OnboardingText"))
				.padding(.top, horizontalSizeClass == .compact ? 10 : 20)
			Text(screenData.description)
				.foregroundColor(Color("OnboardingText"))
				.multilineTextAlignment(.center)
				.padding(.horizontal)
			if screenData == onboardingScreens.last {
				Button("Explore") {
					isOnboarding = false
				}
				.buttonStyle(PrimaryButtonStyle())
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		//		swiftlint:disable:next line_length
		.background(LinearGradient(gradient: Gradient(colors: screenData.gradientColors), startPoint: .top, endPoint: .bottom))
		.cornerRadius(10)
		.padding()
	}
}

struct PrimaryButtonStyle: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.padding()
			.background(Color("OnboardingText"))
			.foregroundColor(Color("OnboardingBlue"))
			.clipShape(Capsule())
			.padding()
	}
}
