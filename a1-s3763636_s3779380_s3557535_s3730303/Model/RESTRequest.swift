//
//  RESTRequest.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Jess Cui on 15/9/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

protocol Refresh {
    func updateUI()
}

class RESTRequest {
    private var _forecasts: [Forecast] = []
    var delegate: Refresh?
    private let session = URLSession.shared
    
    private let baseUrl = "https://api.openweathermap.org/data/2.5/onecall?"
    private let paramLat = "lat="
    private let paramLon = "&lon="
    private let paramExtras = "&exclude=hourly,minutely&units=metric&appid=4cf9cf2abea6ca19629148287ffdd684"
    //    private let paramExclude = "&exclude=hourly,minutely"
    //    private let paramUnits = "&units=metric"
    //    private let paramKey = "&appid=&appid=4cf9cf2abea6ca19629148287ffdd684"
    
        func getForecastFor(lat: String, lon: String) {
    
            let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=-37.840935&lon=144.946457&exclude=hourly,minutely&units=metric&appid=4cf9cf2abea6ca19629148287ffdd684"
    
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                //            getData(request, element: "daily")
                getData(request)
            }
        }
    
        private func getData(_ url:URLRequest) {
    
            let task = session.dataTask(with: url, completionHandler: {
                data, response, error in
    
                if let err = error {
                    print("completion handler error: \(err)")
                } else {
    
                    // convert dat to some object
                    var json: WeatherResponse?
    
                    do {
                        json = try JSONDecoder().decode(WeatherResponse.self, from: data!)
                    } catch {
                        print("error in do try: \(error)")
                    }
    
                    guard let result = json else {
                        return
                    }
    
                    print(result.daily[0].temp.max)
                }
            })
            task.resume()
    
        }
    
//    func getForecastFor(lat: String, lon: String) {
//
//        let escapedAddress = "https://api.openweathermap.org/data/2.5/onecall?lat=-37.840935&lon=144.946457&exclude=hourly,minutely&units=metric&appid=4cf9cf2abea6ca19629148287ffdd684"
//
//        if let url = URL(string: escapedAddress) {
//
//            let request = URLRequest(url: url)
//            getData(request, element: "daily")
//        }
//    }
//    private func getData(_ request: URLRequest, element: String) {
//        let task = session.dataTask(with: request, completionHandler: {data, response, error in
//
//            if let err = error {
//                print("Download error is: \(err)")
//            } else {
//                var parsedResult: Any! = nil
//
//                do {
//                    parsedResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
//                } catch {
//                    print("do try error")
//                }
//
//                let result = parsedResult as! [String: Any]
////                print (result)
//
//                let dailyForecasts = result[element] as! [[String:Any]]
////                print(dailyForecasts)
//
//                if dailyForecasts.count > 0 {
//                    for daily in dailyForecasts {
//
////                        print (daily["temp"])
////                        let temp = daily["temp"] as! Double
////                        let weather = daily["weather"] as! WeatherEntry
////                        let forecast = Forecast(main: weather.main, description: weather.description, iconName: weather.icon, maxTemp: temp.max, minTemp: temp.min)
////                        self._forecasts.append(forecast)
//
//                    }
//
//                }
//
//
//                // when we're finished getting our data
//                // since you can't update UI from background thread you need to send the update from the main thread
//                // so use Grand central dispatch
//                DispatchQueue.main.async {
//                    self.delegate?.updateUI()
//                }
//
//
//            }
//        })
//        // swift api executes the task
//        task.resume()
////        print(self._forecasts[0])
//    }
    
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


