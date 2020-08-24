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
    var task:Task?
    
    
    func setTodoTask(task: Task) {
        
        self.task = task
        taskDescription.text = task.description
        
        let taskPriority = task.priority
        
        if taskPriority == TaskPriority.none {
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
    
    @IBAction func checkboxClicked(_ sender: Any) {
        if let task = self.task {
            if task.completed {
                task.completed = false
                checkbox.setImage(UIImage(named: "checkBoxOUTLINE.png"), for: UIControl.State.normal)
            }
            else {
                task.completed = true
                checkbox.setImage(UIImage(named: "checkBoxFILLED.png"), for: UIControl.State.normal)
            }
            
            print("task: \(task.description) is completed: \(task.completed) ")
        }
    }
    
}


