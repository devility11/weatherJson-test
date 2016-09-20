//
//  VWeatherVC.swift
//  weatherrain
//
//  Created by Norbert Czirjak on 10/09/16.
//  Copyright © 2016 Norbert Czirjak. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    // egy generic osztalyt hozunk ezzel letre
    var currentWeather: CurrentWeather!
    
    var forecast: Forecast!
    // simple array ami tud adatokat fogadni, ehhez kell a ()
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        print(CURRENT_WEATHER_URL)
        
        currentWeather = CurrentWeather()
//        forecast = Forecast()
        
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData {
                self.updateMainUI()
            }
            
        }
        
    }
    //download all current weather data to tableview
    func downloadForecastData(completed: DownloadComplete){
        
        let forecastURL = URL(string: FORECAST_URL)!
        
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        // az allisszakat betesszuk egy ujabb tombbe.
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    //elso napot kiszedjuk
                    self.forecasts.remove(at: 0)
                    //tableview ujratoltese
                    self.tableView.reloadData()
                    
                }
                
            }
            
        }
        completed()
    }
    

    // a tableViewhoz ezek kellenek alapbol - START
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //ha a dequereusablecellt meghivjuk akkor keresni fog egy 
        // cell identifiert, amit ugye a tablecellnek adunk meg
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            // evlileg ebben a forecasts tombben van benne minden idojaras info
            // epp eze az indexpath.row kifogja szedni az elemeket a tombbol
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        }else {
            //ures weathercellt adunk vissza
            return WeatherCell()
        }
        
        
    }
    
    // a tableViewhoz ezek kellenek alapbol - END
    
    
    
    func updateMainUI() {
        print("ssssssss")
        dateLabel.text = currentWeather.date
        print(currentWeather.date)
        //double ezert atkell alakitanunk stringre
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        print(currentWeather.weatherType)
        locationLabel.text = currentWeather.cityName
        print(currentWeather.cityName)
        //az imagek neve ugyanazt hasznalja mint a weatherTypenal
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
        
        
    }
}

