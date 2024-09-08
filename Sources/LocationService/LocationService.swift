//
//  LocationService.swift
//  Weather App
//
//  Created by Yoji on 03.04.2024.
//

import Foundation
import CoreLocation

public final class LocationService: NSObject {
    private lazy var manager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    public var isAuthorized: Bool {
        let authorizationStatus = self.manager.authorizationStatus
        return authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse
    }
    
    var isNotDeterminedAuthorization: Bool {
        return self.manager.authorizationStatus == .notDetermined
    }
    
    var completion: ()->Void = {}
    
    public func getLocation(completion: @escaping (Float, Float)->Void) {
        self.manager.requestLocation()
        guard
            let newCoordinate = self.manager.location?.coordinate
        else {
            completion(0, 0)
            return
        }
        let newLat = Float(newCoordinate.latitude)
        let newLon = Float(newCoordinate.longitude)
        completion(newLat, newLon)
    }
    
    public func requestWhenInUseAuthorization(completion: @escaping ()->Void) {
        if self.manager.authorizationStatus == .notDetermined {
            self.manager.requestWhenInUseAuthorization()
            self.completion = completion
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        completion()
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("🔴 CoreLocation error: \(error.localizedDescription)")
    }
}
