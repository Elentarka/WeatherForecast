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
    
    func loadData(for location: Location, weatherAvailableCallback: @escaping (_ weather: [DayWeather]?, Bool) -> Void){
        remoteProvider.readData(location: location, dataAvailableCallback:  { data, success  in
            print("Data available from remote server")
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
                        print("Parse JSON error \(parseError)")
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
