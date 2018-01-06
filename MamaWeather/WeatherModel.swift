//
//  WeatherModel.swift
//  MamaWeather
//
//  Created by Maria Bozhkova on 12/30/17.
//  Copyright © 2017 Boyan Vushkov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherModel {
    
    
    
    static func perform() {
        Alamofire.request("https://api.openweathermap.org/data/2.5/weather?id=727011&APPID=0609d3e39368852f624e4cc1aee10c19").responseJSON { response in
            switch response.result {
            case .success(let value):
                print("SUCCESS")
                print(value)
            case .failure(let error):
                print("ERROR")
                print(error)
            }
        }
    }
}
