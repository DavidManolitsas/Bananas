//
//  TeamProfile.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Winnie Siwan on 23/9/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

struct TeamProfile{
    private var people: [Profile] = []
    
    init(){
        initPeople()
    }
    
    private mutating func initPeople(){
        let profile1 = Profile(name: "David Manolitsas", avatarName: "dAvatar")
        let profile2 = Profile(name: "Jessica Cui", avatarName: "jAvatar")
        let profile3 = Profile(name: "Peng Xiong", avatarName: "pAvatar")
        let profile4 = Profile(name: "Winnie Siwan", avatarName: "wAvatar")
        
        people.append(contentsOf: [profile1, profile2, profile3, profile4])
    }
    
    func getPeople() -> [Profile]{
        return people
    }
    
}
