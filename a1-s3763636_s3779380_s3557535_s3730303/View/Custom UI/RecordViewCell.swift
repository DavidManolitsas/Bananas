//
//  RecordViewCell.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by kerwin on 10/10/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import UIKit

class RecordViewCell: UITableViewCell {

    @IBOutlet weak var timeline: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var breakLabel: UILabel!
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
