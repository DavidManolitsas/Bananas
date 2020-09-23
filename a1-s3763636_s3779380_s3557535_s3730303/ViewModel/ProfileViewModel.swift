//
//  ProfileViewModel.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Winnie Siwan on 23/9/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

struct ProfileViewModel{
    var teamProfile = TeamProfile()
    
    public func getRecordsFromModel() -> [Profile]{
        return teamProfile.getPeople()
    }
    
}
