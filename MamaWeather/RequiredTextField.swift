//
//  RequiredTextField.swift
//  MamaWeather
//
//  Created by Maria Bozhkova on 2/4/18.
//  Copyright © 2018 Boyan Vushkov. All rights reserved.
//

import UIKit

class RequiredTextField: UITextField {
    func isValid(`for` regex: String) -> Bool {
        if let wot = text, wot != "" {
            return true
        }
        if let placeholderText = placeholder {
            placeholder = placeholderText + " Required field!"
        }
        return false
    }
}
