//
//  WeatherManager.swift
//  Marathone 8.0 Clima
//
//  Created by Ислам Пулатов on 8/15/23.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weather: WeatherModel)

    func didFailWithError(_ error: Error)
}


struct WeatherManager {
    
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=9b76ea10092d058dc0378bf8ffdc80f0&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(_ cityName: String) {
        
        let urlString = "\(weatherUrl)&q=\(cityName)"
        
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let urlStirng = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
        
        performRequest(with: urlStirng)
        
    }
    
    
    func performRequest(with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                
                delegate?.didFailWithError(error)
                
                return
            }
            
            guard let safeData = data else { return }
            
            guard let weather = parseJson(safeData) else { return }
            
            delegate?.didUpdateWeather(self, weather)
            
        }.resume()
        
        
    }
    
    
    func parseJson(_ data: Data)-> WeatherModel? {
        
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
