//
//  WeatherProvider.swift
//  WeatherForecast
//
//  Created by Olga on 10/04/2018.
//

import Foundation

class WeatherProvider {
    static let sharedInstance : WeatherProvider = WeatherProvider()
    
    private var localProvider: LocalProvider = LocalProvider()
    private var remoteProvider: RemoteProvider = RemoteProvider()
    
    private init() {
        
    }
    
    func loadData(for location: Location, weatherAvailableCallback: @escaping (_ weather: [DayWeather]?, Bool) -> Void){
        /*let mockData: [DayWeather] = [
            DayWeather(date: Date(), temperature: 1.0, precipitation: 0.5, weatherType: "02n", weatherText: "Cloudy"),
            DayWeather(date: Date(), temperature: 10.0, precipitation: 0.1, weatherType: "26n", weatherText: "Rain"),
            DayWeather(date: Date(), temperature: -5.0, precipitation: 0.99, weatherType: "45n", weatherText: "Snow")
        ]
        self.delegate?.onWeatherDataAvailable(data: mockData)*/
        //with: request, completionHandler: {data, response, error in
        remoteProvider.readData(location: location, dataAvailableCallback:  { data, success  in
            print("Data available from remote")
            var weatherData:[DayWeather] = []
            if success {
                if let data = data,
                    let result = String(data: data, encoding: .utf8) {
                    print(result)
                    
                    do {
                        if let parsedJson = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any] {
                            for obj in parsedJson {
                                if let obj = obj as? [String:Any],
                                    let parsedObj = DayWeather(with: obj) {
                                    weatherData.append(parsedObj)
                                }
                            }
                        }
                    } catch let parseError {
                        print(parseError)
                    }
                }
            } else {
                print("Error loading weather data")
            }
            DispatchQueue.main.async {
                weatherAvailableCallback(weatherData, success)
            }
        })
    }
}
