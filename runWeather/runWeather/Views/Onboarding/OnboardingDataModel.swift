//
//  OnboardingDataModel.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/27/23.
//

import SwiftUI

struct OnboardingDataModel: Equatable {
	var image: String
	var title: String
	var description: String
	var gradientColors: [Color]
}

// let onboardingScreens: [OnboardingDataModel] = [
//	OnboardingDataModel(
//		image: "onboarding1",
//		title: "Run Without Rain",
//		description: "Plan what time of day to run",
//		gradientColors: [Color("OnboardingScreen1Light"), Color("OnboardingScreen1Dark")]
//	),
//	OnboardingDataModel(
//		image: "onboarding2",
//		title: "Enter your Location",
//		description: "Location TODO",
//		gradientColors: [Color("OnboardingScreen2Light"), Color("OnboardingScreen2Dark")]
//	),
//	OnboardingDataModel(
//		image: "onboarding3",
//		title: "Third Screen",
//		description: "TODO",
//		gradientColors: [Color("OnboardingScreen2Light"), Color("OnboardingScreen2Dark")]
//	)
// ]

let onboardingScreens: [OnboardingDataModel] = [
	OnboardingDataModel(
		image: "onboarding1",
		title: "Welcome to Run Weather!",
		description: "Plan your run around the most ideal weather.",
		gradientColors: [Color("tbd"), Color("OnboardingBlue")]
	),
	OnboardingDataModel(
		image: "onboarding2",
		title: "Enter your location",
		description: "And we'll do the rest!",
		gradientColors: [Color("tbd"), Color("OnboardingBlue")]
	),
	OnboardingDataModel(
		image: "onboarding3",
		title: "Filter by temperature & precipitation level",
		description: "Hourly Tab > Top Right Corner > Click 'Sparles' Icon",
		gradientColors: [Color("tbd"), Color("OnboardingBlue")]
	)
]
