//
//  ReminderDate.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by David Manolitsas on 8/10/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

struct ReminderDate {
    var date:Date?
    
    init() {
        
    }
    
    
    func formatted(as format:String = "dd-MM-yyyy") -> String? {
        guard let date = self.date else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
        
    }
}
