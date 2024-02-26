//
//  CurrentWeatherTableViewCellViewModel.swift
//  Weather-App
//
//  Created by Марк Киричко on 10.02.2024.
//

import Foundation

class CurrentWeatherTableViewCellViewModel {
    
    var icon: String
    var city: String
    var temperature: Int
    var condition: String
    var maxTemperature: Int
    var minTemperature: Int
    
    init(icon: String, city: String, temperature: Int, condition: String, maxTemperature: Int, minTemperature: Int) {
        self.icon = icon
        self.city = city
        self.temperature = temperature
        self.condition = condition
        self.maxTemperature = maxTemperature
        self.minTemperature = minTemperature
    }
}
