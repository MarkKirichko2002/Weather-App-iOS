//
//  ITodayWeatherListViewModel.swift
//  Weather-App
//
//  Created by Марк Киричко on 10.02.2024.
//

import WeatherKit
import MapKit

@available(iOS 16.0, *)
protocol ITodayWeatherListViewModel {
    var currentWeather: CurrentWeatherTableViewCellViewModel? {get set}
    var hourlyWeather: [HourlyWeatherCollectionViewCellViewModel] {get set}
    var dailyWeather: [DailyWeatherTableViewCellViewModel] {get set}
    func getCurrentLocation()
    func getLocation(by name: String)
    func getWeather(location: CLLocation)
    func setUpCurrentWeather(weather: Weather)
    func setUpWeatherInfo(weather: Weather)
    func setUpHourlyWeather(weather: Weather)
    func setUpDailyWeather(weather: Weather)
    func refresh()
    func convertToCelsius()
    func convertToFahrenheit()
    func convertToCalvin()
    func formatCondition(weather: WeatherCondition)-> String
}
