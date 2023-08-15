//
//  WeatherManager.swift
//  Marathone 8.0 Clima
//
//  Created by Ислам Пулатов on 8/15/23.
//

import Foundation
struct WeatherManager {
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?q=London&appid=9b76ea10092d058dc0378bf8ffdc80f0&units=metric"
    
    func fetchWeather(_ cityName: String) {
        
        let urlString = "\(weatherUrl)&q\(cityName)"
        
        
 
        
    }
    
}
