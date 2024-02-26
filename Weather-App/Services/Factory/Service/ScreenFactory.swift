//
//  ScreenFactory.swift
//  Weather-App
//
//  Created by Марк Киричко on 10.02.2024.
//

import UIKit

enum Screen {
    case today
}

@available(iOS 16.0, *)
class ScreenFactory: IScreenFactory {
    
    func createScreen(screen: Screen)-> UIViewController {
        switch screen {
        case .today:
            guard let dependency = Injection.makeContainer().resolve(ITodayWeatherListViewModel.self) else {fatalError()}
            return TodayWeatherListTableViewController(todayWeatherListViewModel: dependency as! TodayWeatherListViewModel)
        }
    }
}
