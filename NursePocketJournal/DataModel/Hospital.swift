//
//  Hospital.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-12-07.
//

import Foundation
import SwiftData

@Model
final class Hospital: House {
    let id = UUID() // A unique identifier that never changes.
    
    var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \Ward.hospital) var wards = [Ward]()
    
    init(name: String, wards: [Ward] = [Ward]()) {
        self.name = name
        self.wards = wards
    }
    
    // MARK: - functions goes here.
    static func makeExample() -> Hospital {
        let hospital = Hospital(name: "1")
        for i in 0 ... 9 {
            let ward = Ward.makeExample()
            ward.name = String(i+1)
            ward.number = i
            hospital.wards.append(ward)
        }
        
        return hospital
    }
}
// MARK: - Extensions goes here.
extension Hospital {
    /// InternExample names for hospitals.
    enum ClinicNamed: String, CaseIterable, Codable, Identifiable {
        case bcs, nsp, stg, nks, hks, ds, nts, sts ,none
        
        var id: Self { self }
        
        var stringLabel: String {
            switch self {
            case .bcs:
                return "Beroendecentrum Stockholm"
            case .nsp:
                return "Norra Stockholms psykiatri"
            case .stg:
                return "Capio S:t Görans sjukhus"
            case .nks:
                return "Nya Karolinska sjukhus, Solna"
            case .hks:
                return "Karolinska sjukhus, Huddinge"
            case .ds:
                return "Danderyds sjukhus"
            case .nts:
                return "Norrtälje sjukhus"
            case .sts:
                return "Södertälje sjukhus"
            case .none:
                return "Annat"
            }
        }
    }
}
