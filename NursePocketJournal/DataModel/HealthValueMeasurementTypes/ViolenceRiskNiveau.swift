//
//  ViolenceRiskNiveau.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-12-28.
//

import Foundation
import CSFoundationLibrary

struct ViolenceRiskNiveau: HealthValueMeasurement, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name: String = "ViolenceRiskNiveau"
    
    var date: Date
    
    var value: Double
    
    var unit: String = "Niveau"
    
    static func makeExample() -> ViolenceRiskNiveau {
        ViolenceRiskNiveau(id: UUID(), date: Date.now, value: 0.0)
    }
}
