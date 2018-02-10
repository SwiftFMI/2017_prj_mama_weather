//
//  SearchParametersViewController.swift
//  MamaWeather
//
//  Created by Boyan Vushkov on 10.02.18.
//  Copyright © 2018 Boyan Vushkov. All rights reserved.
//

import UIKit

struct SearchParameters {
    let cityID: Int
    let period: DateInterval
}

class SearchParametersViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    var selectedCity: City? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text = selectedCity?.name ?? cityLabel.text
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == "showCitySearch" {
            segue.perform()
        }
    }

}
