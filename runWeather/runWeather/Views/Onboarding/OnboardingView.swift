//
//  OnboardingView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/27/23.
//

import SwiftUI

struct OnboardingView: View {
	@AppStorage("isOnboarding") var isOnboarding = true

	var body: some View {
		TabView {
			ForEach(onboardingScreens.indices, id: \.self) { index in
				OnboardingScreenView(screenData: onboardingScreens[index])
			}
		}
		.tabViewStyle(PageTabViewStyle())
		.padding(.vertical, 20)
	}
}
