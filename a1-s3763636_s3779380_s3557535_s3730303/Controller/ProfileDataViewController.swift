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
    
    
    private var avatarName:String = "dAvatar"
    private var displayText:String?
    private var dataIndex:Int?
    private var recipe:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = displayText
        displayRecipe.text = recipe
       displayAvatar.image = UIImage(named: avatarName)
        displayAvatar.restorationIdentifier = avatarName
        
        displayRecipe.textAlignment = .center
    }
    
    public func setAvatarName(_name : String){
        avatarName = _name
    }
    
    public func setDisplayText(_text : String){
        displayText = _text
    }
    
    public func setRecipe(_recipe : String){
        recipe = _recipe
    }
    
    public func setDataIndex(_index : Int){
        dataIndex = _index
    }
    
    public func getIndex() -> Int{
        return dataIndex!
    }


}
