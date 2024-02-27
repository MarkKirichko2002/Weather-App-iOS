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
    
    private var factory: IScreenFactory
    
    init(factory: IScreenFactory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    private func setUpTabs() {
        let todayVC = factory.createScreen(screen: .today)
        todayVC.tabBarItem = UITabBarItem(title: String.barButtonItemTitle, image: UIImage(systemName: String.barButtonItemIcon)!, selectedImage: UIImage(systemName: String.barButtonItemIconSelected)!)
        let navVC1 = UINavigationController(rootViewController: todayVC)
        setViewControllers([navVC1], animated: true)
    }
}
