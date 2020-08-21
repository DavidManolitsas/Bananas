//
//  TimerViewController.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Winnie Siwan on 20/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    var seconds = 10
    // create global variable of timer
    var timer = Timer()
    // audio player for the alarm
    var audioPlayer = AVAudioPlayer()
    // get song title
    var songText:String = "default"
    
    var durations = 0
    
    private var songList = getSongList()
    
    @IBOutlet weak var popBtn: UIBarButtonItem!
    
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var slideOutlet: UISlider!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet var blurview: UIVisualEffectView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set size of blurview to equal
        // the size of overall view
        blurview.bounds = self.view.bounds
    }
 
    
    @IBAction func slider(_ sender: UISlider) {
       
    }
    
    @IBAction func startTimer(_ sender: Any) {

    }
    
    @objc func counter(){
       
    }
    
    @IBAction func stopTimer(_ sender: Any) {
        
       
    }
    
    func getDuration()-> Int {
        return durations;
    }
    
    
    
    private func setupAudioPlayer(){
       
    }
    
    // for the pop overs
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPopover"
                {
                    let popoverViewController = segue.destination
                    popoverViewController.popoverPresentationController?.delegate = self
                }
        
    }
    
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        animateOut(desiredView: blurview)
    }
    
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        animateIn(desiredView: blurview)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
       
        return .none
        
    }
    
    func animateIn(desiredView : UIView){
        let backgroundView = self.view
        
        // attach desired view to screen
        backgroundView?.addSubview(desiredView)
        
        // set darker color
        backgroundView?.backgroundColor = .darkGray
        
        //set scaling to 120%
        desiredView.transform = CGAffineTransform(scaleX: 1.2 , y: 1.2)
        desiredView.alpha = 0
        
        // animate the effect
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0 , y: 1.0)
            desiredView.alpha = 0.6
            desiredView.center = backgroundView!.center
            //            desiredView.backgroundColor = .black
        })
    }
    
    func animateOut(desiredView : UIView){
        // animate the effect
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.2 , y: 1.2)
            desiredView.alpha = 0
        }, completion: { _ in
            desiredView.removeFromSuperview()
            
        })
    }
    
    
    
    

}

// for picker view
extension TimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return songList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        songTitle.text = songList[row]
        songText = songList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return songList[row]
    }
    
    
}
