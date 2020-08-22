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

class MoodTrackerViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var weatherTableView: UITableView!
    
    
    private let moodGreeting: String = "" //"How are you feeling today?"
    private var selectedDate: String? //: String = "Date was not selected"
    private var weatherIcon: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self;
        calendar.dataSource = self;
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        
        customiseCalendarView()
        
        let weatherNib = UINib(nibName:"WeatherMoodTableViewCell", bundle:nil)
        weatherTableView.register(weatherNib, forCellReuseIdentifier: "WeatherMoodTableViewCell")
        
    }
    
    // **** start calendar region ****
    
    // selecting a date
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let selected = formatDate(date: date, asFormat: "dd-MMMM-yy")
        updateTableView(selection: selected)
        //        print("date selected is \(selected)")
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
    
    // one row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // retrieve the cell and populate it with data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherCell = tableView.dequeueReusableCell(withIdentifier: "WeatherMoodTableViewCell", for: indexPath) as! WeatherMoodTableViewCell
        
        weatherCell.dailyGreetingLbl.text = moodGreeting
        
        guard let chosenDate = selectedDate else {
            weatherCell.dateLbl.text = formatDate(date: calendar.today!, asFormat: "dd-MMMM-yy") // todo: forced unwrap fix
            return weatherCell
        }
        
        weatherCell.dateLbl.text = chosenDate
        return weatherCell
    }
    // **** end tableView region ****
    
    // format date to string
    func formatDate(date: Date, asFormat format: String) -> String {
        let formatter = DateFormatter();
        formatter.dateFormat = format;
        return formatter.string(from: date);
    }
    
    // dynamically updating view based on date selected
    func updateTableView(selection: String) {
        selectedDate = selection
        weatherTableView.reloadData()
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
