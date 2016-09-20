//
//  WeatherCell.swift
//  weatherrain
//
//  Created by Norbert Czirjak on 20/09/16.
//  Copyright © 2016 Norbert Czirjak. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    // a Forecast osztalybol dfog jonni az adat
    func configureCell(forecast: Forecast) {
        
        lowTemp.text = "\(forecast.lowTemp)"
        highTemp.text = "\(forecast.highTemp)"
        weatherType.text = forecast.weatherType
        dayLabel.text = forecast.date
        weatherImage.image = UIImage(named: forecast.weatherType)
        
    }
    
    
   
}
