//
//  NetworkWeather.swift
//  WeatheerManager
//
//  Created by David Khachidze on 22.09.2022.
//

import Foundation

struct NetworkWeather {
    func fetchCurrentWeather(forCity city: String, complition: @escaping(CurrentWeatherData) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
           
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    if let weatherData = try? decoder.decode(CurrentWeatherData.self, from: data) {
                        complition(weatherData)
                    }
                }
            }
        }
        task.resume()
    }
    
    func futureCurrentWeather(forCity city: String, complition: @escaping(FutureWeatherData) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/forecast/daily?q=\(city)&cnt=7&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
           
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    if let weatherData = try? decoder.decode(FutureWeatherData.self, from: data) {
                        complition(weatherData)
                    }
                }
            }
        }
        task.resume()
    }
}
