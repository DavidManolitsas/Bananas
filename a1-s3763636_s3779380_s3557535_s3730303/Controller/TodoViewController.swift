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
    
    var todoViewModel = TodoViewModel()
    var currDetail = TodoDetail()
    var count = 0;

    
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
        todoViewModel.todoList.addTask(insertedTask: insertedTask)
        
        let index:Int = 0
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        self.sortTasks()
    }
    
    
    func setTaskReminder(currTask: Task, isOn: Bool) {
        todoViewModel.todoList.setTaskReminder(currTask: currTask, isOn: isOn)
        tableView.reloadData()
    }
    
    
    func setTaskPriority(searchedTask: Task, priority: TaskPriority) {
        todoViewModel.todoList.setTaskPriority(searchedTask: searchedTask, priority: priority)
        self.sortTasks()
    }
    
    
    func sortTasks() {
        todoViewModel.todoList.sortTasks()
        tableView.reloadData()
    }
}


extension TodoViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoViewModel.todoList.getTasks().count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoCell
        let task = todoViewModel.todoList.getTasks()[indexPath.row]
        
        cell.todoViewController = self
        cell.setTodoTask(task: task)
        cell.setReminder()
        cell.task = task
        

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            todoViewModel.todoList.removeTask(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "TodoDetail") as? TodoDetail {
            vc.task = todoViewModel.todoList.getTasks()[(tableView.indexPathForSelectedRow?.row)!]
            vc.tableViewController = self
            splitViewController?.showDetailViewController(vc, sender: nil)
        }
        
    }
    

}
