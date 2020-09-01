//
//  PopViewController.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Winnie Siwan on 22/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import UIKit


class PopViewController: UIViewController{
    
    var labelText:String = "Alarm"
    var durationText:Int = 0
    var songText:String = "1"
    private var songList = getSongList()

    @IBOutlet weak var labelField: UITextField!
    @IBOutlet weak var breakToggle: UISwitch!
    @IBOutlet weak var songPicker: UIPickerView!
    @IBOutlet weak var userInputStack: UIStackView!
    @IBOutlet weak var durationPicker: UIPickerView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //initialise song pickerview content
        songPicker.dataSource = self
        songPicker.delegate = self
        
        //initialise break duration pickerview content
        durationPicker.dataSource = self
        durationPicker.delegate = self
        
       super.preferredContentSize = CGSize(width: 300, height: 300)

    }

    
    
    // if user make changes on the labelField
    @IBAction func changeLabelField(_ sender: UITextField) {
        labelText = labelField.text!
        print(labelField.text!)
    }
    
    
    // only allow user to select duration if
    // the breaktime toggle is on
    // reset duration if the break toggle is off
    @IBAction func checkToggle(_ sender: UISwitch) {
        if(sender.isOn == true){
            print("break toggle is on")
            durationPicker.isUserInteractionEnabled = true
        }
        else{
             print("break toggle is off")
            durationPicker.isUserInteractionEnabled = false
            durationText = 0
        }
    }

    func getLabelText() -> String{
        return labelText
    }
    
    func getDuration() -> Int{
        return durationText
    }
    
    func getSongTitle() -> String{
        print("getSongTitle method is invoked \(String(describing: songText))")
        return songText
    }
    
    func setSongTitle(name : String){
        songText = name
    }

    
}
// for song picker view
extension PopViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var value:Int = 0
        if(pickerView.tag == 1){
            value = BreakDuration.allCases.count
        }
        if(pickerView.tag == 2){
            value = songList.count
        }
        
        return value
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        if(pickerView.tag == 1){
            durationText = Int(BreakDuration.allCases[row].rawValue)!
            print("duration selected \(durationText)")
        }
        if(pickerView.tag == 2){
            songText = songList[row]
           
            
        }
        
       
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        if(pickerView.tag == 1){
            return BreakDuration.allCases[row].rawValue
        }
        if(pickerView.tag == 2){
            return songList[row]
        }
        
        return "none"
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{

        return 40
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat{
        return 120
    }
    
 
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "Myanmar Sangam MN", size: 13)
            pickerLabel?.textAlignment = NSTextAlignment.right
        }

        
        if(pickerView.tag == 1){
             pickerLabel?.text = BreakDuration.allCases[row].rawValue
        }
        if(pickerView.tag == 2){
             pickerLabel?.text = songList[row]
        }
        
        return pickerLabel!;
    }
    
    
    
}

