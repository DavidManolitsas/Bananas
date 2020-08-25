//
//  TodoDetail.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by David Manolitsas on 24/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import UIKit

class TodoDetail: UIViewController {

    @IBOutlet weak var taskNameLabel: UILabel!
    var task:Task?
    var tableViewController:TodoViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskNameLabel.text = task?.description
    }
    
    @IBAction func lowPriorityClicked(_ sender: Any) {
        
        if task!.priority == TaskPriority.low {
            tableViewController!.setTaskPriority(searchedTask: task!, priority: TaskPriority.none)
        } else {
            tableViewController!.setTaskPriority(searchedTask: task!, priority: TaskPriority.low)
        }
    }
    
}
