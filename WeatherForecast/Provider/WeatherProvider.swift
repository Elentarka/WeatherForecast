//
//  WeatherProvider.swift
//  WeatherForecast
//
//  Created by Olga on 10/04/2018.
//

import Foundation

class WeatherProvider {
    static let sharedInstance : WeatherProvider = WeatherProvider()
    var delegate: WeatherDataProviderDelegate?
    
    private var localProvider
    
    private init() {
        
    }
    
    func loadData(){
        let mockData: [DayWeather] = [
            DayWeather(date: Date(), temperature: 1.0, precipitation: 0.5, weatherType: "02n", weatherText: "Cloudy"),
            DayWeather(date: Date(), temperature: 10.0, precipitation: 0.1, weatherType: "26n", weatherText: "Rain"),
            DayWeather(date: Date(), temperature: -5.0, precipitation: 0.99, weatherType: "45n", weatherText: "Snow")
        ]
        self.delegate?.onWeatherDataAvailable(data: mockData)
    }
}
