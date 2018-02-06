//
//  SearchViewController.swift
//  MamaWeather
//
//  Created by Maria Bozhkova on 12/30/17.
//  Copyright © 2017 Boyan Vushkov. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsTable: UITableView!
    
    fileprivate var cities: JSON?
    fileprivate var filteredCities: JSON?

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard cities != nil else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let cities = self?.cities! {
                self?.filteredCities = JSON(cities.arrayValue.filter {
                    $0["name"].stringValue.range(of: searchText) != nil
                })
            }
//            DispatchQueue.main.async { [weak self] in
//                self?.resultsTable.reloadData()
//            } work it around!!!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        let asset = NSDataAsset(name: "Cities", bundle: Bundle.main)
        if let data = asset?.data {
            if let jsonObj = try? JSON(data: data) {
                cities = jsonObj
                filteredCities = cities
                resultsTable.dataSource = self
                //resultsTable.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SearchViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = filteredCities?[indexPath.row]
        let cityName = city?["name"].stringValue
        let countryCode = city?["country"].stringValue
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "citySearchCell") as? CitySearchCell else {
            return UITableViewCell()
        }
        
        cell.cityLabel.text = cityName ?? ""
        cell.countryLabel.text = countryCode ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
