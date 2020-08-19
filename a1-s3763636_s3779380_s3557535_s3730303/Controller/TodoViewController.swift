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
            self.addTask(task: task)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func addTask(task:Task) {
        self.tasks.insert(task, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func alertControllerBackgroundTapped() {
        self.dismiss(animated: true, completion: nil)
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
        
        return cell
    }
}
