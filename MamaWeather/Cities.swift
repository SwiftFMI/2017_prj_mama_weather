//
//  Cities.swift
//  MamaWeather
//
//  Created by Boyan Vushkov on 9.02.18.
//  Copyright © 2018 Boyan Vushkov. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct City {
    let name: String
    let country: String
    let id: Int
}

class Cities {
    private var trie = Trie<City>()
    private var cities: [String] = []
    
    public static let list = Cities()
    private init() {}
    
    func load(then callback: @escaping () -> Void) {
        DispatchQueue.global().async { [weak self] in
            let asset = NSDataAsset(name: "Cities", bundle: Bundle.main)
            if let data = asset?.data {
                if let jsonObj = try? JSON(data: data) {
                    for city in jsonObj.arrayValue {
                        let cityData = City(name: city["name"].stringValue, country: city["country"].stringValue, id: city["id"].intValue)
                        self?.trie.insert(word: city["name"].stringValue, associatedData: cityData)
                    }
                    self?.cities = self?.trie.starting(with: "") ?? []
                }
            }
            DispatchQueue.main.async {
                callback()
            }
        }
    }
    
    var isEmpty: Bool {
        return cities.isEmpty
    }
    
    var count: Int {
        return cities.count
    }
    
    func at(_ index: Int) -> String {
        return cities[index]
    }
    
    func data(at index: Int) -> City? {
        return trie.data(for: at(index))
    }
    
    func search(`for` word: String, then callback: @escaping () -> Void) {
        DispatchQueue.global().async { [weak self] in
            self?.cities = self?.trie.starting(with: word) ?? []
            
            DispatchQueue.main.async {
                callback()
            }
        }
        
    }
}
