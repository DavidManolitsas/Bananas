//
//  TimerViewController.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Winnie Siwan on 20/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController, UIPopoverPresentationControllerDelegate, PopViewControllerDelegate{
    
    func updateSong(name: String) {
        receivedSong = name
        songLabelDummy.text = name
    }
    

    var seconds = 10
    // create global variable of timer
    var timer = Timer()
    // audio player for the alarm
    var audioPlayer = AVAudioPlayer()

    var durations = 0
    
    private var songList = getSongList()
    var receivedSong:String = ""
    
    @IBOutlet weak var popBtn: UIBarButtonItem!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var slideOutlet: UISlider!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet var blurview: UIVisualEffectView!
    
    @IBOutlet weak var songLabelDummy: UILabel!
    var source : PopViewController?
    var breakduration:Int = 0
    
    @IBOutlet weak var timerScrollView: UIScrollView!
    @IBOutlet weak var dataView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set size of blurview to equal
        // the size of overall view
        blurview.bounds = self.view.bounds
        
        timerScrollView.delegate = self as? UIScrollViewDelegate
        
        timerScrollView.contentSize = dataView.frame.size

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
        // make sure timer only starts if duration more than 0
        if(seconds > 0){
            // create timer
            // selector, you define class where the function sits
            // currently we use ViewController.
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.counter), userInfo: nil, repeats: true)
            
            // disable slider when timer starts and hide the start button
            // show the stop button
            slideOutlet.isEnabled = false;
            startBtn.isHidden = true;
            startBtn.isEnabled = false;
            stopBtn.isHidden = false;
            stopBtn.isEnabled = true;
            
            setupAudioPlayer()
            
            print("start Timer with song\(receivedSong)")
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
            songLabelDummy.text = "Break Time"
            seconds = breakduration
        }
        
        
        // check if seconds are zero
        // if its true stop timer
        if (seconds == 0 && breakduration == 0)
        {
            timer.invalidate()
            // enable slider again and show start button again
            // hide the stop button
            slideOutlet.isEnabled = true;
            startBtn.isHidden = false;
            startBtn.isEnabled = true;
            stopBtn.isHidden = true;
            stopBtn.isEnabled = false;
            
            songLabelDummy.text = ""
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
        
        // enable slider again and show start button again
        // hide the stop button
        slideOutlet.isEnabled = true;
        startBtn.isHidden = false;
        startBtn.isEnabled = true;
        stopBtn.isHidden = true;
        stopBtn.isEnabled = false;
        
        songLabelDummy.text = ""
        audioPlayer.stop()
       
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
                    
                    source = segue.destination as? PopViewController
                    
                }
        
        
    }
    
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
       // get the modified song from popover
        self.receivedSong = source!.songText
        songLabelDummy.text = receivedSong
         // get the modified break duration from popover
        self.breakduration = source!.durationText*60

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

