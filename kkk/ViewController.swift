//
//  ViewController.swift
//  kkk
//
//  Created by kerwin on 10/8/20.
//  Copyright © 2020 kerwin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

class timerController: UIViewController {
    var counts = 3600
    var timer = Timer()
    
    @IBOutlet weak var labelTimer: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var popBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popBtn.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        popBtn.layer.cornerRadius = 0.5 * popBtn.bounds.size.width
       
        labelTimer.frame = CGRect(x: 80, y: 280, width: 300, height: 100)
        labelTimer.layer.masksToBounds = true
        labelTimer.layer.cornerRadius = 10
        labelTimer.layer.borderWidth = 4
        labelTimer.layer.borderColor = UIColor.lightGray.cgColor
        setupGestures()
    }
    
    
    @IBAction func slider(_ sender: UISlider) {
        counts = Int(sender.value)
        labelTimer.text = String(counts)
    }
    
    @IBAction func startButton(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerController.updateTimer), userInfo: nil, repeats: true)
    }
    
    func btnFunc() {
        
        startButton.setTitle("Start", for: .normal)
        if startButton.currentTitle == "Start"{
            startButton.setTitle("Stop", for: .normal)
        } else {
            startButton.setTitle("Start", for: .normal)
        }
    }
    
    @IBAction func stopButton(_ sender: Any) {
        timer.invalidate()
        counts = 3600
        slider.setValue(3600, animated: true)
        labelTimer.text = "1:00"
    }
    @objc func updateTimer() {
        counts -= 1
        // labelTimer.text = String(counts)
        let minutes = (counts % 3600) / 60
        let seconds = counts % 60
        let hours = counts / 3600
        var minutesText = "\(minutes)"//minutes < 10 ? "0\(minutes)" : "\(minutes)"
        var secondsText = "\(seconds)"//seconds < 10 ? "0\(seconds)" :"\(seconds)"
        var hoursText = "\(hours)"//hours < 10 ? "0\(hours)" :"\(hours)"
        
        if minutes < 10 {
            minutesText = "0\(minutes)"
        }
        
        if seconds < 10 {
            secondsText = "0\(seconds)"
        }
        
        if hours < 10 {
            hoursText = "0\(hours)"
        }
        labelTimer.text = "\(hoursText):\(minutesText):\(secondsText)"
        
        if counts == 0{
            timer.invalidate()
        }
    }
    
    private func setupGestures(){
        
        let tapGestures = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGestures.numberOfTapsRequired = 1
        popBtn.addGestureRecognizer(tapGestures)
        
    }
    
    @objc private func tapped(){
        
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "popVC")
            else { return }
        popVC.modalPresentationStyle = .popover
        
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.popBtn
        popOverVC?.sourceRect = CGRect(x: self.popBtn.bounds.midX, y: self.popBtn.bounds.minY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 250, height: 250)
        
        self.present(popVC, animated: true)
    }
    
}

extension timerController: UIPopoverPresentationControllerDelegate{
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

class moodController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

class profileController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var profileView: UITableView!
    let profile = ["David Manolitsas",
                 "Jessica Cui",
                 "Peng Xiong",
                 "Winnie Siwan"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.delegate = self
        profileView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        let profileData = profile[indexPath.row]
        cell.textLabel?.text = profileData
        return cell
    }
    
    
}
