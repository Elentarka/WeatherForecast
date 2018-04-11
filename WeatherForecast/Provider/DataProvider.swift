//
//  DataProvider.swift
//  WeatherForecast
//
//  Created by Olga on 11/04/2018.
//

import Foundation

protocol DataProvider {
    func readData(location: Location, dataAvailableCallback: @escaping (_ data: Data?, _ success: Bool) -> Void)
}
