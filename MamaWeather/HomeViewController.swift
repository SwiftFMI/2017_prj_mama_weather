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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        checkLocationServicesAvailability()
        
        setupLocationManager()

        req.cityWeather(city: "Sofia") { weather in
            self.cityLabel.text = weather.city!
            self.weatherLabel.text = weather.description!
            self.temperatureLabel.text = String(weather.temperature!)
        }

        req.forecast(city: "Sofia") { weathers in
            for forecast in weathers {
                print(forecast.time, forecast.description)
            }
        }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
}
