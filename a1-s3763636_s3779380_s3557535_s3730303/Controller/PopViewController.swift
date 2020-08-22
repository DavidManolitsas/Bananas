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

    @IBOutlet weak var labelField: UITextField!
    @IBOutlet weak var breakToggle: UISwitch!
    @IBOutlet weak var durationField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func changeLabelField(_ sender: UITextField) {
        labelText = labelField.text!
        print(labelField.text!)
    }
    
    func getLabelText() -> String{
        return labelText
    }
    

    
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
    
}
