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
    let locationManager = CLLocationManager()
    let req = Request()
    
    private var cityId: Int?
    
    func setSelectedCity(_ city: City) {
        cityId = city.id
        getWeather(for: cityId ?? 519188) // ???
    }
    
    func getWeather(`for` cityId: Int) {
        req.cityWeather(id: cityId) { weather in
            self.cityLabel.text = weather.city!
            self.weatherLabel.text = weather.description!
            self.temperatureLabel.text = String(weather.temperature!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        checkLocationServicesAvailability()
        
        setupLocationManager()

        getWeather(for: cityId ?? 519188) // ???
    }
    
    private func checkLocationServicesAvailability() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined: print("not determined. What to do?")
        case .authorizedWhenInUse: print("authorised when in use. Continue")
        case .denied: print("Not cool. Disallow location services. Save battery")
        default: print("Not cool. Disallow location services")
        }
    }
    
    private func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
    }
}

extension HomeViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
}
