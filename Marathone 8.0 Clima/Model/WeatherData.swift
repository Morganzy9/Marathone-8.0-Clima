//
//  WeatherData.swift
//  Marathone 8.0 Clima
//
//  Created by Ислам Пулатов on 8/16/23.
//

import Foundation

struct WeatherData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

