//
//  BodyTemperature.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-11.
//

import Foundation

struct BodyTemperature: HealthValueMeasurement, Codable, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name = "Body Temperature"
    
    var date: Date
    
    var value: Double
    
    var unit = "°C"
    
    static func makeExample() -> BodyTemperature {
        BodyTemperature(id: UUID(), date: Date.now, value: 37.0)
    }
}
