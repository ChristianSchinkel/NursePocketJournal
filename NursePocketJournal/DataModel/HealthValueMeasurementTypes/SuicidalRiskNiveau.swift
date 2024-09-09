//
//  SuicidalRiskNiveau.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-12-28.
//

import Foundation

struct SuicidalRiskNiveau: HealthValueMeasurement, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name: String = "SuicidalRiskNiveau"
    
    var date: Date
    
    var value: Double
    
    var unit: String = "Niveau"
    
    static func makeExample() -> SuicidalRiskNiveau {
        SuicidalRiskNiveau(id: UUID(), date: Date.now, value: 0.0)
    }
}
