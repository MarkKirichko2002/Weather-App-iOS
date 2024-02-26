//
//  WeatherTabBarController.swift
//  Weather-App
//
//  Created by Марк Киричко on 08.02.2024.
//

import UIKit

private extension String {
    static let barButtonItemTitle = "Сегодня"
    static let barButtonItemIcon = "cloud"
    static let barButtonItemIconSelected = "cloud.fill"
}

@available(iOS 16.0, *)
class WeatherTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    private func setUpTabs() {
        let container = Injection.makeContainer()
        let todayVC = TodayWeatherListTableViewController(todayWeatherListViewModel: container.resolve(ITodayWeatherListViewModel.self) as! TodayWeatherListViewModel)
        todayVC.tabBarItem = UITabBarItem(title: String.barButtonItemTitle, image: UIImage(systemName: String.barButtonItemIcon)!, selectedImage: UIImage(systemName: String.barButtonItemIconSelected)!)
        let navVC1 = UINavigationController(rootViewController: todayVC)
        setViewControllers([navVC1], animated: true)
    }
}
