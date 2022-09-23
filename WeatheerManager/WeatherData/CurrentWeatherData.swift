//
//  CurrentWeatherData.swift
//  WeatheerManager
//
//  Created by David Khachidze on 22.09.2022.
//

import Foundation

struct CurrentWeatherData: Codable {
    let name: String
    let main: Main
    
}

struct Main: Codable {
    let temp: Double
}
