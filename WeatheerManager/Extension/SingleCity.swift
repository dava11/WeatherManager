//
//  SingleCity.swift
//  WeatheerManager
//
//  Created by David Khachidze on 26.09.2022.
//

import Foundation

struct SingleCity: Codable {
    
    var city: String?
    var temp: Double?
    
    func saveData() {
        if let singleCityEncoded = try? PropertyListEncoder().encode(self) {
            UserDefaults.standard.set(singleCityEncoded, forKey: "singleCity")
        }
    }
    static func getData() -> SingleCity {
        var city = SingleCity()
        if let data = UserDefaults.standard.object(forKey: "singleCity") as? Data {
            if let decodedCity = try? PropertyListDecoder().decode(SingleCity.self, from: data) {
                city = decodedCity
            }
        }
        return city
    }
}
