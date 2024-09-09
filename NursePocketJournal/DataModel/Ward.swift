//
//  Ward.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-12-07.
//

import Foundation
import SwiftData
import CSFoundationLibrary

@Model
final class Ward: House {
    let id = UUID() // A unique identifier that never changes.
    
    var name: String
    
    var number: Int
    
    var hospital: Hospital?
    
    @Relationship(deleteRule: .cascade, inverse: \Room.ward) var rooms = [Room]()
    
    init(name: String, number: Int, rooms: [Room] = [Room]()) {
        self.name = name
        self.number = number
        self.rooms = rooms
    }
    
    // MARK: - functions goes here.
    static func makeExample() -> Ward {
        let ward = Ward(name: "1", number: 0)
        for i in 0 ... 9 {
            let room = Room.makeExample()
            room.name = String(i+1)
            room.number = i
            ward.rooms.append(room)
        }
        
        return ward
    }
}
// MARK: - Extensions goes here.
extension Ward {
    /// InternExample names for wards.
    enum WardNamed: String, CaseIterable, Codable, Identifiable {
        case bas, basOBS, pa, avd1, avd52, avd54, ma, ka, oa, none
        
        var id: Self { self }
        
        var stringLabel: String {
            switch self {
            case .bas:
                return "Beroendeakuten"
            case .basOBS:
                return "Observationsavdelning 7b"
            case .pa:
                return "Psykiatriska akuten"
            case .avd1:
                return "Avdelning 1"
            case .avd52:
                return "Avdelning 52"
            case .avd54:
                return "Avdelning 54"
            case .ma:
                return "Medicinakuten"
            case .ka:
                return "Kirurgakuten"
            case .oa:
                return "Ortopedakuten"
            case .none:
                return "Annat"
            }
        }
    }
}
