//
//  Store.swift
//  MamaWeather
//
//  Created by Boyan Vushkov on 11.02.18.
//  Copyright © 2018 Boyan Vushkov. All rights reserved.
//

import Foundation
import Cache

class Store {
    public static let data = Store()
    
    func put<T: Codable>(_ object: T?, `for` key: String) {
        do {
            try storage?.setObject(object, forKey: key) ?? print("fail")
        }
        catch {
            print(error)
        }
    }
    
    func get<T: Codable>(type: T.Type, _ key: String) -> T? {
        if let object = try? storage?.object(ofType: T.self, forKey: key) {
            return object
        }
        return nil
    }
    
    private var storage: Storage?
    private let diskConfig = DiskConfig(
        name: "Mama",
        expiry: .date(Date().addingTimeInterval(2*3600)),
        // Maximum size of the disk cache storage (in bytes)
        maxSize: 10000,
        directory: nil,
        protectionType: nil
    )
    private init() {
        storage = try? Storage(diskConfig: diskConfig, memoryConfig: nil)
    }
    
}
