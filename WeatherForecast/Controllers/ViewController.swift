//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Olga on 10/04/2018.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, WeatherDataProviderDelegate {
    
    @IBOutlet weak var weatherCollection: UICollectionView!
    
    var location: Location?
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
        
        WeatherProvider.sharedInstance.delegate = self
        WeatherProvider.sharedInstance.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Data provider delegate
    func onWeatherDataAvailable(data: [DayWeather]) {
        self.weatherData = data
        self.weatherCollection.reloadData()
    }
    
    //MARK: CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weatherData.count
    }
    
    /*func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 3
    }*/
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let indx = indexPath.row
        print("cell for index \(indx)")
        let cell: DayWeatherCellView = weatherCollection.dequeueReusableCell(withReuseIdentifier: reuseCellIdentifier, for: indexPath) as! DayWeatherCellView
        cell.backgroundColor = UIColor.white
        
        cell.setData(weather: weatherData[indx])
        
        return cell as UICollectionViewCell
    }
}

