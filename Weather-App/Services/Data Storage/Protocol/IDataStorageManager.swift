//
//  IDataStorageManager.swift
//  Weather-App
//
//  Created by Марк Киричко on 13.02.2024.
//

import Foundation

protocol IDataStorageManager {
    func saveCity(name: String)
    func deleteCity(name: String)
    func loadCities()-> [String]
}
