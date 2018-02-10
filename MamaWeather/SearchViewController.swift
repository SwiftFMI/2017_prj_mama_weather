//
//  SearchViewController.swift
//  MamaWeather
//
//  Created by Maria Bozhkova on 12/30/17.
//  Copyright © 2017 Boyan Vushkov. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsTable: UITableView!
    
    func reload(with word: String) {
        Cities.list.search(for: word, then: { [weak self] in
            self?.resultsTable.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == "cellClicked", let destination = segue.destination as? SearchParametersViewController, let indexPath = sender as? IndexPath {
            destination.selectedCity = Cities.list.data(at: indexPath.row)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Cities.list.load(then: { [weak self] in
            self?.resultsTable.reloadData()
        })

        searchBar.delegate = self
        resultsTable.dataSource = self
        resultsTable.delegate = self
    }
}

extension SearchViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "cellClicked", sender: indexPath)
    }
}

extension SearchViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange word: String) {
        guard !Cities.list.isEmpty else { return }
        reload(with: word)
    }
}

extension SearchViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = Cities.list.at(indexPath.row)

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "citySearchCell")
        cell?.textLabel?.text = city
        if let cityData = Cities.list.data(at: indexPath.row) {
            cell?.detailTextLabel?.text = cityData.country
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cities.list.count
    }
}
