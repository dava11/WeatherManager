//
//  NetworkWeather.swift
//  WeatheerManager
//
//  Created by David Khachidze on 22.09.2022.
//

import Foundation

struct NetworkWeather {
    func fetchCurrentWeather(forCity city: String) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
           
            if let data = data {
                let dataString = String(data: data, encoding: .utf8)
                print(dataString!)
            }
        }
        task.resume()
    }
}
