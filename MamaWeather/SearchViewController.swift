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
    
    private var filteredCities: [String] = []
    private var trie = Trie()

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !filteredCities.isEmpty else { return }
        reload(searchText: searchText)
//        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(SearchViewController.reload), object: nil)
//        self.perform(#selector(SearchViewController.reload), with: searchText, afterDelay: 0.3)
    }
    
    @objc func reload(searchText: String) {
        DispatchQueue.global().async { [weak self] in
            self?.filteredCities = self?.trie.starting(with: searchText) ?? []
            DispatchQueue.main.async { [weak self] in
                guard let this = self else { return }
                this.resultsTable.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        let asset = NSDataAsset(name: "Cities", bundle: Bundle.main)
        if let data = asset?.data {
            if let jsonObj = try? JSON(data: data) {
                for city in jsonObj.arrayValue {
                    trie.insert(word: city["name"].stringValue)
                }
                filteredCities = trie.starting(with: "")
                resultsTable.dataSource = self
            }
        }
    }
}

extension SearchViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = filteredCities[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "citySearchCell") as? CitySearchCell else {
            return UITableViewCell()
        }
        
        cell.cityLabel.text = city
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
}
