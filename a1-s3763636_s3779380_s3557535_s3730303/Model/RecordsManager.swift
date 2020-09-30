//
//  RecordsManager.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by kerwin on 30/9/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RecordsManager{
    private (set) var record:[Records] = [] {
        willSet{
            
        }
    }
    
    static let tracker = RecordsManager()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let context : NSManagedObjectContext
    
    init(){
        context = appDelegate.persistentContainer.viewContext
    }
    
    private func createNsRecords(_ breaktime:Int, timer:Int, title:String)->Records{
        
        let recordsEntity = NSEntityDescription .entity(forEntityName: "Records" , in: context)!
        
        let nsRecords = NSManagedObject(entity: recordsEntity, insertInto: context) as! Records
        
        nsRecords.setValue(breaktime, forKeyPath:"breaktime" )
        nsRecords.setValue(timer, forKeyPath:"timer")
        nsRecords.setValue(title, forKeyPath:"title")
        return nsRecords
    }
    
    func addRecords(breaktime:Int, timer:Int, title:String){
        let nsRecords = createNsRecords(breaktime, timer: timer, title: title)
        record.append(nsRecords)
        do{
            try context.save()
        } catch let error as NSError{
            print("could nort save \(error), \(error.userInfo)")
        }
    }
}
