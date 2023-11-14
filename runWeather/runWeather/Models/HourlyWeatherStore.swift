//
//  HourlyWeatherStore.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import Foundation

import Foundation

func fetchHourlyWeather(locationKey: String) {
    let urlString = "http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/\(locationKey)?apikey=\(apiKey)"
    guard let url = URL(string: urlString) else {
        print("Invalid URL")
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error fetching data: \(error)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Invalid response from server")
            return
        }
        
        guard let data = data else {
            print("No data received")
            return
        }
        
        do {
            let weatherDataArray = try JSONDecoder().decode([HourlyWeatherData].self, from: data)
            // Handle the decoded data (e.g., update UI)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    task.resume()
}

//TODO: Error handling instead of print()

