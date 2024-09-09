//
//  Disability.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-11.
//

import Foundation

struct Disability: HealthValueMeasurement, Codable, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name = "Disability"
    
    var date: Date
    
    var value: Double
    
    var unit = "Score"
    
    static func makeExample() -> Disability {
        Disability(id: UUID(), date: Date.now, value: 0.0)
    }
}
