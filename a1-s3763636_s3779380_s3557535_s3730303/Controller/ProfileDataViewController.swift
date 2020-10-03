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
    @IBOutlet var displayRecipe: UITextView!
    
    
    var avatarName:String = "dAvatar"
    var displayText:String?
    var dataIndex:Int?
    var recipe:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = displayText
        displayRecipe.text = recipe
       displayAvatar.image = UIImage(named: avatarName)
        displayAvatar.restorationIdentifier = avatarName
        
        displayRecipe.textAlignment = .center
    }
    


}
