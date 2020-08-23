//
//  profileViewController.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by kerwin on 24/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import UIKit

class profileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var profile: UITableView!
    private var profileText = getProfile()
    override func viewDidLoad() {
        super.viewDidLoad()
        profile.delegate = self
        profile.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        let profileData = profileText[indexPath.row]
        cell.textLabel?.text = profileData
        return cell
    }
}

