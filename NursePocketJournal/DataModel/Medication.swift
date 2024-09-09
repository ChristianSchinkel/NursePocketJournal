//
//  Medication.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-02-23.
//

import Foundation
import SwiftData

@Model
/// A medication.
final class Medication: Identifiable, Exemplifiable {
    let id = UUID() // A unique identifier that never changes.
    /// Date the medication can be administrated; date to sort medications in an array.
    let date: Date
    
    /// The prescripted medicine in this PreScription.
    var medicine: Medicine
    /// The amount of medicine to administrate.
    var amount: Double
    /// The amount's unit to administrate; piece, volume, etc.
    var amountUnit: Care.Medicine.AmountUnit
    /// The Total strength represented computed as double in metric number system.
    var totalStrength: Double {
        medicine.strengthValue * amount
    }
    /// The Mode of administration - how to administrate the medicine.
    var mode: Care.Medicine.ModeOfAdministration
    
    /// The frequency.
    var frequency: Care.Medicine.Frequency
    // MARK: Properties to track if a medicine was administrated, preScripted by a doctor or skipped
    /* At the moment i don't know were to store this data - so I store it here for the future.*/
    /// Date when a medicine administrates.
    var confirmedDate: Date?
    /// If the medicine is administrated.
    var isConfirmed: Bool
    /// If the medicine is scheduled.
    var isPlanned: Bool
    /// If the medicine is prescripted by a physician; in case of false a physician needs to be consulted to prescribe in written form.
    var isPrescripted: Bool
    /// If the medicine was skipped.
    var isSkipped: Bool?
    /// Date when the medicine was skipped.
    var skippedDate: Date?
    
    init(date: Date, medicine: Medicine, amount: Double, amountUnit: Care.Medicine.AmountUnit, mode: Care.Medicine.ModeOfAdministration, frequency: Care.Medicine.Frequency, confirmedDate: Date? = nil, isConfirmed: Bool, isPlanned: Bool, isPrescripted: Bool, isSkipped: Bool? = nil, skippedDate: Date? = nil) {
        self.date = date
        self.medicine = medicine
        self.amount = amount
        self.amountUnit = amountUnit
        self.mode = mode
        self.frequency = frequency
        self.confirmedDate = confirmedDate
        self.isConfirmed = isConfirmed
        self.isPlanned = isPlanned
        self.isPrescripted = isPrescripted
        self.isSkipped = isSkipped
        self.skippedDate = skippedDate
    }
    
    // MARK: - functions goes here.
    static func makeExample() -> Medication {
        Medication(date: Date.nextDay(from: Date.now), medicine: Medicine.makeExample(), amount: 1.0, amountUnit: .pieces, mode: .oral, frequency: .atRegularIntervals, confirmedDate: Date.now, isConfirmed: true, isPlanned: true, isPrescripted: true, isSkipped: false, skippedDate: Date.now)
    }
}
