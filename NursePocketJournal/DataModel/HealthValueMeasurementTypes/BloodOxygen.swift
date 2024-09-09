//
//  BloodOxygen.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-11.
//

import Foundation
import CSFoundationLibrary

struct BloodOxygen: HealthValueMeasurement, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name = "Blood Oxygen"
    
    var date: Date
    
    var value: Double
    
    var unit = "%"
    
    static func makeExample() -> BloodOxygen {
        BloodOxygen(id: UUID(), date: Date.now, value: 98.0)
    }
}
