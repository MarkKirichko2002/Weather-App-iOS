//
//  ScreenFactory.swift
//  Weather-App
//
//  Created by Марк Киричко on 10.02.2024.
//

import UIKit

enum Screen {
    case splash
    case tabbar
    case today
    case cities
}

@available(iOS 16.0, *)
class ScreenFactory: IScreenFactory {
    
    func createScreen(screen: Screen)-> UIViewController {
        switch screen {
        case .splash:
            guard let depedency = Injection.makeContainer().resolve(IScreenFactory.self) else {fatalError()}
            return SplashViewController(factory: depedency)
        case .tabbar:
            guard let depedency = Injection.makeContainer().resolve(IScreenFactory.self) else {fatalError()}
            return WeatherTabBarController(factory: depedency)
        case .today:
            guard let dependency = Injection.makeContainer().resolve(TodayWeatherListViewModel.self) else {fatalError()}
            return TodayWeatherListTableViewController(todayWeatherListViewModel: dependency)
        case .cities:
            guard let dependency = Injection.makeContainer().resolve(ISavedCitiesListViewModel.self) else {fatalError()}
            return SavedCitiesListTableViewController(viewModel: dependency)
        }
    }
}
