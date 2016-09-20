//
//  Forecast.swift
//  weatherrain
//
//  Created by Norbert Czirjak on 19/09/16.
//  Copyright © 2016 Norbert Czirjak. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    // a weatherVC ben talalhato -> let forecast = Forecast(weatherDict: obj), val hivjuk meg az initet
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let min = temp["min"] as? Double {
                let kelvinToFarenheitPreDivision = (min * (9/5) - 459.67)
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                // mivel itt double van ezert ugy is kell atadni
                self._lowTemp = "\(kelvinToFarenheit)"
            }
            
            if let max = temp["max"] as? Double {
                let kelvinToFarenheitPreDivision = (max * (9/5) - 459.67)
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                // mivel itt double van ezert ugy is kell atadni
                self._highTemp = "\(kelvinToFarenheit)"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        // a jsonbon egy ez egy datestamp
        if let date = weatherDict["dt"] as? Double {
            
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
        
    }
}

//extensiont csak az osztaly deklaracion kivul hasznalhatunk
extension Date {
    func dayOfTheWeek() ->String {
        let dateFormatter = DateFormatter()
        // EEEE full name of the day of the week
        dateFormatter.dateFormat = "EEEE"
        //aze self me innen szedjuk ki az infot
        return dateFormatter.string(from: self)
    }
}
