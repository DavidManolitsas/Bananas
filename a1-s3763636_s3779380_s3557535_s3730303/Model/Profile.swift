//
//  Profile.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Winnie Siwan on 23/9/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

struct Profile{
    private var name: String
    private var avatarName: String
    private var favRecipe: String
    
    init(name:String, avatarName:String, favRecipe:String){
        self.name = name
        self.avatarName = avatarName
        self.favRecipe = favRecipe
    }
    
    func getProfileName() -> String{
        return name
    }
    
    func getAvatarName() -> String{
        return avatarName
    }
    
    func getFavRecipe() -> String{
        return favRecipe
    }
}
