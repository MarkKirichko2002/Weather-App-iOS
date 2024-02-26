//
//  WeatherManager.swift
//  Weather-App
//
//  Created by Марк Киричко on 10.02.2024.
//

import CoreLocation
import WeatherKit

@available(iOS 16.0, *)
protocol IWeatherManager {
    func getWeather(location: CLLocation) async throws -> Result<Weather, Error>
}
