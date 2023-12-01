//
//  HourDetailView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//
import SwiftUI

struct HourDetailView: View {
	let weather: HourlyWeather

	@Environment(\.horizontalSizeClass)
	var horizontalSizeClass
	@Environment(\.verticalSizeClass)
	var verticalSizeClass

	var isLandscape: Bool {
		horizontalSizeClass == .regular && verticalSizeClass == .compact
	}

	var body: some View {
		ScrollView {
			VStack {
				Spacer()
				VStack(alignment: .leading, spacing: 20) {
					//					Landscape
					if isLandscape {
						HStack(alignment: .top, spacing: 20) {
							HourDetailHeaderView(weather: weather).frame(width: 200)
							ScrollView(.vertical) {
								HourDetailCardsGridView(weather: weather)
							}
						}
						//						Portrait
					} else {
						ScrollView {
							HourDetailHeaderView(weather: weather)
							HourDetailCardsGridView(weather: weather)
						}
					}
				}
				.padding()
				.frame(maxWidth: .infinity, alignment: .leading)
				.background(Color("hourDetail"))
				.cornerRadius(20)
				.padding(.horizontal)
				Spacer()
			}
		}
		.navigationBarTitleDisplayMode(.inline)
	}
}
