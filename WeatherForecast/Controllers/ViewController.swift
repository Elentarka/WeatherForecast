//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Olga on 10/04/2018.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var weatherCollection: UICollectionView!
    
    var location: Location = Location(lat: Constants.defaultLat, lon: Constants.defaultLon)
    var weatherData: [DayWeather] = []
    
    let reuseCellIdentifier = "DayCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // init weather day cell
        let nibCell = UINib(nibName: "DayWeatherCell", bundle:nil)
        weatherCollection.register(nibCell, forCellWithReuseIdentifier: reuseCellIdentifier)
        weatherCollection.dataSource = self
        weatherCollection.delegate = self
        weatherCollection.isUserInteractionEnabled = true
        
        setCurrentLocation()
        WeatherProvider.sharedInstance.loadData(for: self.location, weatherAvailableCallback: onWeatherDataAvailable)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCurrentLocation() {
        let locationManager = CLLocationManager()
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        }
        if let loc = locationManager.location {
            print("Current location \(loc.coordinate.latitude),\(loc.coordinate.longitude)")
            self.location = Location(lat: loc.coordinate.latitude, lon: loc.coordinate.longitude)
        } else {
            print("No location available")
        }
    }
    
    func onWeatherDataAvailable(weatherData: [DayWeather]?, success: Bool) {
        if let data = weatherData, data.count > 0, success {
            print("Weather data successfully loaded")
            self.weatherData = data
            self.weatherCollection.reloadData()
        } else if let data = weatherData, data.count == 0, success {
            print("No data found for specified location")
        } else {
            print("Error loading data")
        }
    }
    
    //MARK: CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let indx = indexPath.row
        print("cell for index \(indx)")
        let cell: DayWeatherCellView = weatherCollection.dequeueReusableCell(withReuseIdentifier: reuseCellIdentifier, for: indexPath) as! DayWeatherCellView
        //cell.backgroundColor = UIColor.blue
    
        cell.setData(weather: weatherData[indx])
        
        return cell as UICollectionViewCell
    }
}

