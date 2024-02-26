//
//  HourlyWeatherCollectionViewCellViewModel.swift
//  Weather-App
//
//  Created by Марк Киричко on 11.02.2024.
//

import Foundation

class HourlyWeatherCollectionViewCellViewModel {
    
    var hour: Int
    var icon: String
    var temperature: Int
    
    init(hour: Int, icon: String, temperature: Int) {
        self.hour = hour
        self.icon = icon
        self.temperature = temperature
    }
}
