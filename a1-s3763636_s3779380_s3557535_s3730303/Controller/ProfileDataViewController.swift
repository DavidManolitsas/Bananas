//
//  ProfileDataViewController.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Winnie Siwan on 22/9/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import UIKit

class ProfileDataViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet var displayAvatar: UIImageView!
    
    
    var avatarName:String = "dAvatar"
    var displayText:String?
    var dataIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = displayText
        
       displayAvatar.image = UIImage(named: avatarName)
    }
    


}
