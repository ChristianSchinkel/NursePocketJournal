//
//  Faeces.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-11.
//

import Foundation
import CSFoundationLibrary

struct Faeces: HealthValueMeasurement, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name = "Faeces"
    
    var date: Date
    
    var value: Double
    
    var unit = "g"
    
    static func makeExample() -> Faeces {
        Faeces(id: UUID(), date: Date.now, value: 400.0)
    }
}
