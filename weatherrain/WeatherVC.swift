//
//  VWeatherVC.swift
//  weatherrain
//
//  Created by Norbert Czirjak on 10/09/16.
//  Copyright © 2016 Norbert Czirjak. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    // egy generic osztalyt hozunk ezzel letre
    var currentWeather: CurrentWeather!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        print(CURRENT_WEATHER_URL)
        
        currentWeather = CurrentWeather()
        
        currentWeather.downloadWeatherDetails {
            self.updateMainUI()
        }
        
        
    }

    // a tableViewhoz ezek kellenek alapbol - START
 
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //ha a dequereusablecellt meghivjuk akkor keresni fog egy 
        // cell identifiert, amit ugye a tablecellnek adunk meg
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        
        return cell
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

