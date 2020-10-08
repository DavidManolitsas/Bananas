//
//  TimerViewController.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Winnie Siwan on 20/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController, UIPopoverPresentationControllerDelegate{

    var seconds = 10
    // create global variable of timer
    var timer = Timer()
    // audio player for the alarm
    var audioPlayer = AVAudioPlayer()

    var durations = 10
    
    private var songList = getSongList()
    var receivedSong:String = ""
    
    @IBOutlet weak var popBtn: UIBarButtonItem!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var slideOutlet: UISlider!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet var blurview: UIVisualEffectView!
    
    @IBOutlet weak var breaktimeLabel: UILabel!
    var source : PopViewController?
    var breakduration:Int = 0
    var alarmName = "alarm"
    
    private var timerVM = TimerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set size of blurview to equal
        // the size of overall view
        blurview.bounds = super.view.bounds
        
    }
    
    // convert for printing label
    func convertSeconds(sec:Int) -> String{
        let minutesCount = seconds / 60
        let secondsCount = seconds % 60
        var minutesText = "\(minutesCount)"
        var secondsText = "\(secondsCount)"
        
        if (minutesCount < 10){
            minutesText = "0\(minutesCount)"
        }
        if (secondsCount < 10){
            secondsText = "0\(secondsCount)"
        }
        
        return "\(minutesText):\(secondsText)"
    }
 
    
    @IBAction func slider(_ sender: UISlider) {
        //convert float to int
        seconds = Int(sender.value)
        
        timeLabel.text = convertSeconds(sec: seconds)
    }
    
    @IBAction func startTimer(_ sender: Any) {
        durations = seconds
        
        timerVM.updateRecords(breakduration,durations,alarmName)
        
        // make sure timer only starts if duration more than 0
        if(seconds > 0){
            // create timer
            // selector, you define class where the function sits
            // currently we use ViewController.
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.counter), userInfo: nil, repeats: true)
            
            setStartState()
            setupAudioPlayer()

        }
    }
    
    @objc func counter(){
        if(seconds > 0){
            // minus by one second
            seconds -= 1
            timeLabel.text = convertSeconds(sec: seconds)
        }
        
        if (seconds == 0 && breakduration != 0){
            audioPlayer.play()
            breaktimeLabel.text = "Break Time"
            seconds = breakduration
        }
        
        
        // check if seconds are zero
        // if its true stop timer
        if (seconds == 0 && breakduration == 0)
        {
            timer.invalidate()
            setStopState()
            audioPlayer.play()
        }
    }
    
    @IBAction func stopTimer(_ sender: Any) {
        // stop the timer
        timer.invalidate()

        
        // update the seconds
        seconds = 3600
        slideOutlet.setValue(3600, animated: true)
        timeLabel.text = "60:00"
        
       setStopState()
       
        audioPlayer.stop()
       
    }
    
    private func setStartState(){
        // disable slider when timer starts and hide the start button
        // show the stop button
        slideOutlet.isEnabled = false;
        startBtn.isHidden = true;
        startBtn.isEnabled = false;
        stopBtn.isHidden = false;
        stopBtn.isEnabled = true;
    }
    
    private func setStopState(){
        // enable slider again and show start button again
        // hide the stop button
        slideOutlet.isEnabled = true;
        startBtn.isHidden = false;
        startBtn.isEnabled = true;
        stopBtn.isHidden = true;
        stopBtn.isEnabled = false;
        
        breaktimeLabel.text = ""
    }
    
    func getDuration()-> Int {
        return durations;
    }

    
    private func setupAudioPlayer(){
        do{
            let audioPath = Bundle.main.path(forResource: receivedSong, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }
        catch{
            //ERROR
        }
    }
    
    // for the pop overs
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPopover"
                {
                    let popoverViewController = segue.destination
                    popoverViewController.popoverPresentationController?.delegate = self
                    
                  super.preferredContentSize = CGSize(width:300, height:300)
                    
                    source = segue.destination as? PopViewController
  
                    
                    popoverViewController.popoverPresentationController?.sourceView = self.view
                    
                    popoverViewController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 300, height: 300)
                    
                   blurview.bounds = super.view.bounds

                }
        
    }
    
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
       // get the modified song from popover
        self.receivedSong = source!.songText

         // get the modified break duration from popover
        self.breakduration = source!.durationText*60
        self.alarmName = source!.labelField.text ?? "Alarm"

        animateOut(desiredView: blurview)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.preferredContentSize = self.view.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize)
    }
    
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        animateIn(desiredView: blurview)
        
    }
    
   func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    func animateIn(desiredView : UIView){
        let backgroundView = self.view
        
        // attach desired view to screen
        backgroundView?.addSubview(desiredView)
        
        //set scaling to 120%
        desiredView.transform = CGAffineTransform(scaleX: 1.2 , y: 1.2)
        desiredView.alpha = 0
        
        // animate the effect
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0 , y: 1.0)
            desiredView.alpha = 0.6
            desiredView.center = backgroundView!.center
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

