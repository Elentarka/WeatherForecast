//
//  RemoteProvider.swift
//  WeatherForecast
//
//  Created by Olga on 11/04/2018.
//

import Foundation

class RemoteProvider: DataProvider {
    
    init() {
        
    }
    
    func readData(dataAvailableCallback: ([DayWeather]) -> Void) {
        let urlString = "https://3mypq17dkk.execute-api.eu-central-1.amazonaws.com/testing"
        var request = URLRequest(url: URL(string:urlString)!)
        
        request.httpMethod = "POST"
        // set headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("pJHFbhCxY29tGBpQK1Zlf4NMdkdkKhFI6iYVymeJ",forHTTPHeaderField: "x-api-key")
        
        // set the request-body(JSON)
        let params: [String: Any] = [
            "lat": 59.6,
            "lon": 36.1
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        } catch{
            print(error.localizedDescription)
        }
        // use NSURLSessionDataTask
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            if (error == nil) {
                let result = String(data: data!, encoding: .utf8)!
                print(result)
            } else {
                print(error!)
            }
        })
        task.resume()
    }
}
