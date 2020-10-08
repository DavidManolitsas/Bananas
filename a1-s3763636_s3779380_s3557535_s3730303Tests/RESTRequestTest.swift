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
    private var rain: Double?
    private var noRain: Double?
    
    
    override func setUp() {
        super.setUp()
        
        // read in mock json weather file and retrieve relevant data to instantiate a forecast object
        if let path = Bundle.main.path(forResource: "MockWeather", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                var json: WeatherResponse?
                do {
                    json = try JSONDecoder().decode(WeatherResponse.self, from: data)
                } catch {
                    print("**** error in JSON Decoder ****")
                }
                
                guard let result = json else {
                    return
                }
                
                let day = result.daily[0]
                let current = result.current
                let forecastWRain = Forecast(iconName: day.weather[0].icon, maxTemp: day.temp.max, minTemp: day.temp.min, feelsLike: current.feels_like, sunrise: day.sunrise, sunset: day.sunset)
                self._forecast = forecastWRain
                
                self.rain = day.rain
                self.noRain = result.daily[1].rain
                
                
            } catch {
                print("**** Could not unwrap data ****")
            }
            
        } else {
            print("*** No such file found ***")
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // test that it does read in the daily weather for the first day
    func testGetData() {
        guard let forecast = _forecast else { return }
        XCTAssertEqual(12.79, forecast.maxTemp)
        XCTAssertEqual(10.07, forecast.minTemp)
        XCTAssertEqual("10d", forecast.iconName)
        XCTAssertEqual(5.91, forecast.feelsLike)
        XCTAssertEqual(1601840968, forecast.sunrise)
        XCTAssertEqual(1601886453, forecast.sunset)
        
    }
    
    // test that it does not read in the daily weather for the second day
    func testInvalidData() {
        guard let forecast = _forecast else { return }
        XCTAssertNotEqual(11.77, forecast.maxTemp)
        XCTAssertNotEqual(10.25, forecast.minTemp)
        XCTAssertNotEqual("01d", forecast.iconName)
        XCTAssertNotEqual(7.12, forecast.feelsLike)
        XCTAssertNotEqual(1601927277, forecast.sunrise)
        XCTAssertNotEqual(1601972907, forecast.sunset)
    }
    
    func testHasRain() {
        XCTAssertNotNil(rain)
    }
    
    func testHasNoRain() {
        XCTAssertNil(noRain)
    }
}
