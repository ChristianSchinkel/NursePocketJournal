//
//  BehaviouralStatusIndex.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-11.
//

import Foundation

struct BehaviouralStatusIndex: Codable, Exemplifiable {
    
    
    let id: UUID // A unique identifier that never changes.
    
    var name = "Behavioural Status Index"
    
    var date: Date
    
    var value: Double {
        attackingObjects.representedAsDouble +
        boisterous.representedAsDouble +
        confused.representedAsDouble +
        irritable.representedAsDouble +
        physicalThreats.representedAsDouble +
        verbalThreats.representedAsDouble
    }
    
    var unit = "Score"
    // MARK: - BVC poäng - Categories
    var attackingObjects: Bool
    var boisterous: Bool
    var confused: Bool
    var irritable: Bool
    var physicalThreats: Bool
    var verbalThreats: Bool
    
    static func makeExample() -> BehaviouralStatusIndex {
        BehaviouralStatusIndex(id: UUID(), date: Date.now, attackingObjects: false, boisterous: false, confused: false, irritable: false, physicalThreats: false, verbalThreats: true)
    }
}
