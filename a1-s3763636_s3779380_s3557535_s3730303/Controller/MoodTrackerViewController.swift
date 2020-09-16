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
    private let moodGreeting: String = "How are you feeling today?"
    private let greatHexCode = "#8cc0a8"
    private let goodHexCode = "#c9cba3"
    private let okHexCode = "#ffe1a8"
    private let badHexCode = "#ffc2a8"
    private let awfulHexCode = "#ff8585"
    
    private let customBrown = UIColor(hexString: "#544B39")
    private let customDotColour = UIColor(hexString: "#B4A789")
    
    private let locationMangager = CLLocationManager()
    private var currentLocation: CLLocation?
    var placemark: CLPlacemark?
    let geocoder = CLGeocoder()
    
    private var moodTrackerViewModel = MoodTrackerViewModel()
    private var chosenDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let request = RESTRequest.shared
        //        request.getWeatherFor(lat: "", lon: "")
        setUpLocation()
        //        moodTrackerViewModel.getWeatherFor(-37.840935, 144.946457)
        moodTrackerViewModel.delegate = self
        calendar.delegate = self;
        calendar.dataSource = self;
        
        notesText.delegate = self;
        
        customiseCalendarView()
        initDateMoodView()
        
    }
    
    func setUpLocation() {
        locationMangager.delegate = self
        locationMangager.requestWhenInUseAuthorization()
        locationMangager.startUpdatingLocation()
    }
    
    func updateUI() {
        
        //        notesText.text = moodTrackerViewModel.getNotes(forDate: chosenDate)
        //
        if let date = chosenDate {
            dateLbl.text = formatDate(date: date, asFormat: "dd MMMM, yyyy")
            //            // else retrieve from database
            ////            weatherImg.image = UIImage(named: "01d")
            ////            tempLbl.text = "no dice"
        } else {
            dateLbl.text = formatDate(date: calendar.today!, asFormat: "dd MMMM, yyyy")
            //
        }
        print(moodTrackerViewModel.getTempDetails())
        weatherImg.image = moodTrackerViewModel.getImage()
        tempLbl.text = moodTrackerViewModel.getTempDetails()
        calendar.reloadData()
    }
    
    @IBAction func greatBtn(_ sender: Any) {
        //        updateMood(as: Moods.great.rawValue)
        updateMoodView()
    }
    
    @IBAction func goodBtn(_ sender: Any) {
        //        updateMood(as: Moods.good.rawValue)
        updateMoodView()
    }
    
    @IBAction func okBtn(_ sender: Any) {
        //        updateMood(as: Moods.ok.rawValue)
        updateMoodView()
    }
    
    @IBAction func badBtn(_ sender: Any) {
        //        updateMood(as: Moods.bad.rawValue)
        updateMoodView()
    }
    
    @IBAction func awfulBtn(_ sender: Any) {
        //        updateMood(as: Moods.awful.rawValue)
        updateMoodView()
    }
    
    
    
    private func initDateMoodView() {
        greetingsLbl.text = moodGreeting
        dateLbl.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        //        updateDateMoodView(forDate: calendar.today!)
    }
    
    //    private func updateMood(as newMoodStr: String) {
    //        if let date = chosenDate {
    //            moodTrackerViewModel.updateMood( forDate: date, as: newMoodStr)
    //        } else {
    //            moodTrackerViewModel.updateMood( forDate: calendar.today!, as: newMoodStr)
    //        }
    //
    //    }
    
    // format date to string
    private func formatDate(date: Date, asFormat format: String) -> String {
        let formatter = DateFormatter();
        formatter.dateFormat = format;
        return formatter.string(from: date);
    }
    
}

extension MoodTrackerViewController:  UITextViewDelegate {
    //    func textViewDidChange(_ textView: UITextView) {
    //        if let date = chosenDate {
    //            moodTrackerViewModel.updateNotes(forDate: date, as: notesText.text)
    //        } else {
    //            moodTrackerViewModel.updateNotes(forDate: calendar.today!, as: notesText.text)
    //        }
    //
    //    }
}

extension MoodTrackerViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    // customise date selection colour to match any mood entry for that date
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        //        let mood = moodTrackerViewModel.getMood(forDate: date)
        
        //        if mood == Moods.great.rawValue {
        //            return UIColor(hexString: greatHexCode)
        //        } else if mood == Moods.good.rawValue {
        //            return UIColor(hexString: goodHexCode)
        //        } else if mood == Moods.ok.rawValue {
        //            return UIColor(hexString: okHexCode)
        //        } else if mood == Moods.bad.rawValue {
        //            return UIColor(hexString: badHexCode)
        //        } else if mood == Moods.awful.rawValue {
        //            return UIColor(hexString: awfulHexCode)
        //        }
        
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
        //        let mood = moodTrackerViewModel.getMood(forDate: date)
        //
        //        var moodEventColor: UIColor = customBrown
        //
        //        if mood == Moods.great.rawValue {
        //            moodEventColor = UIColor(hexString: greatHexCode)
        //        } else if mood == Moods.good.rawValue {
        //            moodEventColor = UIColor(hexString: goodHexCode)
        //        } else if mood == Moods.ok.rawValue {
        //            moodEventColor = UIColor(hexString: okHexCode)
        //        } else if mood == Moods.bad.rawValue {
        //            moodEventColor = UIColor(hexString: badHexCode)
        //        } else if mood == Moods.awful.rawValue {
        //            moodEventColor = UIColor(hexString: awfulHexCode)
        //        }
        //        return [moodEventColor, customBrown]
        return [customBrown, customDotColour]
    }
    
    // selecting a date and loading the view for that date
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if date.compare(calendar.today!) == .orderedSame {
            print("today")
            getLocation()
        }
        chosenDate = date
        
        //        updateDateMoodView(forDate: date)
    }
    
    private func updateDateMoodView(forDate chosenDate: Date) {
        //        notesText.text = moodTrackerViewModel.getNotes(forDate: chosenDate)
        //        dateLbl.text = formatDate(date: chosenDate, asFormat: "dd MMMM, yyyy")
        //        weatherImg.image = moodTrackerViewModel.getImage()
        //        tempLbl.text = moodTrackerViewModel.getTempDetails()
        //        tempLbl.text = "\(details.minTemp) - \(details.maxTemp)"
        //        calendar.reloadData()
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
    
    // display mood and note entries as dots
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 0
        //        return moodTrackerViewModel.getRecordEvent(forDate: date)
    }
    
    private func getWeatherFor(_ lat: Double, _ lon: Double) {
        moodTrackerViewModel.getWeatherFor(lat, lon)
    }
    
    // changing the colour scheme of calendar
    private func customiseCalendarView() {
        calendar.appearance.todayColor = .orange;
        calendar.appearance.headerTitleColor = customBrown;
        calendar.appearance.weekdayTextColor = customBrown;
    }
    
    private func updateMoodView() {
        //        if let date = chosenDate {
        //            updateDateMoodView(forDate: date)
        //        } else {
        //            updateDateMoodView(forDate: calendar.today!)
        //        }
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return calendar.today!
    }
    
}

extension MoodTrackerViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        print("Location manager")
        if !locations.isEmpty, currentLocation == nil {
            print("inside if manager")
            currentLocation = locations.first
            locationMangager.stopUpdatingLocation()
            getLocation()
            
        }
    }
    
    
    func getLocation() {
        
        guard let location = currentLocation else { return }
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        print("\(lat) and \(lon)")
        moodTrackerViewModel.getWeatherFor(lat, lon)
        
        //
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            if let err = error {
                print("geocoder error**: \(err)")
            } else  {
                if let placemarks = placemarks {
                    self.placemark = placemarks.last
                }
                self.parsePlacemarks()
            }
        }
    }
    
    func parsePlacemarks() {
        if let placemark = placemark {
            // wow now you can get the city name. remember that apple refers to city name as locality not city
            // again we have to unwrap the locality remember optionalllls also some times there is no text so we check that it should not be empty
            if let city = placemark.locality, !city.isEmpty {
                // here you have the city name
                // assign city name to our iVar
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
