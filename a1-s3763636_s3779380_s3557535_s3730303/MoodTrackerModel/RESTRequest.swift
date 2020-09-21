//
//  RESTRequest.swift
//  networking_demo
//
//  Created by Jess Cui on 14/9/20.
//  Copyright © 2020 Jess Cui. All rights reserved.
//

import Foundation

// using delegation so that once the request has finished retrieving data, then the view can update the ui
protocol Refresh {
    func updateUI()
}

// responsible for making the REST request
class RESTRequest {
    private var _forecasts: [Forecast] = []
    var delegate: Refresh?
    private let session = URLSession.shared
    
    var forecasts:[Forecast] {
        return _forecasts
    }
    
    private let baseUrl = "https://api.openweathermap.org/data/2.5/onecall?"
    private let paramLat = "lat="
    private let paramLon = "&lon="
    private let paramExtras = "&exclude=hourly,minutely&units=metric&appid=4cf9cf2abea6ca19629148287ffdd684"

    public func getWeatherFor(lat: String, lon: String) {
        _forecasts = []
        let urlString = baseUrl + paramLat + lat + paramLon + lon + paramExtras
//        print("URL for weather request is: \(urlString)")
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            getData(request)
        }
    }
    
    private func getData(_ url:URLRequest) {
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
                print(result.daily[0].weather[0])
//                print(result.daily[0].temp.max)
//                print(result.daily[0].temp.min)
                let forecast = Forecast(main: day.weather[0].main, description: day.weather[0].description, iconName: day.weather[0].icon, maxTemp: day.temp.max, minTemp: day.temp.min)
                self._forecasts.append(forecast)
                
                DispatchQueue.main.async {
                    self.delegate?.updateUI()
                }
                
            }
        })
        task.resume()
        
        
    }
    
    // creating a Singleton
    private init() { }
    static let shared = RESTRequest()
    
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
    let uvi: Double
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
    let uvi: Double
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



