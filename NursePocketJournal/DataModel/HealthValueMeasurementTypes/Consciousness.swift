//
//  Consciousness.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-11.
//

import Foundation
import CSFoundationLibrary

struct Consciousness: HealthValueMeasurement, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name = "Consciousness"
    
    var date: Date
    
    var value: Double
    
    var unit = "Score"
    
    static func makeExample() -> Consciousness {
        Consciousness(id: UUID(), date: Date.now, value: 0.0)
    }
}
