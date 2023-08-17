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
        
        performRequest(with: urlString)
        
    }
    
    
    func performRequest(with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                
                print(error)
                
                return
            }
            
            guard let safeData = data else { return }
            
            parseJson(with: safeData)
            
            
            
        }.resume()
        
        
    }
    
    
    func parseJson(with data: Data)-> WeatherModel? {
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            return weather
            
        } catch {
            print("Error")
            return nil
        }
        
        
    }
    
    
}
