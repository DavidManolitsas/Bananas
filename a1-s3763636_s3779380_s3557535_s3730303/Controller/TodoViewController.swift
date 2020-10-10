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
    
    private var viewModel = TodoViewModel()
    private var currDetail = TodoDetailController()
    
    
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
            
            let task = Task(id: self.viewModel.getNextId(), description: userInput)
            self.addTask(insertedTask: task)
            
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    func alertControllerBackgroundTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func addTask(insertedTask:Task) {
        viewModel.addTask(task: insertedTask)
        
        // Update view
        let index:Int = 0
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        tableView.reloadData()
    }
    
    
    func setTaskReminder(index: Int, isOn: Bool) {
        viewModel.updateTaskReminder(index: index, isOn: isOn)
        tableView.reloadData()
    }
    
    
    func setReminderDate(index: Int, date: Date) {
        viewModel.updateReminderDate(index: index, date: date)
        tableView.reloadData()
    }
    
    
    func setTaskPriority(index: Int, priority: TaskPriority) {
        viewModel.updatePriority(index: index, priority: priority)
        tableView.reloadData()
    }
    
    func checkboxChanged(task: Task) {
        viewModel.updateTaskCompletion(task: task)
    }
    
    
    func sortTasks() {
        viewModel.refreshTodoList()
        tableView.reloadData()
    }
}


extension TodoViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoCell
        let task = viewModel.getTask(byIndex: indexPath.row)
        
        cell.todoViewController = self
        cell.setTodoTask(task: task)
        cell.setReminder()
        cell.task = task
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeTask(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "TodoDetail") as? TodoDetailController {
            vc.task = viewModel.getTask(byIndex: (tableView.indexPathForSelectedRow?.row)!)
            vc.tableIndex = indexPath.row
            vc.tableViewController = self
            splitViewController?.showDetailViewController(vc, sender: nil)
        }
        
    }
    
    
}
