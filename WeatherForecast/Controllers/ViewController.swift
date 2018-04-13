//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Olga on 10/04/2018.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherCollection: UICollectionView!
    @IBOutlet weak var latEdit: UITextField!
    @IBOutlet weak var lonEdit: UITextField!
    @IBOutlet weak var changeLocationBtn: UIButton!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var location = CLLocationCoordinate2D(latitude: Constants.defaultLat, longitude: Constants.defaultLon) {
        didSet {
            print("Chosen location changed")
            updateCoordinateFields()
            displayLoading()
            WeatherProvider.sharedInstance.loadData(for: Location(lat: self.location.latitude, lon: self.location.longitude), weatherAvailableCallback: onWeatherDataAvailable)
        }
    }
    var weatherData: [DayWeather] = []
    let reuseCellIdentifier = "DayCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init weather day cell
        let nibCell = UINib(nibName: "DayWeatherCell", bundle:nil)
        weatherCollection.register(nibCell, forCellWithReuseIdentifier: reuseCellIdentifier)
        weatherCollection.dataSource = self
        weatherCollection.isUserInteractionEnabled = true
        
        displayLoading()
        
        //Load weather data for location
        setCurrentLocation()
        WeatherProvider.sharedInstance.loadData(for: Location(lat: self.location.latitude, lon: self.location.longitude), weatherAvailableCallback: onWeatherDataAvailable)
    }
    
    //Pass location to show on map
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mapViewController = segue.destination as? MapViewController {
            mapViewController.chosenLocation = self.location
        }
    }
    
    @IBAction func cancelUnwindAction(unwindSegue: UIStoryboardSegue) {
        print("cancelUnwindAction")
    }
    
    //Update chosen location on map exit
    @IBAction func selectUnwindAction(unwindSegue: UIStoryboardSegue) {
        print("selectUnwindAction")
        if let origin = unwindSegue.source as? MapViewController,
            let newLocation = origin.chosenLocation {
            location = newLocation
        }
    }
    
    func setCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        
        if let loc = locationManager.location {
            print("Current location \(loc.coordinate.latitude),\(loc.coordinate.longitude)")
            self.location = loc.coordinate
        } else {
            print("No location available")
        }
        updateCoordinateFields()
    }
    
    func updateCoordinateFields() {
        latEdit.text = String(format:"%.4f", self.location.latitude)
        lonEdit.text = String(format:"%.4f", self.location.longitude)
    }
    
    func displayLoading(){
        self.weatherCollection.isHidden = true
        errorLabel.isHidden = true
        self.loadingSpinner.startAnimating()
    }
    
    func stopLoading() {
        self.loadingSpinner.stopAnimating()
        self.weatherCollection.isHidden = false
    }
    
    func onWeatherDataAvailable(weatherData: [DayWeather]?, success: Bool) {
        stopLoading()
        if let data = weatherData, data.count > 0, success {
            print("Weather data successfully loaded")
            self.weatherData = data
            errorLabel.isHidden = true
            weatherCollection.isHidden = false
            self.weatherCollection.reloadData()
        } else {
            print("Error loading data")
            weatherCollection.isHidden = true
            errorLabel.isHidden = false
            errorLabel.text = "Error loading data"
        }
    }
}

//MARK: CollectionView
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let indx = indexPath.row
        let cell: DayWeatherCellView = weatherCollection.dequeueReusableCell(withReuseIdentifier: reuseCellIdentifier, for: indexPath) as! DayWeatherCellView
        cell.setData(weather: weatherData[indx])
        
        return cell as UICollectionViewCell
    }
}
