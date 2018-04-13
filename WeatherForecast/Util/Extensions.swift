//
//  Extensions.swift
//  WeatherForecast
//
//  Created by Olga on 11/04/2018.
//

import Foundation

extension Date {
    var weatherDayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.presentedDateFormat
        return dateFormatter.string(from: self)
    }
}
