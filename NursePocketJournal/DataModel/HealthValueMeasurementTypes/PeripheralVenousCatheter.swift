//
//  PeripheralVenousCatheter.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-11.
//

import Foundation
import CSFoundationLibrary

struct PeripheralVenousCatheter: HealthValueMeasurement, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name = "Peripheral Venous Catheter"
    
    var date: Date
    
    var value: Double
    
    var unit = ""
    
    static func makeExample() -> PeripheralVenousCatheter {
        PeripheralVenousCatheter(id: UUID(), date: Date.now, value: 0.0)
    }
}
