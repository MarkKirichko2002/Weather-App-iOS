//
//  ILocationManager.swift
//  Weather-App
//
//  Created by Марк Киричко on 10.02.2024.
//

import CoreLocation

protocol ILocationManager {
    func getCoordinates(by location: String) async throws -> CLLocation?
    func getCity(by coordinates: CLLocation) async throws -> String?
    func getLocations()
    func checkLocationAuthorization()-> Bool
    func registerLocationHandler(block: @escaping(CLLocation)->Void)
}
