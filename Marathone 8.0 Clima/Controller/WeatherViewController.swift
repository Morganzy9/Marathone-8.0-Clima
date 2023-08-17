//
//  WeatherViewController.swift
//  Marathone 8.0 Clima
//
//  Created by Ислам Пулатов on 8/15/23.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    
    
    var weatherManager = WeatherManager()
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        
        
    }
        
}

//  MARK: - Extensions

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        view.endEditing(true)
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        print(textField.text!)
        textField.text = ""
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            
            return true
            
        } else {
            
            textField.placeholder = "Type Something"
            
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let cityName = textField.text else { return }
        
        weatherManager.fetchWeather(cityName)
        
        textField.text = ""
    }
    
}

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weathermanager: WeatherManager,_ weather: WeatherModel) {
        
        DispatchQueue.main.async {
            
            self.temperatureLabel.text = weather.temperatureString
            
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            
            self.cityLabel.text = weather.cityName
            
        }
        
        
    }
    
    func didFailWithError(_ error: Error) {
        
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Ok", style: .destructive) { action in
            print("Getting Error: \(error.localizedDescription)")
        }
        
        alert.addAction(okButton)
    }
    
}

//  MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard  let location = locations.last else { return }
        
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        weatherManager.fetchWeather(latitude: lat, longitude: lon)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

