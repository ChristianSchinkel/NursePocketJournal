//
//  UrineTestSubstance.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-14.
//

import Foundation

struct UrineTestSubstance: Codable, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name = "U-"
    
    var date: Date
    
    var value: Bool
    
    static func makeExample() -> UrineTestSubstance {
        UrineTestSubstance(id: UUID(), name: "U-AMP", date: Date.now, value: false)
    }
}
