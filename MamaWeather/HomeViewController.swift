//
//  HomeViewController.swift
//  MamaWeather
//
//  Created by Boyan Vushkov on 29.11.17.
//  Copyright © 2017 Boyan Vushkov. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Location.current.locationDidChange = { [weak self] in
            if let currentLocation = Location.current.location {
                self?.location = currentLocation
            }
        }
    }

    let req = Request()
    
    var cityId: Int? {
        didSet {
            getWeather(for: cityId ?? (Location.current.cityId ?? 519188))
        }
    }
    
    func getWeather(`for` cityId: Int) {
        req.cityWeather(id: cityId, result: updateUI)
    }
    
    func getWeather(at location: CLLocationCoordinate2D) {
        req.cityWeather(at: location, result: updateUI)
    }
    
    private var location: CLLocationCoordinate2D? {
        didSet {
            guard cityId == nil else { return }
            getWeather(at: location ?? CLLocationCoordinate2D())
            Location.current.stopMonitoring()
        }
    }
    
    private func updateUI(_ weather: WeatherModel) {
        self.cityLabel.text = weather.city!
        self.weatherLabel.text = weather.description!
        self.temperatureLabel.text = String(weather.temperature!)
    }
}


