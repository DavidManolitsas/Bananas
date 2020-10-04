//
//  Tasks.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by David Manolitsas on 26/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation
import CoreData
import UIKit


struct TodoList {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext: NSManagedObjectContext
    private var _tasks:[Task] = []
    
    var tasks:[Task] {
        get {
            return _tasks
        }
        set (newTasks) {
            _tasks = newTasks
        }
    
    }
    
    
    static let shared = TodoList()
    private init() {
        managedContext = appDelegate.persistentContainer.viewContext
        loadTasks()
        sortTasks()
    }
    
    
    public mutating func sortTasks() {
        //Bubble Sort
        for i in 0..<self.tasks.count {
            for j in 1..<tasks.count - i {
                if tasks[j].getTaskPriorityValue() < tasks[j-1].getTaskPriorityValue() {
                    let temp = tasks[j-1]
                    tasks[j-1] = tasks[j]
                    tasks[j] = temp
                }
            }
        }
        
    }
    

    public mutating func addTask(insertedTask: Task) {
        tasks.append(insertedTask)
        insertNSTask(task: insertedTask)
    }
    
    
    private mutating func loadTasks() {
        
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoTask")
            let result = try managedContext.fetch(fetchRequest)
            let nsTasks:[TodoTask] = result as! [TodoTask]
            
            print(nsTasks.count)
            
            for nsTask in nsTasks {
                
                print("Task ID:" + String(Int(nsTask.id)))
                let task:Task = Task(id: Int(nsTask.id), description: nsTask.taskDescription!)
                print("NS priority: \(nsTask.priority)")
                task.setPriorityFromNS(priorityValue: Int(nsTask.priority))
                task.completed = nsTask.completed
                
                _tasks.append(task)
            }
            
        }  catch let error as NSError {
            print("Could not save to database \(error), \(error.userInfo)")
        }
    }
    
    
    private func insertNSTask(task: Task) {
        
        let NSTaskEntity = NSEntityDescription.entity(forEntityName: "TodoTask", in: managedContext)!
        let NSTask = NSManagedObject(entity: NSTaskEntity, insertInto: managedContext) as! TodoTask
        
        NSTask.setValue(task.id, forKey: "id")
        NSTask.setValue(task.description, forKey: "taskDescription")
        NSTask.setValue(task.getInt64Priority(), forKey: "priority")
        NSTask.setValue(task.completed, forKey: "completed")
        //        NSTask.setValue(nil, forKey: "reminder")
        
        saveContext()
    }
    
    
    private func saveContext() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save to database \(error), \(error.userInfo)")
        }
    }
    
    func updateCompletionCoreData(task: Task) {
        do {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "TodoTask")
            let predicate = NSPredicate(format: "id = %ld", task.id)
            fetchRequest.predicate = predicate
            
            let foundTasks = try managedContext.fetch(fetchRequest) as! [TodoTask]
            foundTasks.first?.completed = task.completed
            
            saveContext()
            
        } catch {
            print("error updating!")
        }
    }
    
    func updateCoreDataPriority(task: Task) {
        do {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "TodoTask")
            let predicate = NSPredicate(format: "id = %ld", task.id)
            fetchRequest.predicate = predicate
            
            let foundTasks = try managedContext.fetch(fetchRequest) as! [TodoTask]
            foundTasks.first?.priority = task.getInt64Priority()
            
            saveContext()
            
        } catch {
            print("error updating!")
        }
        
    }
    
    
    func deleteCoreDataTask(taskID: Int) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoTask")
        let result = try? managedContext.fetch(fetchRequest)
        let nsTasks = result as! [TodoTask]
        
        for nsTask in nsTasks {
            if nsTask.id == taskID {
                managedContext.delete(nsTask)
            }
        }
        
        saveContext()
    }
    
}
