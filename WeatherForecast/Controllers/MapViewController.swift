//
//  MapViewController.swift
//  WeatherForecast
//
//  Created by Olga on 12/04/2018.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var chosenLocation: CLLocationCoordinate2D?
    let tappedPin = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        
        // Center map to user location
        if let chosenLocation = chosenLocation {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(chosenLocation, CLLocationDistance(Constants.mapRegionSize), CLLocationDistance(Constants.mapRegionSize))
            mapView.setRegion(coordinateRegion, animated: true)
            
            // Set pin for last chosen location
            mapView.removeAnnotation(tappedPin)
            tappedPin.coordinate = chosenLocation
            tappedPin.title = "\(chosenLocation.latitude);\(chosenLocation.longitude)"
            mapView.addAnnotation(tappedPin)
        }
        
        // Setup map tap action
        let mapTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapRecognized(_:)))
        mapTapRecognizer.numberOfTapsRequired = 1
        mapView.addGestureRecognizer(mapTapRecognizer)
    }
    
    @objc func tapRecognized(_ gestureReconizer: UITapGestureRecognizer){
        let touchLocation = gestureReconizer.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        chosenLocation = locationCoordinate
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        
        mapView.removeAnnotation(tappedPin)
        tappedPin.coordinate = locationCoordinate
        let latStr = String(format:"%.2f", locationCoordinate.latitude)
        let lonStr = String(format:"%.2f", locationCoordinate.longitude)
        tappedPin.title = "\(latStr);\(lonStr)"
        mapView.addAnnotation(tappedPin)
    }
}
