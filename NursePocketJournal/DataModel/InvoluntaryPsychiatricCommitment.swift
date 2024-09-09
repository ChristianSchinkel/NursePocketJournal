//
//  InvoluntaryPsychiatricCommitment.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-12-22.
//

import Foundation
import SwiftData
import CSFoundationLibrary

/// **Involuntary Psychiatric Commitment**
/// - Parameters:
///     - Date: When it has happened.
///     - isFixedLeftArm: Left arm is fixed.
///     - isFixedLeftLeg: Left leg is fixed.
///     - isFixedRightArm: Right arm is fixed.
///     - isFixedRightLeg: Right leg is fixed.
///     - isFixedWaist: Waist is fixed.
@Model
final class InvoluntaryPsychiatricCommitment: Identifiable, Exemplifiable {
    
    let id = UUID() // A unique identifier that never changes.
    
    var type: PsychiatricCommitmentTreatment
    
    var date: Date
    
    var patient: Patient?
    
    var isFixedLeftArm: Bool
    
    var isFixedLeftLeg: Bool
    
    var isFixedRightArm: Bool
    
    var isFixedRightLeg: Bool
    
    var isFixedWaist: Bool
    
    var isFixed: Bool {
        isFixedLeftArm.representedAsInteger +
        isFixedLeftLeg.representedAsInteger +
        isFixedRightArm.representedAsInteger +
        isFixedRightLeg.representedAsInteger +
        isFixedWaist.representedAsInteger != 0
    }
    
    init(type: PsychiatricCommitmentTreatment, date: Date, isFixedLeftArm: Bool, isFixedLeftLeg: Bool, isFixedRightArm: Bool, isFixedRightLeg: Bool, isFixedWaist: Bool) {
        self.type = type
        self.date = date
        self.isFixedLeftArm = isFixedLeftArm
        self.isFixedLeftLeg = isFixedLeftLeg
        self.isFixedRightArm = isFixedRightArm
        self.isFixedRightLeg = isFixedRightLeg
        self.isFixedWaist = isFixedWaist
    }
    // MARK: - functions goes here.
    func makeText(from isFixed: Bool) -> String {
        if isFixed {
            return "… is fixed."
        } else {
            return "… is free."
        }
    }
    static func makeExample() -> InvoluntaryPsychiatricCommitment {
        InvoluntaryPsychiatricCommitment(type: .physicalRestraint, date: Date.now, isFixedLeftArm: true, isFixedLeftLeg: true, isFixedRightArm: true, isFixedRightLeg: true, isFixedWaist: true)
    }
}
// MARK: - Extensions goes here.
extension InvoluntaryPsychiatricCommitment {
    enum PsychiatricCommitmentTreatment: String, CaseIterable, Identifiable, Codable {
        case isolation, physicalRestraint
        
        /// Object-identifier where id is **self**.
        var id: Self { self }
    }
}
