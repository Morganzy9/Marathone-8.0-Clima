//
//  WeatherViewController.swift
//  Marathone 8.0 Clima
//
//  Created by Ислам Пулатов on 8/15/23.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    
    
    let weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        
    }

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

