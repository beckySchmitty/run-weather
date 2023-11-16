//
//  ProfileViewHelpers.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/15/23.
//

import SwiftUI

struct ProfileRow: View {
		let icon: String
		let title: String

		var body: some View {
				HStack {
						Image(systemName: icon)
								.foregroundColor(.blue)
						Text(title)
				}
		}
}

struct RoundedCorners: Shape {
		var topLeftRadius: CGFloat = 0.0
		var topRightRadius: CGFloat = 0.0
		var bottomLeftRadius: CGFloat = 0.0
		var bottomRightRadius: CGFloat = 0.0

		func path(in rect: CGRect) -> Path {
				var path = Path()

				let width = rect.size.width
				let height = rect.size.height
				let topRight = min(min(topRightRadius, height / 2), width / 2)
				let topLeft = min(min(topLeftRadius, height / 2), width / 2)
				let bottomLeft = min(min(bottomLeftRadius, height / 2), width / 2)
				let bottomRight = min(min(bottomRightRadius, height / 2), width / 2)

				path.move(to: CGPoint(x: width / 2.0, y: 0))
				path.addLine(to: CGPoint(x: width - topRight, y: 0))

				path.addArc(
						center: CGPoint(x: width - topRight, y: topRight),
						radius: topRight,
						startAngle: Angle(degrees: -90),
						endAngle: Angle(degrees: 0),
						clockwise: false
				)
				path.addLine(to: CGPoint(x: width, y: height - bottomRight))
				path.addArc(
						center: CGPoint(x: width - bottomRight, y: height - bottomRight),
						radius: bottomRight,
						startAngle: Angle(degrees: 0),
						endAngle: Angle(degrees: 90),
						clockwise: false
				)
				path.addLine(to: CGPoint(x: bottomLeft, y: height))
				path.addArc(
						center: CGPoint(x: bottomLeft, y: height - bottomLeft),
						radius: bottomLeft,
						startAngle: Angle(degrees: 90),
						endAngle: Angle(degrees: 180),
						clockwise: false
				)
				path.addLine(to: CGPoint(x: 0, y: topLeft))
				path.addArc(
						center: CGPoint(x: topLeft, y: topLeft),
						radius: topLeft,
						startAngle: Angle(degrees: 180),
						endAngle: Angle(degrees: 270),
						clockwise: false
				)
				path.closeSubpath()

				return path
		}
}
