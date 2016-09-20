//
//  currentWeather.swift
//  weatherrain
//
//  Created by Norbert Czirjak on 15/09/16.
//  Copyright © 2016 Norbert Czirjak. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        print(_cityName);
        print("citynameben vok");
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        //beallitjuk a datumot
        let dateFormatter = DateFormatter()
        //datum tipusa
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        //mai datum
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    
    
    // a comleted azt jeloli majd h a letoltes befejezodott
   /* func downloadWeatherDetails(completed: DownloadComplete) {
        //Download Current Weather Data
        
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            switch response.result {
            case .success:
                print("/ JSON returned in makeRequest: vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv")
                print(response.result.value)
                print("\\ JSON returned in makeRequest: ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
                
                let result = response.result
                
                if let dict = result.value as? Dictionary<String, AnyObject> {
                    
                    if let name = dict["name"] as? String {
                        self._cityName = name.capitalized
                        print(self._cityName)
                    }
                    
                    if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                        
                        if let main = weather[0]["main"] as? String {
                            self._weatherType = main.capitalized
                            print(self._weatherType)
                        }
                        
                    }
                    
                    if let main = dict["main"] as? Dictionary<String, AnyObject> {
                        
                        if let currentTemperature = main["temp"] as? Double {
                            
                            let kelvinToFarenheitPreDivision = (currentTemperature * (9/5) - 459.67)
                            
                            let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                            
                            self._currentTemp = kelvinToFarenheit
                            print(self._currentTemp)
                        }
                    }
                }
                
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        return 
        // You'll notice this occurs in the console LONG before the request completes.
        print("~~~~~~ below request ~~~~~~~~")
        
    
    }
*/
    
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //Download Current Weather Data
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            let result = response.result
    
            if let dict = result.value as? Dictionary<String, AnyObject> {
    
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
    
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
    
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
    
                }
    
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
    
                    if let currentTemperature = main["temp"] as? Double {
    
                        let kelvinToFarenheitPreDivision = (currentTemperature * (9/5) - 459.67)
    
                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
    
                        self._currentTemp = kelvinToFarenheit
                        print(self._currentTemp)
                    }
                }
            }
            completed()
        }
    }

    
}


