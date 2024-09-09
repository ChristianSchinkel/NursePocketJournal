//
//  BloodOxygenGoal.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-05.
//

import Foundation
import CSFoundationLibrary

struct BloodOxygenGoal: HealthValueMeasurement, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name = "Blood Oxygen Goal"
    
    var date: Date
    
    var value: Double
    
    var unit = "%"
    
    static func makeExample() -> BloodOxygenGoal {
        BloodOxygenGoal(id: UUID(), date: Date.now, value: 98.0)
    }
}
