//
//  DataStorageManager.swift
//  Weather-App
//
//  Created by Марк Киричко on 13.02.2024.
//

import Foundation

class DataStorageManager: IDataStorageManager {
    
    func saveCity(name: String) {
        var cities = loadCities()
        if !cities.contains(name) {
            cities.append(name)
            UserDefaults.standard.setValue(cities, forKey: "cities")
        }
    }
    
    func deleteCity(name: String) {
        var cities = loadCities()
        if let index = cities.firstIndex(of: name) {
            cities.remove(at: index)
            UserDefaults.standard.setValue(cities, forKey: "cities")
        }
    }
    
    func loadCities()-> [String] {
        let cities = UserDefaults.standard.array(forKey: "cities") as? [String] ?? []
        return cities
    }
}
