//
//  InitialSettingViewController.swift
//  MamaWeather
//
//  Created by Maria Bozhkova on 1/14/18.
//  Copyright © 2018 Boyan Vushkov. All rights reserved.
//

import UIKit

class InitialSettingViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: RequiredTextField!
    @IBOutlet weak var ageTextField: RequiredTextField!
    @IBAction func setName(_ sender: UITextField) {
        if let userName = sender.text {
            User.instance.name = userName
        }
    }
    
    @IBAction func genderButtonPressed(_ sender: UIButton) {
        if let gender = sender.currentTitle {
            switch(gender) {
                case "male": User.instance.gender = .male
                default: User.instance.gender = .female
            }
        }
    }
    
    @IBAction func setAge(_ sender: UITextField) {
        if let userAge = sender.text {
            User.instance.age = Int(userAge) ?? 0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "showHomeScreen",
            nameTextField.isValid(for: ""),
            ageTextField.isValid(for: ""){
            segue.perform()
        }
    }
}
