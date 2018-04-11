//
//  Location.swift
//  WeatherForecast
//
//  Created by Olga on 10/04/2018.
//

import Foundation

struct Location {
    var lat: Double
    var lon: Double
    var dictionary: [String: Any] {
        return ["lat": lat,
                "lon": lon]
    }
}
