//
//  WeatherManager.swift
//  Weather-App
//
//  Created by Марк Киричко on 10.02.2024.
//

import WeatherKit
import CoreLocation

@available(iOS 16.0, *)
class WeatherManager: IWeatherManager {
    
    private let service = WeatherService()
    
    func getWeather(location: CLLocation) async throws -> Result<Weather, Error> {
        do {
            let weather = try await service.weather(for: location)
            return .success(weather)
        } catch {
            return .failure(error)
        }
    }
}
