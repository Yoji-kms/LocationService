//
//  Coordinates.swift
//  Weather App
//
//  Created by Yoji on 01.02.2024.
//

import Foundation

struct Coordinates: Equatable {
    let lat: Float
    let lon: Float
    
    init(lat: Float, lon: Float) {
        self.lat = lat
        self.lon = lon
    }
    
    init(coordinates: String) {
        let coordinatesSplit = coordinates
            .split(separator: " ")
            .map { Float($0) ?? 0 }
        
        self.lat = coordinatesSplit[1]
        self.lon = coordinatesSplit[0]
    }
    
    init() {
        self.lat = 0
        self.lon = 0
    }
}
