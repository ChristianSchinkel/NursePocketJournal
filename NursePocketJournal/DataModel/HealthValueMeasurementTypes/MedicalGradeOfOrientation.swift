//
//  MedicalGradeOfOrientation.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-11.
//

import Foundation
import CSFoundationLibrary

struct MedicalGradeOfOrientation: HealthValueMeasurement, Codable, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name = "Medical Grade Of Orientation"
    
    var date: Date
    
    var value: Double
    
    var unit = "Score"
    
    static func makeExample() -> MedicalGradeOfOrientation {
        MedicalGradeOfOrientation(id: UUID(), date: Date.now, value: 0.0)
    }
}
