//
//  HourlyWeatherView.swif
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import SwiftUI

struct HourlyWeatherView: View {
    @StateObject var hourlyWeatherStore = HourlyWeatherStore()
    @ObservedObject var user: User

    var body: some View {
        NavigationStack {
            if user.locationKey.isEmpty {
                NoWeatherDataView()
            } else {
                List(hourlyWeatherStore.hourlyWeather, id: \.epochDateTime) { weather in
                    NavigationLink(destination: HourDetailView(weather: weather)) {
                        HStack {
                            Image(systemName: weather.iconPhrase.contains("Sunny") ? "sun.max.fill" : "cloud.fill")
                                .foregroundColor(weather.iconPhrase.contains("Sunny") ? .yellow : .gray)
                            VStack(alignment: .leading) {
                                Text(weather.iconPhrase)
                                Text("\(String.formatAsInteger(weather.temperature)) \(weather.temperatureUnit)")
                            }
                        }
                    }
                }
                .navigationTitle("Hourly Weather")
                .toolbar {
                    Button("Refresh") {
                        hourlyWeatherStore.loadWeatherData(locationKey: user.locationKey)
                    }
                }
            }
        }
        .onChange(of: user.locationKey) { oldValue, newValue in
            if oldValue != newValue && !newValue.isEmpty {
                Task {
                    await MainActor.run {
                        hourlyWeatherStore.loadWeatherData(locationKey: newValue)
                    }
                }
            }
        }
    }
}
