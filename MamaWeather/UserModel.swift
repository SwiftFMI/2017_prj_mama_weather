//
//  UserModel.swift
//  MamaWeather
//
//  Created by Maria Bozhkova on 2/3/18.
//  Copyright © 2018 Boyan Vushkov. All rights reserved.
//

import Foundation

class User {
    enum Gender {
        case male
        case female
    }
    
    var name: String
    var age: Int
    var gender: Gender
    
    private init() {
        self.name = ""
        self.age = 0
        self.gender = .female
    }
    public static let instance = User()
}
