//
//  Excrement.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-11.
//

import Foundation
import CSFoundationLibrary

struct Excrement: HealthValueMeasurement, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name = "Excrement"
    
    var date: Date
    
    var value: Double
    
    var unit = "ml"
    
    static func makeExample() -> Excrement {
        Excrement(id: UUID(), date: Date.now, value: 200.0)
    }
}
