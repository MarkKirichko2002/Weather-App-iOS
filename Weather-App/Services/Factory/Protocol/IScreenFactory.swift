//
//  IScreenFactory.swift
//  Weather-App
//
//  Created by Марк Киричко on 10.02.2024.
//

import UIKit

protocol IScreenFactory {
    func createScreen(screen: Screen)-> UIViewController
}
