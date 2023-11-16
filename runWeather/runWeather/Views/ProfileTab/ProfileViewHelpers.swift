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
	var topLeft: CGFloat = 0.0
	var topRight: CGFloat = 0.0
	var bottomLeft: CGFloat = 0.0
	var bottomRight: CGFloat = 0.0
	
	func path(in rect: CGRect) -> Path {
		var path = Path()
		
		let width = rect.size.width
		let height = rect.size.height
		let tr = min(min(self.topRight, height/2), width/2)
		let tl = min(min(self.topLeft, height/2), width/2)
		let bl = min(min(self.bottomLeft, height/2), width/2)
		let br = min(min(self.bottomRight, height/2), width/2)
		
		path.move(to: CGPoint(x: width / 2.0, y: 0))
		path.addLine(to: CGPoint(x: width - tr, y: 0))
		path.addArc(center: CGPoint(x: width - tr, y: tr), radius: tr,
								startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
		path.addLine(to: CGPoint(x: width, y: height - br))
		path.addArc(center: CGPoint(x: width - br, y: height - br), radius: br,
								startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
		path.addLine(to: CGPoint(x: bl, y: height))
		path.addArc(center: CGPoint(x: bl, y: height - bl), radius: bl,
								startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
		path.addLine(to: CGPoint(x: 0, y: tl))
		path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
								startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
		path.closeSubpath()
		
		return path
	}
}
