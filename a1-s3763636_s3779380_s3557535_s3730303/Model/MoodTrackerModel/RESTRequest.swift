//
//  RESTRequest.swift
//  networking_demo
//
//  Created by Jess Cui on 14/9/20.
//  Copyright © 2020 Jess Cui. All rights reserved.
//

import Foundation

protocol Refresh {
    func updateUI()
}

class RESTRequest {
    private var _forecast: Forecast?
    var delegate: Refresh?
    private let session = URLSession.shared
    
    var forecast: Forecast? {
        return _forecast
    }
    
    private init() { }
    static let shared = RESTRequest()
    
    private let baseUrl = "https://api.openweathermap.org/data/2.5/onecall?"
    private let paramLat = "lat="
    private let paramLon = "&lon="
    private let paramExtras = "&exclude=hourly,minutely&units=metric&appid=4cf9cf2abea6ca19629148287ffdd684"
    
    public func getWeatherFor(lat: String, lon: String) {
        let urlString = baseUrl + paramLat + lat + paramLon + lon + paramExtras
        if let url = URL(string: urlString) {
            getData(url)
        }
    }
    
    private func getData(_ url: URL) {
        let task = session.dataTask(with: url, completionHandler: {
            data, response, error in
            
            if let err = error {
                print("completion handler error: \(err)")
            } else {
                
                var json: WeatherResponse?
                
                do {
                    json = try JSONDecoder().decode(WeatherResponse.self, from: data!)
                } catch {
                    print("error in do try line 60 RESTRequest: \(error)")
                }
                
                guard let result = json else {
                    return
                }
                
                let day = result.daily[0]
                let current = result.current
                let forecast = Forecast(iconName: day.weather[0].icon, maxTemp: day.temp.max, minTemp: day.temp.min, feelsLike: current.feels_like, sunrise: day.sunrise, sunset: day.sunset)
                self._forecast = forecast
                
                DispatchQueue.main.async {
                    self.delegate?.updateUI()
                }
                
            }
        })
        task.resume()
        
    }
    
}

// codable allows us to convert data into a class/struct because of codable protocol
struct WeatherResponse: Codable {
    let lat: Float
    let lon: Float
    let timezone: String
    let timezone_offset: Int
    let current: CurrentWeather
    let daily: [DailyEntry]
}

struct CurrentWeather: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let uvi: Double?
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Int
    let weather: [WeatherEntry]
}

struct DailyEntry: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Temp
    let feels_like: FeelsLike
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let wind_speed: Double
    let wind_deg: Int
    let weather:[WeatherEntry]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let uvi: Double?
    
}

struct Temp: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct FeelsLike: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct WeatherEntry: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}



