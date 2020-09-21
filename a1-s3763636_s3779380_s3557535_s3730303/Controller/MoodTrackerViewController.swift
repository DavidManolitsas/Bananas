//
//  MoodTrackerViewController.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Jess Cui on 20/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation
import FSCalendar
import UIKit
import CoreLocation

class MoodTrackerViewController: UIViewController, Refresh {
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var greetingsLbl: UILabel!
    @IBOutlet weak var notesText: UITextView!
    @IBOutlet weak var locationLbl: UILabel!
    
    private let moodGreeting = "How are you feeling today?"
    private let greatHexCode = "#8cc0a8"
    private let goodHexCode = "#c9cba3"
    private let okHexCode = "#ffe1a8"
    private let badHexCode = "#ffc2a8"
    private let awfulHexCode = "#ff8585"
    
    private let customBrown = UIColor(hexString: "#544B39")
    
    private let locationMangager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var placemark: CLPlacemark?
    private let geocoder = CLGeocoder()
    
    private var moodTrackerViewModel = MoodTrackerViewModel()
    private var chosenDate: Date?
    
    @IBAction func greatBtn(_ sender: Any) {
        updateMoodAs(Moods.great)
    }
    
    @IBAction func goodBtn(_ sender: Any) {
        updateMoodAs(Moods.good)
    }
    
    @IBAction func okBtn(_ sender: Any) {
        updateMoodAs(Moods.ok)
    }
    
    @IBAction func badBtn(_ sender: Any) {
        updateMoodAs(Moods.bad)
    }
    
    @IBAction func awfulBtn(_ sender: Any) {
        updateMoodAs(Moods.awful)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moodTrackerViewModel.delegate = self
        notesText.delegate = self;
        
        setUpLocation()
        setUpCalendar()
        
        initDateMoodView()
    }
    
    func updateUI() {
        weatherImg.image = moodTrackerViewModel.getImage()
        tempLbl.text = moodTrackerViewModel.getTempDetails()
        calendar.reloadData()
    }
    
    private func setUpLocation() {
        locationMangager.delegate = self
        locationMangager.requestWhenInUseAuthorization()
        locationMangager.startUpdatingLocation()
    }
    
    private func setUpCalendar() {
        calendar.delegate = self;
        calendar.dataSource = self;
        //        customiseCalendarView()
        calendar.appearance.todayColor = .orange;
        calendar.appearance.headerTitleColor = customBrown;
        calendar.appearance.weekdayTextColor = customBrown;
    }
    
    private func initDateMoodView() {
        greetingsLbl.text = moodGreeting
        dateLbl.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        updateDateMoodViewFor(date: calendar.today!)
    }
    
    //    // changing the colour scheme of calendar
    //    private func customiseCalendarView() {
    //        calendar.appearance.todayColor = .orange;
    //        calendar.appearance.headerTitleColor = customBrown;
    //        calendar.appearance.weekdayTextColor = customBrown;
    //    }
    
    private func updateMoodAs(_ newMood: Moods) {
        if let date = chosenDate {
            moodTrackerViewModel.updateMoodFor(date, as: newMood)
            updateDateMoodViewFor(date: date)
        } else {
            moodTrackerViewModel.updateMoodFor(calendar.today!, as: newMood)
            updateDateMoodViewFor(date: calendar.today!)
        }
        
    }
    
    private func getWeatherFor(_ lat: Double, _ lon: Double) {
        moodTrackerViewModel.getWeatherFor(lat, lon)
    }
    
    // format date to string
    private func formatDate(date: Date, asFormat format: String) -> String {
        let formatter = DateFormatter();
        formatter.dateFormat = format;
        return formatter.string(from: date);
    }
    
}

/*
 Textview delegate
 */
extension MoodTrackerViewController:  UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let date = chosenDate {
            moodTrackerViewModel.updateNotesFor(date, as: notesText.text)
        } else {
            moodTrackerViewModel.updateNotesFor(calendar.today!, as: notesText.text)
        }
        
    }
}

/*
 Calendar appearance delegate
 */
extension MoodTrackerViewController: FSCalendarDelegateAppearance {
    // customise date selection colour to match any mood entry for that date
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        moodTrackerViewModel.loadRecordFor(date)
        let mood = moodTrackerViewModel.mood
        
        if mood == Moods.great.rawValue {
            return UIColor(hexString: greatHexCode)
        } else if mood == Moods.good.rawValue {
            return UIColor(hexString: goodHexCode)
        } else if mood == Moods.ok.rawValue {
            return UIColor(hexString: okHexCode)
        } else if mood == Moods.bad.rawValue {
            return UIColor(hexString: badHexCode)
        } else if mood == Moods.awful.rawValue {
            return UIColor(hexString: awfulHexCode)
        }
        
        return appearance.eventDefaultColor
    }
    
    // customise event dot colours when date is not selected
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        return customiseEventColours(forDate: date)
    }
    
    // customise event dot colours when date is is selected
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
        return customiseEventColours(forDate: date)
    }
    
    // customse event dot colours to reflect a mood event colour
    private func customiseEventColours(forDate date: Date) -> [UIColor]?{
        moodTrackerViewModel.loadRecordFor(date)
        let mood = moodTrackerViewModel.mood
        var moodEventColor: UIColor = customBrown
        
        if mood == Moods.great.rawValue {
            moodEventColor = UIColor(hexString: greatHexCode)
        } else if mood == Moods.good.rawValue {
            moodEventColor = UIColor(hexString: goodHexCode)
        } else if mood == Moods.ok.rawValue {
            moodEventColor = UIColor(hexString: okHexCode)
        } else if mood == Moods.bad.rawValue {
            moodEventColor = UIColor(hexString: badHexCode)
        } else if mood == Moods.awful.rawValue {
            moodEventColor = UIColor(hexString: awfulHexCode)
        }
        return [moodEventColor, customBrown]
        
    }
    
    
}

/*
 Calendar delegate and datasource
 */
extension MoodTrackerViewController: FSCalendarDelegate, FSCalendarDataSource {
    // selecting a date and loading the view for that date
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //        if date.compare(calendar.today!) == .orderedSame {
        //
        //            //            locationMangager.startUpdatingLocation()
        //            //            getLocation()
        //        }
        chosenDate = date
        //        updateUI()
        updateDateMoodViewFor(date: date)
    }
    
    private func updateDateMoodViewFor(date: Date) {
        dateLbl.text = formatDate(date: date, asFormat: "dd MMMM, yyyy")
        moodTrackerViewModel.loadRecordFor(date)
        notesText.text = moodTrackerViewModel.notes
        
        //        notesText.text = moodTrackerViewModel.loadNotesFor(date: date)
        //        weatherImg.image = moodTrackerViewModel.getImage()
        //        tempLbl.text = moodTrackerViewModel.getTempDetails()
        //        tempLbl.text = "\(details.minTemp) - \(details.maxTemp)"
        calendar.reloadData()
    }
    // update the view with details from the 'database'
    //    private func updateDateMoodView(forDate chosenDate: Date) {
    //        let details = moodTrackerViewModel.getWeatherDetails(forDate: chosenDate)
    //        weatherImg.image = details.uiImage
    //        tempLbl.text = "\(details.minTemp) - \(details.maxTemp)"
    //        notesText.text = moodTrackerViewModel.getNotes(forDate: chosenDate)
    //        dateLbl.text = formatDate(date: chosenDate, asFormat: "dd MMMM, yyyy")
    //        calendar.reloadData()
    //    }
    
    
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return calendar.today!
    }
    
    // display mood and note entries as dots
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return moodTrackerViewModel.getEventCountFor(date)
    }
    
}

/*
 Location manager delegate
 */
extension MoodTrackerViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty{//, currentLocation == nil {
            currentLocation = locations.first
            // if this is not commented, you will not be able to continuously update location
            //            locationMangager.stopUpdatingLocation()
            getLocation()
            
        }
    }
    
    
    func getLocation() {
        guard let location = currentLocation else { return }
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        print("the lat is \(lat) and the lon is \(lon)")
        moodTrackerViewModel.getWeatherFor(lat, lon)
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            if let err = error {
                print("geocoder error**: \(err)")
            } else  {
                if let placemark = placemarks {
                    self.placemark = placemark.last
                    //                    print("self.placemark?.locality \(self.placemark.locality)")
                    //                    print("placemark.locality \(self.placemark.locality)")
                    //                    print("placemark.subLocality) \(self.placemark.subLocality)")
                }
                self.parsePlacemarks()
            }
        }
    }
    
    func parsePlacemarks() {
        if let placemark = placemark {
            print("placemark.locality is = \(placemark.locality!)")
            if let city = placemark.locality, !city.isEmpty {
                locationLbl.text = city
            }
        }
    }
    
}


/*
 *    Title: How to convert HEX colors to UIColor in Swift 5?
 *    Author: Florian
 *    Date: 12 April 2020
 *    Code version: n/a
 *    Availability: https://www.iosapptemplates.com/blog/swift-programming/convert-hex-colors-to-uicolor-swift-4
 *
 */
// creates custom UIColor objects
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
