//
//  HeartRate.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-11.
//

import Foundation
import CSFoundationLibrary

struct HeartRate: HealthValueMeasurement, Codable, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name = "HeartRate"
    
    var date: Date
    
    var value: Double
    
    var unit = "BPM"
    
    static func makeExample() -> HeartRate {
        HeartRate(id: UUID(), date: Date.now, value: 60.0)
    }
}
