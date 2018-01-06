//
//  WeatherView.swift
//  MamaWeather
//
//  Created by Maria Bozhkova on 12/30/17.
//  Copyright © 2017 Boyan Vushkov. All rights reserved.
//

import Foundation
import SwiftSVG
import UIKit

class WeatherView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let fistBump = UIView(SVGNamed: "rainy")     // In the main bundle
        self.addSubview(fistBump)
    }
}
