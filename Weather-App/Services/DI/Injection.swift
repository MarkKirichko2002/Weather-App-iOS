//
//  Injection.swift
//  Weather-App
//
//  Created by Марк Киричко on 10.02.2024.
//

import Swinject

class Injection {
    
    @available(iOS 16.0, *)
    static func makeContainer()-> Container {
        
        let container = Container()
        
        // MARK: - Services
        container.register(IDateManager.self) { _ in
            return DateManager()
        }
        container.register(ILocationManager.self) { _ in
            return LocationManager()
        }
        container.register(IWeatherManager.self) { _ in
            return WeatherManager()
        }
        container.register(IDataStorageManager.self) { _ in
            return DataStorageManager()
        }
        container.register(IScreenFactory.self) { _ in
            return ScreenFactory()
        }
        // MARK: - ViewModels
        container.register(TodayWeatherListViewModel.self) { resolver in
            let viewModel = TodayWeatherListViewModel(locationManager: resolver.resolve(ILocationManager.self)!, weatherService: resolver.resolve(IWeatherManager.self)!, dateManager: resolver.resolve(IDateManager.self)!, dataStorageManager: resolver.resolve(IDataStorageManager.self)!)
            return viewModel
        }
        container.register(ISavedCitiesListViewModel.self) { resolver in
            let viewModel = SavedCitiesListViewModel(dataStorageManager: resolver.resolve(IDataStorageManager.self)!)
            return viewModel
        }
        return container
    }
}
