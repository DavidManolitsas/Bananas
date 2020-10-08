//
//  TodoDetail.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by David Manolitsas on 24/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import UIKit

class TodoDetailController: UIViewController {

    
    @IBOutlet weak var taskNameLabel: UILabel!
    private var _task:Task?
    var tableIndex:Int = 0
    private var _tableViewController:TodoViewController?
    
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var lowButton: UIButton!
    @IBOutlet weak var medButton: UIButton!
    @IBOutlet weak var highButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setReminderStatus()
        taskNameLabel.text = _task?.description
        loadPriorityStatus()
        
        if let date = self._task?.reminder.date {
            datePicker.date = date
        }
    }
    
    func setReminderStatus() {
        if let task = self._task {
            reminderSwitch.setOn(task.reminderOn, animated: false)
        }
    }
    
    @IBAction func reminderSwitchToggled(_ sender: Any) {
        if let tableView = self._tableViewController {
            if reminderSwitch.isOn {
                tableView.setTaskReminder(index: self.tableIndex, isOn: true)
            } else {
                tableView.setTaskReminder(index: self.tableIndex, isOn: false)
            }
        }

    }
    
    @IBAction func saveClicked(_ sender: Any) {
        if let tableView = self._tableViewController {
            if reminderSwitch.isOn {
                tableView.setReminderDate(index: self.tableIndex, date: datePicker.date)
            }
            else {
                tableView.setTaskReminder(index: self.tableIndex, isOn: false)
            }
        }
        
    }
    
    
    
    @IBAction func lowPriorityClicked(_ sender: Any) {
        if let task = self._task {
            if task.priority == TaskPriority.low {
                lowButton.setImage(UIImage(named: "lowOff"), for: UIControl.State.normal)
                _tableViewController!.setTaskPriority(index: self.tableIndex, priority: TaskPriority.none)
            } else {
                updatePriorityButtons(on: "low")
                _tableViewController!.setTaskPriority(index: self.tableIndex, priority: TaskPriority.low)
            }
        }
    }
    
    @IBAction func medPriorityClicked(_ sender: Any) {
        if let task = self._task {
            if task.priority == TaskPriority.medium {
                medButton.setImage(UIImage(named: "medOff"), for: UIControl.State.normal)
                _tableViewController!.setTaskPriority(index: self.tableIndex, priority: TaskPriority.none)
            } else {
                updatePriorityButtons(on: "medium")
                _tableViewController!.setTaskPriority(index: self.tableIndex, priority: TaskPriority.medium)
            }
        }
    }
    
    
    @IBAction func highPriorityClicked(_ sender: Any) {
        if let task = self._task {
            if task.priority == TaskPriority.high {
                highButton.setImage(UIImage(named: "highOff"), for: UIControl.State.normal)
                _tableViewController!.setTaskPriority(index: self.tableIndex, priority: TaskPriority.none)
            } else {
                updatePriorityButtons(on: "high")
                _tableViewController!.setTaskPriority(index: self.tableIndex, priority: TaskPriority.high)
            }
        }
    }
    
    func loadPriorityStatus() {
        if let task = self._task {
            if task.priority == TaskPriority.low {
                lowButton.setImage(UIImage(named: "lowOn"), for: UIControl.State.normal)
            } else if task.priority == TaskPriority.medium {
                medButton.setImage(UIImage(named: "medOn"), for: UIControl.State.normal)
            } else if task.priority == TaskPriority.high {
                highButton.setImage(UIImage(named: "highOn"), for: UIControl.State.normal)
            }
        }
    }
    
    func updatePriorityButtons(on: String) {
        if on == "high" {
            // Turn the high radio button on and the other two off
            highButton.setImage(UIImage(named: "highOn"), for: UIControl.State.normal)
            lowButton.setImage(UIImage(named: "lowOff"), for: UIControl.State.normal)
            medButton.setImage(UIImage(named: "medOff"), for: UIControl.State.normal)
        } else if on == "medium" {
            // Turn the medium radio button on and the other two off
            medButton.setImage(UIImage(named: "medOn"), for: UIControl.State.normal)
            lowButton.setImage(UIImage(named: "lowOff"), for: UIControl.State.normal)
            highButton.setImage(UIImage(named: "highOff"), for: UIControl.State.normal)
        } else if on == "low" {
            // Turn the low radio button on and the other two off
            lowButton.setImage(UIImage(named: "lowOn"), for: UIControl.State.normal)
            medButton.setImage(UIImage(named: "medOff"), for: UIControl.State.normal)
            highButton.setImage(UIImage(named: "highOff"), for: UIControl.State.normal)
        }
        
    }
    
    var task:Task {
        get {
            return _task!
        }
        set {
            _task = newValue
        }
    }
    
    var tableViewController:TodoViewController {
        get {
            return _tableViewController!
        }
        set {
            _tableViewController = newValue
        }
    }
    
}
