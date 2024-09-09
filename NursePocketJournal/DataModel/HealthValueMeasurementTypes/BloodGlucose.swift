//
//  BloodGlucose.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-11.
//

import Foundation
import CSFoundationLibrary

struct BloodGlucose:HealthValueMeasurement, Codable, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name = "Blood Glucose"
    
    var date: Date
    
    var value: Double
    
    var unit = "mg/dL"
    
    static func makeExample() -> BloodGlucose {
        BloodGlucose(id: UUID(), date: Date.now, value: 5.8)
    }
}
