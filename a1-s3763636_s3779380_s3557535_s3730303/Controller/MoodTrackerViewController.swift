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
//

class MoodTrackerViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var greetingsLbl: UILabel!
    
    @IBOutlet weak var greatBtn: UIButton!
    @IBOutlet weak var goodBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var badBtn: UIButton!
    @IBOutlet weak var awfulBtn: UIButton!
    
    
    private let moodGreeting: String = "How are you feeling today?"
    private var selectedDate: String? //: String = "Date was not selected"
    
    private var moodTrackerViewModel = MoodTrackerViewModel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self;
        calendar.dataSource = self;
        
        customiseCalendarView()
        customiseBtns()
        
       initDateMoodView()
        
    }
    
    private func initDateMoodView() {
        greetingsLbl.text = moodGreeting
        selectedDate = formatDate(date: calendar.today!, asFormat: "dd MMMM, yyyy")
        updateDateMoodView()
    }
    
    // **** start calendar region ****
    
    // selecting a date
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = formatDate(date: date, asFormat: "dd MMMM, yyyy")
        updateDateMoodView()
        //        updateTableView(selection: selected)
        //        print("date selected is \(selected)")
    }
    
    private func updateDateMoodView() {
//        guard let chosenDate = selectedDate else {
////            dateLbl.text = formatDate(date: calendar.today!, asFormat: "dd MMMM, yyyy") // todo: forced unwrap fix
//            weatherImg.image = moodTrackerViewModel.getNextImg()
//
//        }
        let details = moodTrackerViewModel.getWeatherDetails()
        weatherImg.image = details.uiImage
        maxTempLbl.text = details.maxTemp
        minTempLbl.text = details.minTemp
        dateLbl.text = selectedDate
        
        
    }
    // display events as dots
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        //        <#code#>
        return 0
    }
    
    // changing the colour scheme
    func customiseCalendarView() {
        //        6D634F
        let customBrown = UIColor(hexString: "#544B39")
        calendar.appearance.todayColor = .orange;
        calendar.appearance.headerTitleColor = customBrown;
        calendar.appearance.weekdayTextColor = customBrown;
    }
    // **** end calendar region ****
    
    
    
    // **** start tableView region ****
    
    //    // one row
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return 1
    //    }
    //
    //    // retrieve the cell and populate it with data
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let weatherCell = tableView.dequeueReusableCell(withIdentifier: "WeatherMoodTableViewCell", for: indexPath) as! WeatherMoodTableViewCell
    //
    //        weatherCell.dailyGreetingLbl.text = moodGreeting
    //
    //        guard let chosenDate = selectedDate else {
    //            weatherCell.dateLbl.text = formatDate(date: calendar.today!, asFormat: "dd MMMM, yyyy") // todo: forced unwrap fix
    //            weatherCell.weatherImg.image = moodTrackerViewModel.getNextImg()
    //            return weatherCell
    //        }
    //
    //        weatherCell.weatherImg.image = moodTrackerViewModel.getNextImg()
    //        weatherCell.dateLbl.text = chosenDate
    //        return weatherCell
    //    }
    //    // **** end tableView region ****
    
    // format date to string
    private func formatDate(date: Date, asFormat format: String) -> String {
        let formatter = DateFormatter();
        formatter.dateFormat = format;
        return formatter.string(from: date);
    }
    
    private func customiseBtns() {
        let btnsArr: [UIButton] = [greatBtn, goodBtn, okBtn, badBtn, awfulBtn]
        
        for btn in btnsArr {
            btn.layer.cornerRadius = 0.5 * btn.bounds.size.width
            btn.clipsToBounds = true
        }
        
    }
    
    
}


//https://www.iosapptemplates.com/blog/swift-programming/convert-hex-colors-to-uicolor-swift-4
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
