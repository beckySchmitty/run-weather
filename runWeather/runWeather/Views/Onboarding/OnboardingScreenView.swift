//
//  OnboardingScreenView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/27/23.
//

import SwiftUI

struct OnboardingScreenView: View {
	var screenData: OnboardingDataModel
	@AppStorage("isOnboarding") var isOnboarding = true

	var body: some View {
		VStack(spacing: 20) {
			Image(screenData.image)
				.resizable()
				.scaledToFit()
				.frame(height: 200)
				.foregroundColor(.white)
			Text(screenData.title)
				.font(.title)
				.fontWeight(.bold)
				.foregroundColor(.white)
			Text(screenData.description)
				.foregroundColor(.white)
				.multilineTextAlignment(.center)
				.padding(.horizontal)
			if screenData == onboardingScreens.last {
				Button("Get Started") {
					isOnboarding = false
				}
				.buttonStyle(PrimaryButtonStyle())
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(LinearGradient(gradient: Gradient(colors: screenData.gradientColors), startPoint: .top, endPoint: .bottom))
		.cornerRadius(10)
		.padding()
	}
}

struct PrimaryButtonStyle: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.padding()
			.background(Color.gray)
			.foregroundColor(.white)
			.clipShape(Capsule())
			.padding()
	}
}
