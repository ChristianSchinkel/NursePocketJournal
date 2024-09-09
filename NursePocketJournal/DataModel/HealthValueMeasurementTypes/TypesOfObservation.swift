//
//  TypesOfObservation.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-12-28.
//

import Foundation

struct TypesOfObservation: HealthValueMeasurement, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name: String = "TypesOfObservation"
    
    var date: Date
    
    var value: Double
    
    var unit: String = "Niveau"
    
    static func makeExample() -> TypesOfObservation {
        TypesOfObservation(id: UUID(), date: Date.now, value: 0.0)
    }
}
