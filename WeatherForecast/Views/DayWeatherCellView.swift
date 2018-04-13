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
        weatherIcon.image = UIImage(named: String(weather.weatherType))
        weatherLabel.text = weather.weatherText
        temprLabel.text = "\(weather.temperature)°"
        preciptLabel.text = "\(weather.precipitation)%"
        
        self.layer.cornerRadius = 20.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        self.layer.shadowRadius = 20.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.contentView.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        self.setNeedsDisplay()
    }
    
}
