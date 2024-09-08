//
//  Room.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-12-07.
//

import Foundation
import SwiftData

@Model
final class Room: House {
    let id = UUID() // A unique identifier that never changes.
    
    var name: String
    
    var number: Int
    
    var ward: Ward?
    
    var patient: Patient? // one-to-one or zero-to-one relationship.
    
    init(name: String, number: Int) {
        self.name = name
        self.number = number
    }
    
    // MARK: - functions goes here.
    static func makeExample() -> Room {
        Room(name: "1", number: 0)
    }
}
// MARK: - Extensions goes here.
extension Room {
    /// InternExample names for rooms.
    enum RoomNamed: String, CaseIterable, Codable, Identifiable {
        case rum01, rum02, rum03, rum041, rum042, rum051, rum052, rum06, rum07, rum081, rum082, rum091, rum092, rum101, rum102, rum111, rum112, rum121, rum122, rum131, rum132, none
        
        var id: Self { self }
        
        var stringLabel: String {
            switch self {
            case .rum01:
                return "Rum 1:"
            case .rum02:
                return "Rum 2:"
            case .rum03:
                return "Rum 3:"
            case .rum041:
                return "Rum 4:1"
            case .rum042:
                return "Rum 4:2"
            case .rum051:
                return "Rum 5:1"
            case .rum052:
                return "Rum 5:2"
            case .rum06:
                return "Rum 6:"
            case .rum07:
                return "Rum 7:"
            case .rum081:
                return "Rum 8:1"
            case .rum082:
                return "Rum 8:2"
            case .rum091:
                return "Rum 9:1"
            case .rum092:
                return "Rum 9:2"
            case .rum101:
                return "Rum 10:1"
            case .rum102:
                return "Rum 10:2"
            case .rum111:
                return "Rum 11:1"
            case .rum112:
                return "Rum 11:2"
            case .rum121:
                return "Rum 12:1"
            case .rum122:
                return "Rum 12:2"
            case .rum131:
                return "Rum 13:1"
            case .rum132:
                return "Rum 13:2"
            case .none:
                return "Rum ???"
            }
        }
    }
}
