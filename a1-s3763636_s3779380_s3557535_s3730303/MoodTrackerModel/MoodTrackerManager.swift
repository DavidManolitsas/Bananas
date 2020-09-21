//
//  MoodTrackerManager.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Jess Cui on 20/9/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MoodTrackerManager {
    private (set) var records: [DailyMoodRecord] = []
        private (set) var record: DailyMoodRecord?
    
    static let shared = MoodTrackerManager()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext: NSManagedObjectContext
    
    private init() {
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    private let recordFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"DailyMoodRecord")
    
    public func addNotes(_ notes: String, _ date: String) {
        // if exists a record at that date, fetch and save
        if entityDoesExistFor(date: date) {
            print("updating an existing entity with notes: " + notes)
            updateEntity(attribute:notes, keyPath: "notes", datePredicate: date)
        } else {
            // create new
            print("creating a new entity for date: \(date)")
            _ = createNSDailyMoodRecord(date, "None", notes)
        }
        
    }
    
    private func updateEntity(attribute: String, keyPath: String, datePredicate: String) {
        do {
            let predicate = NSPredicate(format: "%K == %@", "date", datePredicate)
            recordFetchRequest.predicate = predicate
            
            let result = try managedContext.fetch(recordFetchRequest)
            records = result as! [DailyMoodRecord]
            
            if (records.count != 0) {
                records[0].setValue(attribute, forKeyPath: keyPath)
            }
            
        } catch let error as NSError {
            print("*** Retrieving from database error: \(error), \(error.userInfo)")
        }
        
        do {
            try managedContext.save()
            print("apparently saved")
        } catch let error as NSError {
            print("*** updating entity database error: \(error), \(error.userInfo)")
        }
    }
    
    
    // called from viewModel
    public func addRecord(date: String,mood: String,notes: String, maxTemp: Double, minTemp: Double, iconName: String, lat: Double, lon: Double) {
        
        let nsWeather = createNSWeather(maxTemp, minTemp, iconName, lat, lon)
        let nsRecord = createNSDailyMoodRecord(date, mood, notes)
        //        let nsRecord = createNSDailyMoodRecord(date, mood, notes, nsWeather)
        records.append(nsRecord)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("*** Saving to database error: \(error), \(error.userInfo)")
        }
    }
    
    //    private func createNSDailyMoodRecord(_ date: String,_ mood: String,_ notes: String, _ weather: Weather) -> DailyMoodRecord {
    private func createNSDailyMoodRecord(_ date: String,_ mood: String,_ notes: String) -> DailyMoodRecord {
        let recordEntity = NSEntityDescription.entity(forEntityName: "DailyMoodRecord", in: managedContext)!
        let nsRecord = NSManagedObject(entity: recordEntity, insertInto: managedContext) as! DailyMoodRecord
        
        nsRecord.setValue(date, forKeyPath: "date")
        nsRecord.setValue(mood, forKeyPath: "mood")
        nsRecord.setValue(notes, forKeyPath: "notes")
        //        nsRecord.weather = weather
        
        return nsRecord
        
    }
    
    private func createNSWeather(_ maxTemp: Double,_  minTemp: Double, _ iconName: String, _ lat: Double, _ lon: Double) -> Weather {
        
        let weatherEntity = NSEntityDescription.entity(forEntityName: "Weather", in: managedContext)!
        let nsWeather = NSManagedObject(entity: weatherEntity, insertInto: managedContext) as! Weather
        
        nsWeather.setValue(maxTemp, forKeyPath: "maxTemp")
        nsWeather.setValue(minTemp, forKeyPath: "minTemp")
        nsWeather.setValue(iconName, forKeyPath: "iconName")
        nsWeather.setValue(lat, forKeyPath: "lat")
        nsWeather.setValue(lon, forKeyPath: "lon")
        
        return nsWeather
    }
    
    private func loadRecordFor(_ date: String) {
        do {
            // creates the query request
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"DailyMoodRecord")
            let predicate = NSPredicate(format: "%K == %@", "date", date)
            recordFetchRequest.predicate = predicate
            
            let result = try managedContext.fetch(recordFetchRequest)
            records = result as! [DailyMoodRecord]
            record = records[0]
//            print("this is the notes saved: \(record!.notes!)")
        } catch let error as NSError {
            print("*** Retrieving from database error: \(error), \(error.userInfo)")
        }
    }
    
    public func retrieveRecordFor(date: String) {
        if (entityDoesExistFor(date: date)) {
            print("exists an entity at \(date)")
            loadRecordFor(date)
        } else {
            print("no record, cannot retrieve")
        }
    }
    
    private func entityDoesExistFor(date: String) -> Bool {
         var results: [Any] = []
        do {
            // creates the query request
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"DailyMoodRecord")
            let predicate = NSPredicate(format: "%K == %@", "date", date)
            recordFetchRequest.predicate = predicate
            
             results = try managedContext.fetch(recordFetchRequest)
//            records = result as! [DailyMoodRecord]
            
        } catch let error as NSError {
            print("*** Retrieving from database error: \(error), \(error.userInfo)")
        }
        
        return results.count > 0
    }
    
    
}
