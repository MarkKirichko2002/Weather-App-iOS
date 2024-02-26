//
//  ISavedCitiesListViewModel.swift
//  Weather-App
//
//  Created by Марк Киричко on 13.02.2024.
//

import Foundation

protocol ISavedCitiesListViewModel {
    var cities: [String] {get set}
    var isFetched: Bindable<Bool> {get set}
    func getCities()
    func removeCity(name: String)
}
