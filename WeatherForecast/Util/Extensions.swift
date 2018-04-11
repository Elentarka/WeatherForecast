//
//  Extensions.swift
//  WeatherForecast
//
//  Created by Roman on 11/04/2018.
//

import Foundation

extension Date {
    var weatherDayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM"
        return dateFormatter.string(from: self)
    }
}
