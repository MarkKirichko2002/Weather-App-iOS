//
//  LocationManager.swift
//  Weather-App
//
//  Created by Марк Киричко on 08.02.2024.
//

import CoreLocation

class LocationManager: NSObject {
    
    private let manager = CLLocationManager()
    
    var locationHandler: ((CLLocation)->Void)?
    
    var isUpdated = false
    
    func getCoordinates(by location: String) async throws -> CLLocation? {
        let geocoder = CLGeocoder()
        let data = try await geocoder.geocodeAddressString(location)
        
        if let placemark = data.first, let location = placemark.location {
            return location
        }
        return nil
    }
    
    func getCity(by coordinates: CLLocation) async throws -> String? {
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.reverseGeocodeLocation(coordinates)
        if let placemark = placemarks.first {
            if let cityName = placemark.locality {
                return cityName
            }
        }
        return nil
    }
    
    func getLocations() {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func checkLocationAuthorization()-> Bool {
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            return true
        } else if status == .restricted || status == .denied {
            return false
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            return true
        }
        return false
    }
    
    func registerLocationHandler(block: @escaping(CLLocation)->Void) {
        self.locationHandler = block
    }
}
