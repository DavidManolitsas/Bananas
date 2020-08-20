//
//  WeatherMoodTableViewCell.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Jess Cui on 20/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import UIKit

class WeatherMoodTableViewCell: UITableViewCell {


    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var dailyGreetingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
