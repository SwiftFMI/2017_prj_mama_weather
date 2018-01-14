//
//  CitySearchCell.swift
//  MamaWeather
//
//  Created by Boyan Vushkov on 6.01.18.
//  Copyright © 2018 Boyan Vushkov. All rights reserved.
//

import UIKit

class CitySearchCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
