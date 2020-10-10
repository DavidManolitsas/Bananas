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
    
    private (set) var location: String = "No location data"
    
    private let recordFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"DailyMoodRecord")
    
    public func updateNotes(_ notes: String, _ date: String) {
        if entityDoesExistFor(date: date) {
            updateRecordEntity(attribute:notes, keyPath: "notes", datePredicate: date)
        } else {
            createNSDailyMoodRecord(date, "None", notes)
        }
        
    }
    
    public func updateMood(_ mood: String, _ date: String) {
        if entityDoesExistFor(date: date) {
            updateRecordEntity(attribute: mood, keyPath: "mood", datePredicate: date)
        } else {
            createNSDailyMoodRecord(date, mood, "")
        }
        
    }
    
    // given only a location, either create a database entity without any of the other attributes or update an existing one
    public func updateWeatherLocation(_ location: String, _ date: String) {
        self.location = location
        
        if entityDoesExistFor(date: date) {
            do {
                let predicate = NSPredicate(format: "%K == %@", "date", date)
                recordFetchRequest.predicate = predicate
                
                let result = try managedContext.fetch(recordFetchRequest)
                records = result as! [DailyMoodRecord]
                
                if (records.count != 0) {
                    
                    records[0].weather?.setValue(self.location, forKey: "location")
                }
                
            } catch let error as NSError {
                print("*** Retrieving from database error: \(error), \(error.userInfo)")
            }
        } else {
            let weather = createNSWeather(minTemp: 0.0, maxTemp: 0.0, iconName: "transparent", location: self.location, feelsLike: 0.0, sunriseTime: "00:00", sunsetTime: "00:00")
            createNSDailyMoodRecord(date, Moods.none.rawValue, "", weather)
        }
        
        saveToDatabase(errorMsg: "error saving update")
    }
    
    // given full weather details, either create or update an entry
    public func updateWeatherDetails(_ date: String, _ minTemp: Double, _ maxTemp: Double, _ iconName: String, _ feelsLike: Double, _ sunriseTime: String, _ sunsetTime: String) {
        
        let nsWeather = createNSWeather(minTemp: minTemp, maxTemp: maxTemp, iconName: iconName, location: self.location, feelsLike: feelsLike, sunriseTime: sunriseTime, sunsetTime: sunsetTime)
        if entityDoesExistFor(date: date) {
            
            do {
                let predicate = NSPredicate(format: "%K == %@", "date", date)
                recordFetchRequest.predicate = predicate
                
                let result = try managedContext.fetch(recordFetchRequest)
                records = result as! [DailyMoodRecord]
                
                if (records.count != 0) {
                    records[0].setValue(nsWeather, forKeyPath: "weather")
                }
                
            } catch let error as NSError {
                print("*** Retrieving from database error: \(error), \(error.userInfo)")
            }
            
        }  else {
            createNSDailyMoodRecord(date, Moods.none.rawValue, "", nsWeather)
        }
        saveToDatabase(errorMsg: "error saving update")
    }
    
    // check if given a date, a record exists
    public func retrieveRecordFor(date: String) {
        if (entityDoesExistFor(date: date)) {
            loadRecordFor(date)
        } else {
            record = nil
        }
    }
    
    // given a date, update a specific attribute
    private func updateRecordEntity(attribute: String, keyPath: String, datePredicate: String) {
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
    
    // create a mood entry without weather
    private func createNSDailyMoodRecord(_ date: String,_ mood: String,_ notes: String)  {
        let recordEntity = NSEntityDescription.entity(forEntityName: "DailyMoodRecord", in: managedContext)!
        let nsRecord = NSManagedObject(entity: recordEntity, insertInto: managedContext) as! DailyMoodRecord
        
        nsRecord.setValue(date, forKeyPath: "date")
        nsRecord.setValue(mood, forKeyPath: "mood")
        nsRecord.setValue(notes, forKeyPath: "notes")
        
        saveToDatabase(errorMsg: "error creating daily mood record w/o weather")
        
    }
    
    // create a mood entry with weather
    private func createNSDailyMoodRecord(_ date: String,_ mood: String,_ notes: String, _ weather: Weather) {
        let recordEntity = NSEntityDescription.entity(forEntityName: "DailyMoodRecord", in: managedContext)!
        let nsRecord = NSManagedObject(entity: recordEntity, insertInto: managedContext) as! DailyMoodRecord
        
        nsRecord.setValue(date, forKeyPath: "date")
        nsRecord.setValue(mood, forKeyPath: "mood")
        nsRecord.setValue(notes, forKeyPath: "notes")
        nsRecord.weather = weather
        saveToDatabase(errorMsg: "error creating daily mood record with weather")
        
    }
    
    private func initMockEntries() {
        let w1 = createNSWeather(minTemp: 30.0, maxTemp: 50.0, iconName: "50d", location: "Mock location", feelsLike: 102.00, sunriseTime: "5:43 am", sunsetTime: "6:01pm")
        let w2 = createNSWeather(minTemp: 40.0, maxTemp: 60.0, iconName: "01d", location: "Desert", feelsLike: 32.00, sunriseTime: "9:00 am", sunsetTime: "7:01pm")
        
        createNSDailyMoodRecord("28-09-20", Moods.great.rawValue, "Wow it's boiling hot today", w1)
        createNSDailyMoodRecord("10-09-20", Moods.awful.rawValue, "Humans weren't built to survive 60 degrees... I don't feel so good...", w2)
        
    }
    
    private func saveToDatabase(errorMsg: String) {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("\(errorMsg): \(error), \(error.userInfo)")
        }
    }
    
    private func createNSWeather(minTemp: Double, maxTemp: Double, iconName: String, location: String,feelsLike: Double,  sunriseTime: String, sunsetTime: String) -> Weather {
        let weatherEntity = NSEntityDescription.entity(forEntityName: "Weather", in: managedContext)!
        let nsWeather = NSManagedObject(entity: weatherEntity, insertInto: managedContext) as! Weather
        
        nsWeather.setValue(maxTemp, forKeyPath: "maxTemp")
        nsWeather.setValue(minTemp, forKeyPath: "minTemp")
        nsWeather.setValue(iconName, forKeyPath: "iconName")
        nsWeather.setValue(location, forKeyPath: "location")
        nsWeather.setValue(feelsLike, forKeyPath: "feelsLike")
        nsWeather.setValue(sunriseTime, forKeyPath: "sunriseTime")
        nsWeather.setValue(sunsetTime, forKeyPath: "sunsetTime")
        
        saveToDatabase(errorMsg: "error creating weather")
        return nsWeather
    }
    
    // retrieve a record based on a date key
    private func loadRecordFor(_ date: String) {
        do {
            let predicate = NSPredicate(format: "%K == %@", "date", date)
            recordFetchRequest.predicate = predicate
            
            let result = try managedContext.fetch(recordFetchRequest)
            records = result as! [DailyMoodRecord]
            record = records[0]
        } catch let error as NSError {
            print("*** Retrieving from database error: \(error), \(error.userInfo)")
        }
    }
    
    
    private func entityDoesExistFor(date: String) -> Bool {
        var results: [DailyMoodRecord] = []
        do {
            let predicate = NSPredicate(format: "%K == %@", "date", date)
            recordFetchRequest.predicate = predicate
            
            results = try managedContext.fetch(recordFetchRequest) as! [DailyMoodRecord]
            
        } catch let error as NSError {
            print("*** Retrieving from database error: \(error), \(error.userInfo)")
        }
        
        return results.count > 0
    }
    
    
}
