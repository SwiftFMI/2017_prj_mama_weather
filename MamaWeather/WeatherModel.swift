//
//  WeatherModel.swift
//  MamaWeather
//
//  Created by Nikki Gyurova on 10.02.18.
//  Copyright © 2018 Boyan Vushkov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherModel {
    var city: String?
    var description: String?
    var temperature: Double?
    var time: Date?

    init(city: String, description: String, temperature: Double) {
        self.city   = city
        self.description = description
        self.temperature  = temperature
    }
    
    init(city: String, description: String, temperature: Double, millis: Double) {
        self.city   = city
        self.description = description
        self.temperature  = temperature
        self.time = Date(timeIntervalSince1970: millis)
    }
}
