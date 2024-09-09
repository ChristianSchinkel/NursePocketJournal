//
//  BloodPressure.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-11.
//

import Foundation

struct BloodPressure {
    struct Systolic: HealthValueMeasurement, Exemplifiable {
        
        
        let id: UUID // A unique identifier that never changes.
        
        var name = "Systolic"
        
        var date: Date
        
        var value: Double
        
        var unit = "mm/Hg"
        
        static func makeExample() -> BloodPressure.Systolic {
            Systolic(id: UUID(), date: Date.now, value: 120.0)
        }
        
        
    }
    
    struct Diastolic: HealthValueMeasurement, Exemplifiable {
        
        
        let id: UUID
        
        var name = "Diastolic"
        
        var date: Date
        
        var value: Double
        
        var unit = "mm/Hg"
        
        static func makeExample() -> BloodPressure.Diastolic {
            Diastolic(id: UUID(), date: Date.now, value: 80.0)
        }
    }
}
