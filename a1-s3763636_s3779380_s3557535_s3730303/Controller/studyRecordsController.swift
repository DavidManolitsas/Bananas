//
//  studyRecordsController.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by kerwin on 31/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import UIKit

class studyRecordsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var studyRecords2 = [records]()
    
    @IBOutlet weak var recordsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordsTableView.delegate = self
        recordsTableView.dataSource = self
        recordsTableView.rowHeight = 100
        recordsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyRecords2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recordsTableView.dequeueReusableCell(withIdentifier: "recordsCell", for: indexPath) as! recordsViewCell
        
        let sr = studyRecords2[indexPath.row]
        cell.timeline.image = UIImage(named:"timeline.png")
        cell.breakLabel.text = "\((sr.breaktime)/60) minutes of break"
        cell.titleLabel.text = sr.title
        cell.timerLabel.text = "\((sr.timer)/60) minutes of study"
        
        return cell
        
    }
    
}
