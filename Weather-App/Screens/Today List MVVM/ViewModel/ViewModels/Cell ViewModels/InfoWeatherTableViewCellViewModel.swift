//
//  InfoWeatherTableViewCellViewModel.swift
//  Weather-App
//
//  Created by Марк Киричко on 20.02.2024.
//

import Foundation

class InfoWeatherTableViewCellViewModel {
    
    var wind: String
    var rain: String
    var sun: String
    var clouds: String
    
    init(wind: String, rain: String, sun: String, clouds: String) {
        self.wind = wind
        self.rain = rain
        self.sun = sun
        self.clouds = clouds
    }
}
