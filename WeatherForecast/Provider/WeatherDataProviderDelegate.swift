//
//  ProviderProtocol.swift
//  WeatherForecast
//
//  Created by Olga on 11/04/2018.
//

import Foundation

protocol WeatherDataProviderDelegate {
    func onWeatherDataAvailable(data: [DayWeather])
}
