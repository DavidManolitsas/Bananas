//
//  RESTRequestTest.swift
//  a1-s3763636_s3779380_s3557535_s3730303Tests
//
//  Created by Jess Cui on 5/10/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import XCTest
@testable import a1_s3763636_s3779380_s3557535_s3730303
class RESTRequestTest: XCTestCase {
    
    var rest = RESTRequest.shared
    private var _forecast: Forecast?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetData() {
        
        if let path = Bundle.main.path(forResource: "mockWeather", ofType: "json") {
            //            do {
            //                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            //                 var json: WeatherResponse?
            //                  do {
            //                      json = try JSONDecoder().decode(WeatherResponse.self, from: data)
            //                  } catch {
            //                      print("error in do try: \(error)")
            //                  }
//            guard let result = json else {
//                return
//            }
//            let day = result.daily[0]
//            let current = result.current
//            let forecast = Forecast(iconName: day.weather[0].icon, maxTemp: day.temp.max, minTemp: day.temp.min, feelsLike: current.feels_like, sunrise: day.sunrise, sunset: day.sunset)
//            self._forecast = forecast
            //              } catch {
            //                print(error)
            //                   // handle error
            //              }
        } else {
            print("!@#$%^&*()_+")
        }
        
        //        XCTAssertEqual(12.79, 12.79)
    }
    
}
