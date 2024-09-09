//
//  RespiratoryRate.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-11.
//

import Foundation

struct RespiratoryRate: HealthValueMeasurement, Codable, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name = "Respiratory Rate"
    
    var date: Date
    
    var value: Double
    
    var unit = ""
    
    static func makeExample() -> RespiratoryRate {
        RespiratoryRate(id: UUID(), date: Date.now, value: 15.0)
    }
}
