//
//  TodoViewController.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by David Manolitsas on 19/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    var count = 0;
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    @IBAction func onAddClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        alert.addTextField { (taskTextField) in
            taskTextField.placeholder = "I want to..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {
            action in
            self.alertControllerBackgroundTapped()
        }))
        
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let userInput = alert.textFields?.first?.text else {
                return
            }
            print(userInput)
            
            let task = Task(description: userInput)
            
            if self.count == 1 {
                task.priority = TaskPriority.medium
            }
            
            if self.count == 2 {
                task.priority = TaskPriority.medium
            }
            
            if self.count == 3 {
                task.priority = TaskPriority.low
            }
            
            if self.count == 4 {
                task.priority = TaskPriority.high
            }
            
            
            self.addTask(task: task)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func addTask(task:Task) {
        // Testing
        count += 1
        
        self.tasks.insert(task, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    
        self.sortTasks()
    }
    
    func alertControllerBackgroundTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sortTasks() {
        var temp:Task
        
        for i in 0..<tasks.count {
            for j in 0..<tasks.count {
                if (tasks[i].priority.detail.value < tasks[j].priority.detail.value) {
                    temp = tasks[i]
                    tasks[i] = tasks[j]
                    tasks[j] = temp
                }
            }
        }
        
        tableView.reloadData()
    
    }
}

extension TodoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].description
        
        let taskPriority = tasks[indexPath.row].priority
        
        // UIColor(red: 0.79, green: 0.80, blue: 0.64, alpha: 1.00) (low)
        // UIColor(red: 1.00, green: 0.88, blue: 0.66, alpha: 1.00) (medium)
        // UIColor(red: 0.94, green: 0.54, blue: 0.48, alpha: 1.00) (high)
        
        if taskPriority == TaskPriority.none {
            cell.backgroundColor = UIColor.clear
        } else if taskPriority == TaskPriority.low {
            cell.backgroundColor = UIColor(red: 0.79, green: 0.80, blue: 0.64, alpha: 1.00)
        } else if taskPriority == TaskPriority.medium {
            cell.backgroundColor = UIColor(red: 1.00, green: 0.88, blue: 0.66, alpha: 1.00)
        } else if taskPriority == TaskPriority.high {
            cell.backgroundColor = UIColor(red: 0.94, green: 0.54, blue: 0.48, alpha: 1.00)
        }

        return cell
    }
}
