//
//  BreathAlcoholLevel.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-11.
//

import Foundation
import CSFoundationLibrary

struct BreathAlcoholLevel: HealthValueMeasurement, Codable, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name = "Breath Alcohol Level"
    
    var date: Date
    
    var value: Double
    
    var unit = "‰"
    
    static func makeExample() -> BreathAlcoholLevel {
        BreathAlcoholLevel(id: UUID(), date: Date.now, value: 1.24)
    }
}
