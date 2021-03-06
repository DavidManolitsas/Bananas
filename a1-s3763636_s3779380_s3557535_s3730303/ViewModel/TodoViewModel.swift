//
//  TodoViewModel.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by David Manolitsas on 26/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

struct TodoViewModel {
    
    private var model = TodoList.shared
    
    var count:Int {
        return model.tasks.count
    }
    
    
    mutating func getNextId() -> Int {
        if model.tasks.count == 0 {
            return 1
        }
        
        var max:Int = model.tasks[0].id
        
        for task in model.tasks {
            if task.id > max {
                max = task.id
            }
        }
        
        // increment maxId number by 1
        max += 1;
        print(max)
        return max;
    }
    
    mutating func updateTaskReminder(index: Int, isOn: Bool) {
        model.tasks[index].reminderOn = isOn
        model.sortTasks()
        
        model.updateReminder(task: model.tasks[index])
    }
    
    
    mutating func updateReminderDate(index: Int, date: Date) {
        model.tasks[index].reminder.date = date
        model.sortTasks()
        
        model.updateReminder(task: model.tasks[index])
    }
    
    
    mutating func updatePriority(index: Int, priority: TaskPriority) {
        model.tasks[index].priority = priority
        model.sortTasks()
        
        model.updateCoreDataPriority(task: model.tasks[index])
    }
    
    
    func getTask(byIndex index: Int) -> Task {
        return model.tasks[index]
    }
    
    mutating func updateTaskCompletion(task: Task) {
        model.updateCompletionCoreData(task: task)
        model.sortTasks()
    }
    
    mutating func removeTask(at: Int) {
        let taskID = model.tasks[at].id
        model.tasks.remove(at: at)
        model.deleteCoreDataTask(taskID: taskID)
    }
    
    mutating func addTask(task: Task) {
        model.addTask(insertedTask: task)
        model.sortTasks()
    }
    
    
    mutating func refreshTodoList() {
        model.sortTasks()
    }
    
}




