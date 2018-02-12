//
//  Location.swift
//  MamaWeather
//
//  Created by Boyan Vushkov on 11.02.18.
//  Copyright © 2018 Boyan Vushkov. All rights reserved.
//

import Foundation
import CoreLocation

// Inherits NSObject because otherwise it cannot
// conform to the CLLocationManagerProtocol
class Location: NSObject {
    var cityId: Int?
    var location: CLLocationCoordinate2D?
    public static var current = Location()
    var locationDidChange: (() -> ())?
    
    func stopMonitoring() {
        locationManager.stopUpdatingLocation()
    }
    
    func startMonitoring() {
        setupLocationManager()
    }

    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocationCoordinate2D? {
        didSet {
            guard let location = currentLocation else {
                cityId = nil
                return
            }
            self.location = location
            if let callback = locationDidChange {
                callback()
            }
        }
    }
    override private init() {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        checkLocationServicesAvailability()
        setupLocationManager()
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
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
}

extension Location : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            currentLocation = lastLocation.coordinate
        }
    }
}

