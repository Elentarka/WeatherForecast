//
//  DayWeatherCellView.swift
//  WeatherForecast
//
//  Created by Olga on 10/04/2018.
//

import Foundation
import UIKit

class DayWeatherCellView: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temprLabel: UILabel!
    @IBOutlet weak var preciptLabel: UILabel!
    
    func setData(weather: DayWeather) {
        dateLabel.text = weather.date.weatherDayString
        weatherIcon.image = UIImage(named: "\(weather.weatherType).pdf")
        weatherLabel.text = weather.weatherText
        temprLabel.text = "\(weather.temperature)°"
        preciptLabel.text = "\(weather.precipitation)%"
        
        self.setNeedsDisplay()
    }
    
}
