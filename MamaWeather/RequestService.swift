//
//  RequestService.swift
//  MamaWeather
//
//  Created by Nikki Gyurova on 3.02.18.
//  Copyright © 2018 Boyan Vushkov. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

let key = "49cfa4744a39729412b528fbd633a3b6"

class Request {
    private func responseToWeatherModel(_ json: Any) -> WeatherModel {
        let dictionary = json as! [String: Any]
        
        let main = dictionary["main"] as! [String: Any]
        let temp = main["temp"] as! Double
        
        let weather = dictionary["weather"] as! [Any]
        let first = weather.first as! [String: Any]
        let desc = first["description"] as! String
        let name = dictionary["name"] as! String
        
        return WeatherModel(city: name, description: desc, temperature: temp)
    }
    func cityWeather(id: Int, result: @escaping ((WeatherModel) -> ())) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/weather?id=\(id)&appid=\(key)&units=metric")
            .responseJSON { response in
            if let json = response.result.value {
                // Internal screaming starts here
                // AAAAAAAAAAAAAAAA
                let weatherModel = self.responseToWeatherModel(json)
                result(weatherModel)
            }
        }
    }

    func cityWeather(at location: CLLocationCoordinate2D, result: @escaping (WeatherModel) -> ()) {
        let lat = location.latitude
        let lon = location.longitude
        Alamofire.request("https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(key)&units=metric")
            .responseJSON { response in
                if let json = response.result.value {
                    // Internal screaming starts here
                    // AAAAAAAAAAAAAAAA
                    let weatherModel = self.responseToWeatherModel(json)
                    result(weatherModel)
                }
        }
    }
    
    func forecast(id: Int, result: @escaping (([WeatherModel]) -> ())) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/forecast?id=\(id)&appid=" + key + "&units=metric").responseJSON { response in
            if let json = response.result.value {
                var w = [WeatherModel]()

                let dictionary = json as! [String: Any]
                let weather = dictionary["list"] as! [Any]
                for timeInterval in weather {
                    let timeInterval = timeInterval as! [String: Any]
                    
                    let main = timeInterval["main"] as! [String: Any]
                    let temp = main["temp"] as! Double
                    
                    let weather = timeInterval["weather"] as! [Any]
                    let first = weather.first as! [String: Any]
                    let desc = first["description"] as! String
                    
                    let city = dictionary["city"] as! [String: Any]
                    let name = city["name"] as! String
                    
                    let time = timeInterval["dt"] as! Double
                    
                    w.append(WeatherModel(city: name, description: desc, temperature: temp, millis: time))
                }
                
                result(w)
            }
        }
    }
}
