//
//  futureWeatherData.swift
//  WeatheerManager
//
//  Created by David Khachidze on 22.09.2022.
//

import Foundation


struct FutureWeatherData: Codable {
    
    let city: City
    let cnt: Int
    let list: [List]
}

struct City: Codable {
    let name: String
}

struct List: Codable {
    
    let temp: Temp
}

struct Temp: Codable {
    let day: Double
}
