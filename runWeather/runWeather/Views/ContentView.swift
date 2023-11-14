//
//  ContentView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import SwiftUI

struct ContentView: View {
    let user = User()
    
    var body: some View {
        ZStack {
            TabView {
                Group {
                    HourlyWeatherView()
                }
                .tabItem {
                    Label("Hourly", systemImage: "clock")
                }
                Group {
                    ProfileView(user: user)
                }
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
