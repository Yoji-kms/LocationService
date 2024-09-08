//
//  LocationUtils.swift
//  Weather App
//
//  Created by Yoji on 27.05.2024.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    var coordinates: Coordinates {
        let latitude = Float(self.latitude)
        let longtitude = Float(self.longitude)
        return Coordinates(lat: latitude, lon: longtitude)
    }
}
