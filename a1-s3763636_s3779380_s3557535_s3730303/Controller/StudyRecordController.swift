//
//  StudyRecordController.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by kerwin on 10/10/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import UIKit

class StudyRecordController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var studyRecords2 = [Records]()
    var rm = RecordsManager()
    var recordsModel = TimerViewModel()
    
    @IBOutlet weak var recordsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordsTableView.delegate = self
        recordsTableView.dataSource = self
        recordsTableView.rowHeight = UITableView.automaticDimension
        recordsTableView.estimatedRowHeight = 100
        recordsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        fetchRecords()
    }
    
    // get records from coredata
    func fetchRecords(){
        do {
            
            studyRecords2 = try rm.context.fetch(Records.fetchRequest())
            DispatchQueue.main.async {
                self.recordsTableView.reloadData()
            }
            
        }
        catch {
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyRecords2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recordsTableView.dequeueReusableCell(withIdentifier: "recordsCell", for: indexPath) as! RecordViewCell
        
        let sr = studyRecords2[indexPath.row]
        cell.timeline.image = UIImage(named:"timeline.png")
        cell.breakLabel.text = "\((sr.breaktime)/60) minutes of break"
        cell.titleLabel.text = sr.title
        cell.timerLabel.text = "\((sr.timer)/60) minutes of study"
        
        return cell
        
    }
    
    //add delete function
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // create the swip action
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action,view, completionHandler) in
            
            //remove the records
            self.recordsModel.deleteRecords(recordsTimer: indexPath.row)
            //reload the reocrds
            self.fetchRecords()
            
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}

