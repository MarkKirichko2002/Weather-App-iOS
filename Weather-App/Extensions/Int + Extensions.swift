//
//  Int + Extensions.swift
//  Weather-App
//
//  Created by Марк Киричко on 16.02.2024.
//

import Foundation

enum Unit {
    case fahrenheit
    case calvin
}

extension Int {
    
    func convert(unit: Unit)-> Self {
        switch unit {
        case .fahrenheit:
            return convertToFahrenheit()
        case .calvin:
            return convertToCalvin()
        }
    }
    
    private func convertToFahrenheit()-> Self {
        return (self * 9/5) + 32
    }
    
    private func convertToCalvin()-> Self {
        return self + 273
    }
}
