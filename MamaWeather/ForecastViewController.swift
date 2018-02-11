//
//  ForecastViewController.swift
//  MamaWeather
//
//  Created by Nikki Gyurova on 11.02.18.
//  Copyright © 2018 Boyan Vushkov. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: UIViewController {
    let req = Request()
    private var cityId: Int?
    private var forecast: [WeatherModel] = []
    @IBOutlet weak var forecastTable: UITableView!
    @IBOutlet weak var cityName: UILabel!
    
    func setSelectedCity(_ city: City) {
        cityId = city.id
        forecast(for: cityId ?? 519188) // ???
    }
    
    func forecast(`for` cityId: Int) {
        req.forecast(id: cityId) { weather in
            self.cityName.text = weather.first?.city
            self.forecast = weather
            self.forecastTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        forecast(for: cityId ?? 519188)
        forecastTable.dataSource = self
    }
}

extension ForecastViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let w = self.forecast[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell")
        cell?.textLabel?.text = String(describing: w.temperature!)
        cell?.detailTextLabel?.text = w.description!

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecast.count
    }
}
