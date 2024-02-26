//
//  LocationManager + Extensions.swift
//  Weather-App
//
//  Created by Марк Киричко on 08.02.2024.
//

import CoreLocation

extension LocationManager: ILocationManager {}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if !isUpdated {
                manager.stopUpdatingLocation()
                locationHandler?(location)
                print("location")
                isUpdated = true
            }
        }
    }
}
