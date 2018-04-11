//
//  DataProvider.swift
//  WeatherForecast
//
//  Created by Olga on 11/04/2018.
//

import Foundation

protocol DataProvider {
    func readData(dataAvailableCallback: (_ data: [DayWeather]) -> Void)
}
