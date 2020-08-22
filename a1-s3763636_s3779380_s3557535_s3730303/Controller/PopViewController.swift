//
//  PopViewController.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Winnie Siwan on 22/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import UIKit

class PopViewController: UIViewController {
    var labelText:String = "Alarm"
    var durationText:Int = 0

    @IBOutlet weak var labelField: UITextField!
    @IBOutlet weak var breakToggle: UISwitch!
    @IBOutlet weak var durationField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // if user make changes on the labelField
    @IBAction func changeLabelField(_ sender: UITextField) {
        labelText = labelField.text!
        print(labelField.text!)
    }

    // only allow user to input duration if
    // the breaktime toggle is on
    @IBAction func checkToggle(_ sender: UISwitch) {
        if(breakToggle.isOn == true){
            print("break toggle is on")
            durationField.isUserInteractionEnabled = true
        }
        else{
             print("break toggle is off")
            durationField.isUserInteractionEnabled = false
        }
    }
    
    // if user make changes to the duration
    @IBAction func changeBreakDuration(_ sender: UITextField) {
        durationText = durationField.text
    }
    
    
    func getLabelText() -> String{
        return labelText
    }
    
    func getDuraton() -> Int{
        return durationText
    }
    
}
