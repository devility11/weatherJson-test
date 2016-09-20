//
//  Constants.swift
//  weatherrain
//
//  Created by Norbert Czirjak on 15/09/16.
//  Copyright © 2016 Norbert Czirjak. All rights reserved.
//

import Foundation


let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "0e488838bce84d922e014c4315b52932"


let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)47.30\(LONGITUDE)19.5\(APP_ID)\(API_KEY)"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=47.30&lon=19.50&cnt=10&mode=json&appid=0e488838bce84d922e014c4315b52932"


//ez fogja megmondani a funcionknak h a download befejezodott
typealias DownloadComplete = () -> ()













