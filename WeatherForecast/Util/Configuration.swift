//
//  Configuration.swift
//  WeatherForecast
//
//  Created by Olga on 10/04/2018.
//

import Foundation

class Configuration {
    static let sharedInstance : Configuration = Configuration()
    
    //init default values
    var serverUrl: String = "https://3mypq17dkk.execute-api.eu-central-1.amazonaws.com/testing"
    var apiKey: String = "pJHFbhCxY29tGBpQK1Zlf4NMdkdkKhFI6iYVymeJ" 
    
    private init() {
        //read config parameters from plist file
        if let keyFilePath = Bundle.main.path(forResource: "config", ofType: "plist"),
            let dict = (NSDictionary(contentsOfFile: keyFilePath) as? [String: Any]) {
            if let url = dict["server_url"] as? String {
                self.serverUrl = url
            } else {
                print("No server URL in configuration")
            }
            if let key = dict["api_key"] as? String {
                self.apiKey = key
            } else {
                print("No API key in configuration")
            }
        }
    }
}
