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
	@Environment(\.horizontalSizeClass)
	var horizontalSizeClass
	@Environment(\.verticalSizeClass)
	var verticalSizeClass

	var body: some View {
		ZStack {
			//			portrait
			if horizontalSizeClass == .compact && verticalSizeClass == .regular {
				VStack {
					VStack(spacing: 20) {
						Image(screenData.image)
							.resizable()
							.scaledToFit()
							.frame(height: 200)
						Text(screenData.title)
							.font(.title)
							.fontWeight(.bold)
							.foregroundColor(Color("OnboardingText"))
							.padding([.vertical], 20)
							.padding([.horizontal], 4)
						Text(screenData.description)
							.font(.headline)
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
					.cornerRadius(Constants.General.cornerRadiusClassic)
					.padding()
				}
				//				landscape
			} else {
				HStack(spacing: 20) {
					Image(screenData.image)
						.resizable()
						.scaledToFit()
						.frame(height: 200)
					VStack {
						Text(screenData.title)
							.font(.title)
							.fontWeight(.bold)
							.foregroundColor(Color("OnboardingText"))
							.padding(.top, 20)
						Text(screenData.description)
							.font(.headline)
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
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				//		swiftlint:disable:next line_length
				.background(LinearGradient(gradient: Gradient(colors: screenData.gradientColors), startPoint: .top, endPoint: .bottom))
				.cornerRadius(Constants.General.cornerRadiusClassic)
				.padding()
			}
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
}
