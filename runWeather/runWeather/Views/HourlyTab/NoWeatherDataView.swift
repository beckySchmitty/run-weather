//
//  NoWeatherDataView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import SwiftUI

struct CircularEffect: GeometryEffect {
	var position: CGFloat

	// This function will calculate the x and y offsets to simulate circular movement
	func effectValue(size: CGSize) -> ProjectionTransform {
		let radius = min(size.width, size.height) / 4
		let xValue = radius * cos(position * 2 * .pi)
		let yValue = radius * sin(position * 2 * .pi)

		return ProjectionTransform(CGAffineTransform(translationX: xValue, y: yValue))
	}
}

struct NoWeatherDataView: View {
	@State private var position: CGFloat = 0
	let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()

	var body: some View {
		GeometryReader { geometry in
			VStack {
				Image(systemName: "cloud.sun.fill")
					.resizable()
					.scaledToFit()
					.frame(width: 100, height: 100)
					.modifier(CircularEffect(position: position))
					.onReceive(timer) { _ in
						withAnimation(.linear(duration: 0.02)) {
							position = (position + 0.005).truncatingRemainder(dividingBy: 1)
						}
					}
				Text("Update your profile to see the weather forecast")
					.font(.title)
			}
			.frame(width: geometry.size.width, height: geometry.size.height)
			.background(Color("backgroundBlue").edgesIgnoringSafeArea(.all))
		}
	}
}
