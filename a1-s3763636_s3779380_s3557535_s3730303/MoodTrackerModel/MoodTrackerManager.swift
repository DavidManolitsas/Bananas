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
        initMockEntries()
    }
    
    private let recordFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"DailyMoodRecord")
    
    public func updateNotes(_ notes: String, _ date: String) {
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
    
    public func updateMood(_ mood: String, _ date: String) {
        // if exists a record at that date, fetch and save
        if entityDoesExistFor(date: date) {
            print("updating an existing entity with mood: " + mood)
            updateEntity(attribute: mood, keyPath: "mood", datePredicate: date)
        } else {
            // create new
            print("creating a new entity for date: \(date)")
            _ = createNSDailyMoodRecord(date, mood, "")
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
        
        saveToDatabase(errorMsg: "error saving update")
    }
    
    
    //    // called from viewModel
    //    public func addRecord(date: String,mood: String,notes: String, maxTemp: Double, minTemp: Double, iconName: String, lat: Double, lon: Double) {
    //
    //        let nsWeather = createNSWeather(maxTemp, minTemp, iconName, lat, lon)
    //        let nsRecord = createNSDailyMoodRecord(date, mood, notes)
    //        //        let nsRecord = createNSDailyMoodRecord(date, mood, notes, nsWeather)
    //        records.append(nsRecord)
    //
    //        do {
    //            try managedContext.save()
    //        } catch let error as NSError {
    //            print("*** Saving to database error: \(error), \(error.userInfo)")
    //        }
    //    }
    
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
    
    private func createNSDailyMoodRecord(_ date: String,_ mood: String,_ notes: String, _ weather: Weather) {
        let recordEntity = NSEntityDescription.entity(forEntityName: "DailyMoodRecord", in: managedContext)!
        let nsRecord = NSManagedObject(entity: recordEntity, insertInto: managedContext) as! DailyMoodRecord
        
        nsRecord.setValue(date, forKeyPath: "date")
        nsRecord.setValue(mood, forKeyPath: "mood")
        nsRecord.setValue(notes, forKeyPath: "notes")
        nsRecord.weather = weather
        
        //        return nsRecord
        
    }
    
    private func initMockEntries() {
        let w1 = createNSWeather(50.0, 30.0, "50d", "Mock location")
        let w2 = createNSWeather(60.0, 40.0, "01d", "desert")
        
        createNSDailyMoodRecord("22-09-20", Moods.great.rawValue, "Wow it's boiling hot today", w1)
        createNSDailyMoodRecord("10-09-20", Moods.awful.rawValue, "Humans weren't built to survive 60 degrees... I don't feel so good... ooft", w2)
        
        saveToDatabase(errorMsg: "saving ")
    }
    
    private func saveToDatabase(errorMsg: String) {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("\(errorMsg): \(error), \(error.userInfo)")
        }
    }
    
    private func createNSWeather(_ maxTemp: Double,_  minTemp: Double, _ iconName: String, _ location: String) -> Weather {
        
        let weatherEntity = NSEntityDescription.entity(forEntityName: "Weather", in: managedContext)!
        let nsWeather = NSManagedObject(entity: weatherEntity, insertInto: managedContext) as! Weather
        
        nsWeather.setValue(maxTemp, forKeyPath: "maxTemp")
        nsWeather.setValue(minTemp, forKeyPath: "minTemp")
        nsWeather.setValue(iconName, forKeyPath: "iconName")
        nsWeather.setValue(location, forKeyPath: "location")
        //        nsWeather.setValue(lat, forKeyPath: "lat")
        //        nsWeather.setValue(lon, forKeyPath: "lon")
        
        return nsWeather
    }
    //    private func createNSWeather(_ maxTemp: Double,_  minTemp: Double, _ iconName: String, _ lat: Double, _ lon: Double) -> Weather {
    //
    //        let weatherEntity = NSEntityDescription.entity(forEntityName: "Weather", in: managedContext)!
    //        let nsWeather = NSManagedObject(entity: weatherEntity, insertInto: managedContext) as! Weather
    //
    //        nsWeather.setValue(maxTemp, forKeyPath: "maxTemp")
    //        nsWeather.setValue(minTemp, forKeyPath: "minTemp")
    //        nsWeather.setValue(iconName, forKeyPath: "iconName")
    //        nsWeather.setValue(lat, forKeyPath: "lat")
    //        nsWeather.setValue(lon, forKeyPath: "lon")
    //
    //        return nsWeather
    //    }
    
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
            record = nil
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
