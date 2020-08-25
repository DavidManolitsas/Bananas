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
    
    var currDetail = TodoDetail()
    var count = 0;
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
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
            
            let task = Task(description: userInput)
            self.addTask(insertedTask: task)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    func alertControllerBackgroundTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func addTask(insertedTask:Task) {
        let index:Int = 0
        
        self.tasks.insert(insertedTask, at: index)
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        self.sortTasks()
    }
    
    func setTaskPriority(searchedTask: Task, priority: TaskPriority) {
        print("Setting task priority")
        
        for task in tasks {
            if task.description == searchedTask.description {
                task.priority = priority
            }
        }
        
        self.sortTasks()
    
    }
    
    
    func sortTasks() {
        var temp:Task
        
        // Sort the tasks array based on priority
        for i in 0..<tasks.count {
            for j in 0..<tasks.count {
                if (tasks[i].completed == false) {
                    if (tasks[i].getTaskPriorityValue() < tasks[j].getTaskPriorityValue()) {
                        temp = tasks[i]
                        tasks[i] = tasks[j]
                        tasks[j] = temp
                    }
                }
            }
        }
        
        tableView.reloadData()
    }
}


extension TodoViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoCell
        
        cell.todoViewController = self
        
        let task = tasks[indexPath.row]
        cell.setTodoTask(task: task)
        cell.task = task
        

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TodoDetail") as? TodoDetail
        vc!.task = tasks[(tableView.indexPathForSelectedRow?.row)!]
        vc!.tableViewController = self
        splitViewController?.showDetailViewController(vc!, sender: nil)
    }
    

}
