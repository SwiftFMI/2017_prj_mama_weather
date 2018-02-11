//
//  InitialSettingViewController.swift
//  MamaWeather
//
//  Created by Maria Bozhkova on 1/14/18.
//  Copyright © 2018 Boyan Vushkov. All rights reserved.
//

import UIKit

class InitialSettingViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBAction func setName(_ sender: UITextField) {
        if let userName = sender.text {
            User.instance.name = userName
        }
    }
    
   
    @IBAction func maleButtonPressed(_ sender: UITapGestureRecognizer) {
        User.instance.gender = .male
    }
    
    @IBAction func femaleButtonPressed(_ sender: UITapGestureRecognizer) {
        User.instance.gender = .female
    }
    
    @IBAction func setAge(_ sender: UITextField) {
        if let userAge = sender.text {
            User.instance.age = Int(userAge) ?? 0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "showHomeScreen" {
            segue.perform()
        }
    }
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(InitialSettingViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
    }
}
