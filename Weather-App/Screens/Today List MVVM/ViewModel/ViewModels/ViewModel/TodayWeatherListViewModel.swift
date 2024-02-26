//
//  TodayWeatherListViewModel.swift
//  Weather-App
//
//  Created by Марк Киричко on 10.02.2024.
//

import CoreLocation
import Combine
import WeatherKit

@available(iOS 16.0, *)
class TodayWeatherListViewModel: ITodayWeatherListViewModel {
    
    var locationManager: ILocationManager
    var weatherService: IWeatherManager
    var dateManager: IDateManager
    var dataStorageManager: IDataStorageManager
    
    var currentWeather: CurrentWeatherTableViewCellViewModel?
    var weatherInfo: InfoWeatherTableViewCellViewModel?
    var hourlyWeather = [HourlyWeatherCollectionViewCellViewModel]()
    var dailyWeather = [DailyWeatherTableViewCellViewModel]()
    
    var currentCity: String = ""
    var weather: Weather?
    
    @Published var isFetched: Bool = false
    
    init(locationManager: ILocationManager, weatherService: IWeatherManager, dateManager: IDateManager, dataStorageManager: IDataStorageManager) {
        self.locationManager = locationManager
        self.weatherService = weatherService
        self.dateManager = dateManager
        self.dataStorageManager = dataStorageManager
    }
    
    func getCurrentLocation() {
        let isAuth = locationManager.checkLocationAuthorization()
        if isAuth {
            locationManager.getLocations()
            locationManager.registerLocationHandler { location in
                Task {
                    guard let city = try await self.locationManager.getCity(by: location) else {return}
                    self.currentCity = city
                    self.getWeather(location: location)
                }
            }
        }
    }
    
    func getLocation(by name: String) {
        currentWeather = nil
        hourlyWeather = []
        dailyWeather = []
        Task {
            guard let location = try await locationManager.getCoordinates(by: name) else {return}
            guard let city = try await locationManager.getCity(by: location) else {return}
            self.currentCity = city
            dataStorageManager.saveCity(name: city)
            self.getWeather(location: location)
        }
    }
    
    func getWeather(location: CLLocation) {
        Task {
            let result = try await self.weatherService.getWeather(location: location)
            switch result {
            case .success(let data):
                // текущая погода
                setUpCurrentWeather(weather: data)
                // информация о ветре/дожде/солнце/облаках
                setUpWeatherInfo(weather: data)
                // погода по часам
                setUpHourlyWeather(weather: data)
                // погода на 5 дней
                setUpDailyWeather(weather: data)
                self.weather = data
                self.isFetched.toggle()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setUpCurrentWeather(weather: Weather) {
        let currentWeatherModel = CurrentWeatherTableViewCellViewModel(icon: weather.currentWeather.symbolName, city: currentCity, temperature: Int(weather.currentWeather.temperature.value), condition: formatCondition(weather: weather.currentWeather.condition), maxTemperature: Int(weather.dailyForecast[0].highTemperature.value), minTemperature: Int(weather.dailyForecast[0].lowTemperature.value))
        self.currentWeather = currentWeatherModel
    }
    
    func setUpWeatherInfo(weather: Weather) {
        let wind = "скорость ветра: \(Int(weather.currentWeather.wind.speed.value)) м/с"
        let rain = "количество осадков: \(Int(weather.dailyForecast[0].rainfallAmount.value))"
        let sun = "восход \(dateManager.getTime(from: weather.dailyForecast[0].sun.sunrise ?? Date()))"
        let clouds = "облачность: \(Int(weather.currentWeather.cloudCover.magnitude * 100)) %"
        let infoWeatherModel = InfoWeatherTableViewCellViewModel(wind: wind, rain: rain, sun: sun, clouds: clouds)
        self.weatherInfo = infoWeatherModel
    }
    
    func setUpHourlyWeather(weather: Weather) {
        var h = Calendar.current.component(.hour, from: weather.currentWeather.date)
        for _ in 0...24 {
            h += 1
            let hour = Calendar.current.component(.hour, from: weather.hourlyForecast[h].date)
            let hourlyWeatherModel = HourlyWeatherCollectionViewCellViewModel(hour: hour, icon: weather.hourlyForecast.forecast[hour].symbolName, temperature: Int(weather.hourlyForecast.forecast[hour].temperature.value))
            hourlyWeather.append(hourlyWeatherModel)
        }
    }
    
    func setUpDailyWeather(weather: Weather) {
        for i in 0...4 {
            let day = Calendar.current.component(.weekday, from: weather.dailyForecast[i].date)
            let dailyWeatherModel = DailyWeatherTableViewCellViewModel(dayOfWeek: "\(dateManager.getCurrentDayOfWeek(day: day - 1))", weatherIcon: weather.dailyForecast[i].symbolName, minTemperature: Int(weather.dailyForecast[i].lowTemperature.value), maxTemperature: Int(weather.dailyForecast[i].highTemperature.value))
            dailyWeather.append(dailyWeatherModel)
        }
    }
    
    func refresh() {
        getLocation(by: currentCity)
    }
    
    func convertToCelsius() {
        guard let weather = weather else {return}
        currentWeather = nil
        hourlyWeather = []
        dailyWeather = []
        setUpCurrentWeather(weather: weather)
        setUpHourlyWeather(weather: weather)
        setUpDailyWeather(weather: weather)
        self.isFetched.toggle()
    }
    
    func convertToFahrenheit() {
        guard let weather = weather else {return}
        currentWeather = nil
        hourlyWeather = []
        dailyWeather = []
        setUpCurrentWeather(weather: weather)
        setUpHourlyWeather(weather: weather)
        setUpDailyWeather(weather: weather)
        // текущая погода
        currentWeather?.temperature = currentWeather?.temperature.convert(unit: .fahrenheit) ?? 0
        currentWeather?.maxTemperature = currentWeather?.maxTemperature.convert(unit: .fahrenheit) ?? 0
        currentWeather?.minTemperature = currentWeather?.minTemperature.convert(unit: .fahrenheit) ?? 0
        // погода по часам
        hourlyWeather.forEach { item in
            item.temperature = item.temperature.convert(unit: .fahrenheit)
        }
        // погода на 5 дней
        dailyWeather.forEach { day in
            day.maxTemperature = day.maxTemperature.convert(unit: .fahrenheit)
            day.minTemperature = day.minTemperature.convert(unit: .fahrenheit)
        }
        self.isFetched.toggle()
    }
    
    func convertToCalvin() {
        guard let weather = weather else {return}
        currentWeather = nil
        hourlyWeather = []
        dailyWeather = []
        setUpCurrentWeather(weather: weather)
        setUpHourlyWeather(weather: weather)
        setUpDailyWeather(weather: weather)
        // текущая погода
        currentWeather?.temperature = currentWeather?.temperature.convert(unit: .calvin) ?? 0
        currentWeather?.maxTemperature = currentWeather?.maxTemperature.convert(unit: .calvin) ?? 0
        currentWeather?.minTemperature = currentWeather?.minTemperature.convert(unit: .calvin) ?? 0
        // погода по часам
        hourlyWeather.forEach { item in
            item.temperature = item.temperature.convert(unit: .calvin)
        }
        // погода на 5 дней
        dailyWeather.forEach { day in
            day.maxTemperature = day.maxTemperature.convert(unit: .calvin)
            day.minTemperature = day.minTemperature.convert(unit: .calvin)
        }
        self.isFetched.toggle()
    }
    
    func formatCondition(weather: WeatherCondition)-> String {
        var condition = ""
        switch weather {
            case .blizzard:
                condition =  "Метель"
            case .blowingDust:
                condition = "Пыльный ветер"
            case .blowingSnow:
                condition = "Метель с поземкой"
            case .breezy:
                condition = "Ветрено"
            case .clear:
                condition = "Ясно"
            case .cloudy:
                condition = "Облачно"
            case .drizzle:
                condition = "Изморось"
            case .flurries:
                condition =  "Снежные заряды"
            case .foggy:
                condition = "Туманно"
            case .freezingDrizzle:
                condition = "Замерзающая морось"
            case .freezingRain:
                condition = "Ледяной дождь"
            case .frigid:
                condition = "Морозно"
            case .hail:
                condition = "Град"
            case .haze:
                condition = "Мгла"
            case .heavyRain:
                condition = "Сильный дождь"
            case .heavySnow:
                condition = "Сильный снег"
            case .hot:
                condition = "Жарко"
            case .hurricane:
                condition = "Ураган"
            case .isolatedThunderstorms:
                condition = "Местами грозы"
            case .mostlyClear:
                condition = "Преимущественно ясно"
            case .mostlyCloudy:
                condition = "Преимущественно облачно"
            case .partlyCloudy:
                condition = "Переменная облачность"
            case .rain:
                condition = "Дождь"
            case .scatteredThunderstorms:
                condition = "Рассеянные грозы"
            case .sleet:
                condition = "Мокрый снег"
            case .smoky:
                condition = "Туман от дыма"
            case .snow:
                condition = "Снег"
            case .strongStorms:
                condition = "Сильные бури"
            case .sunFlurries:
                condition = "Снежные продувки"
            case .sunShowers:
                condition = "Солнечные ливни"
            case .thunderstorms:
                condition = "Грозы"
            case .tropicalStorm:
                condition = "Тропический шторм"
            case .windy:
                condition = "Ветрено"
            case .wintryMix:
                condition = "Зимняя смесь"
        @unknown default:
            break
        }
        return condition
    }
}
