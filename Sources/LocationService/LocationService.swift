//
//  LocationService.swift
//  Weather App
//
//  Created by Yoji on 03.04.2024.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {
    private lazy var manager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    var isAuthorized: Bool {
        let authorizationStatus = self.manager.authorizationStatus
        return authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse
    }
    
    var isNotDeterminedAuthorization: Bool {
        return self.manager.authorizationStatus == .notDetermined
    }
    
    var completion: ()->Void = {}
    
    func getLocation(completion: @escaping (Coordinates)->Void) {
        self.manager.requestLocation()
        guard
            let newCoordinates = self.manager.location?.coordinate.coordinates
        else {
            completion(Coordinates())
            return
        }
        completion(newCoordinates)
    }
    
    func requestWhenInUseAuthorization(completion: @escaping ()->Void) {
        if self.manager.authorizationStatus == .notDetermined {
            self.manager.requestWhenInUseAuthorization()
            self.completion = completion
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        completion()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("🔴 CoreLocation error: \(error.localizedDescription)")
    }
}
