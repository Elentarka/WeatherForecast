//
//  DayWeather.swift
//  WeatherForecast
//
//  Created by Olga on 10/04/2018.
//

import Foundation

struct DayWeather {
    var date: Date
    var temperature: Double
    var precipitation: Double
    var weatherType: Int
    var weatherText: String
    
    init?(with json: [String: Any]) {
        guard let dateValue = json["Date"] as? String,
            let temprtValue = json["Temperature"] as? Double,
            let preciptValue = json["Precipitation"] as? Double,
            let symbolValue = json["WeatherSymbol"] as? Int,
            let textValue = json["WeatherText"] as? String
            else {
                return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        //dateFormatter.locale = Locale(identifier: "en_US")
    
        self.date = dateFormatter.date(from: dateValue) ?? Date()
        self.temperature = temprtValue
        self.precipitation = preciptValue
        self.weatherType = symbolValue
        self.weatherText = textValue
    }
}
