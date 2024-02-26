//
//  SavedCitiesListViewModel.swift
//  Weather-App
//
//  Created by Марк Киричко on 13.02.2024.
//

import Foundation

class SavedCitiesListViewModel: ISavedCitiesListViewModel {
    
    var isFetched = Bindable<Bool>(false)
    
    var cities = [String]()
        
    var dataStorageManager: IDataStorageManager
    
    init(dataStorageManager: IDataStorageManager) {
        self.dataStorageManager = dataStorageManager
    }
    
    func getCities() {
        cities = dataStorageManager.loadCities()
        isFetched.value.toggle()
    }
    
    func removeCity(name: String) {
        dataStorageManager.deleteCity(name: name)
        getCities()
        isFetched.value.toggle()
    }
}
