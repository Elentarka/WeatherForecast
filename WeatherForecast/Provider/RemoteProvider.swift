//
//  RemoteProvider.swift
//  WeatherForecast
//
//  Created by Olga on 11/04/2018.
//

import Foundation

class RemoteProvider: DataProvider {
    
    func readData(location: Location, dataAvailableCallback: @escaping (Data?, Bool) -> Void) {
        let urlString = Configuration.sharedInstance.serverUrl
        guard let url = URL(string: urlString) else {
            print("Invalid URL \(urlString)")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        // set headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Configuration.sharedInstance.apiKey, forHTTPHeaderField: Constants.apiKeyHeader)
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: location.dictionary, options: [])
        } catch{
            print("Error serializing to JSON body \(error.localizedDescription)")
            return
        }
        // use DataTask to load data from server
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            dataAvailableCallback(data, (data != nil && error == nil))
        })
        task.resume()
    }
}
