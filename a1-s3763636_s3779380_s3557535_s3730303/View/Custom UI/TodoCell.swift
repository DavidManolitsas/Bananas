//
//  TodoCell.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by David Manolitsas on 23/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var reminderLabel: UILabel!
    
    var task:Task?
    var todoViewController:TodoViewController?
    
    // Reminder symbol
    let reminderOn:String = "!"
    let reminderOff:String = ""
    
    func setTodoTask(task: Task) {
        self.task = task
        taskDescription.text = task.description
        reminderLabel.text = reminderOff
        setBackgroundColor()
    }
    
    @IBAction func checkboxClicked(_ sender: Any) {
        setCheckbox()
        setBackgroundColor()
    }
    
    func setReminder() {
        if let task = self.task {
            if task.reminderOn {
                reminderLabel.text = reminderOn
            } else {
                reminderLabel.text = reminderOff
            }
        }
    }
    
    func setCheckbox() {
        if let task = self.task {
            if task.completed {
                task.completed = false
                checkbox.setImage(UIImage(named: "checkBoxOUTLINE.png"), for: UIControl.State.normal)
            }
            else {
                task.completed = true
                checkbox.setImage(UIImage(named: "checkBoxFILLED.png"), for: UIControl.State.normal)
            }
        }
        
        todoViewController?.sortTasks()
    }
    
    func setBackgroundColor() {
        let taskPriority = task!.priority
        
        checkbox.setImage(UIImage(named: "checkBoxOUTLINE.png"), for: UIControl.State.normal)
        
        if self.task!.completed {
            self.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 0.5)
            checkbox.setImage(UIImage(named: "checkBoxFILLED.png"), for: UIControl.State.normal)
        } else if taskPriority == TaskPriority.none {
            self.backgroundColor = UIColor.clear
        } else if taskPriority == TaskPriority.low {
            self.backgroundColor = UIColor(red: 0.79, green: 0.80, blue: 0.64, alpha: 1.00)
        } else if taskPriority == TaskPriority.medium {
            self.backgroundColor = UIColor(red: 1.00, green: 0.88, blue: 0.66, alpha: 1.00)
        } else if taskPriority == TaskPriority.high {
            self.backgroundColor = UIColor(red: 0.94, green: 0.54, blue: 0.48, alpha: 1.00)
        }
        
        // UIColor(red: 0.79, green: 0.80, blue: 0.64, alpha: 1.00) (low)
        // UIColor(red: 1.00, green: 0.88, blue: 0.66, alpha: 1.00) (medium)
        // UIColor(red: 0.94, green: 0.54, blue: 0.48, alpha: 1.00) (high)
    }
    
}


