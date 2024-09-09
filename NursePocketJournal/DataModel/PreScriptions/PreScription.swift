//
//  PreScription.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-12-22.
//

import Foundation
import SwiftData
import CSFoundationLibrary

@Model
/// A prescription of a medicine with all the medications related to this prescription.
final class PreScription: Identifiable, Exemplifiable {
    let id = UUID() // A unique identifier that never changes.
    /// Date when the preskription was made.
    let preScriptionDate: Date
    
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
    /// If the this PreScription can be given as Needed.
    var asNeeded: Bool
    /// The max amount to administrate per day.
    var asNeededMaxDoseAmount: Double?
    /// The max amount's unit to administrate per day.
    var asNeededMaxDoseAmountUnit: Care.Medicine.AmountUnit?
    /// The max strength to administrate.
    var asNeededMaxDoseStrengthValue: Double?
    /// The max strength's unit to administrate
    var asNeededMaxDoseStrengthValueUnit: Care.Medicine.Unit?
    
//    var asNeededMaxDosePerDayDate: Date
    
    /// An optional instruction to the patient och administrator.
    var instruction: String?
    
    
    /// The start of treatment.
    var startDate: Date
    /// The reason why medicine is prescribed.
    var reasonOfPrescribing: String?
    
    /// If the medicine should not be replaced by a generic medicine.
    var shouldNotBeReplaced: Bool
    /// The reason why the medicine should not be replaced by a generic medicine.
    var shouldNotBeReplacedReason: String?

    /// The end of treatment.
    var endDate: Date
    /// The reason why treatment ends.
    var endDateReason: String?
    /// The Medication-tiles that are relatet to this PreScription.
    @Relationship(deleteRule: .cascade) var medications = [Medication]() // TODO: Uncomment to Store Medications
    
    
    init(preScriptionDate: Date, medicine: Medicine, amount: Double, amountUnit: Care.Medicine.AmountUnit, mode: Care.Medicine.ModeOfAdministration, frequency: Care.Medicine.Frequency, asNeeded: Bool, asNeededMaxDoseAmount: Double? = nil, asNeededMaxDoseAmountUnit: Care.Medicine.AmountUnit? = nil, asNeededMaxDoseStrengthValue: Double? = nil, asNeededMaxDoseStrengthValueUnit: Care.Medicine.Unit? = nil, instruction: String? = nil, startDate: Date, reasonOfPrescribing: String? = nil, shouldNotBeReplaced: Bool, shouldNotBeReplacedReason: String? = nil, endDate: Date, endDateReason: String? = nil) {
        self.preScriptionDate = preScriptionDate
        self.medicine = medicine
        self.amount = amount
        self.amountUnit = amountUnit
        self.mode = mode
        self.frequency = frequency
        self.asNeeded = asNeeded
        self.asNeededMaxDoseAmount = asNeededMaxDoseAmount
        self.asNeededMaxDoseAmountUnit = asNeededMaxDoseAmountUnit
        self.asNeededMaxDoseStrengthValue = asNeededMaxDoseStrengthValue
        self.asNeededMaxDoseStrengthValueUnit = asNeededMaxDoseStrengthValueUnit
        self.instruction = instruction
        self.startDate = startDate
        self.reasonOfPrescribing = reasonOfPrescribing
        self.shouldNotBeReplaced = shouldNotBeReplaced
        self.shouldNotBeReplacedReason = shouldNotBeReplacedReason
        self.endDate = endDate
        self.endDateReason = endDateReason
    }
    // MARK: - functions goes here.
    static func makeExample() -> PreScription {
//        PreScription(preScriptionDate: Date.now, medicine: Medicine.makeExample(), amount: 1.0, amountUnit: .pieces, mode: .oral, frequency: .atRegularIntervals, asNeeded: false, startDate: Date.now, shouldNotBeReplaced: false, endDate: Date.TwoWeeksLater(from: Date.now))
        let newPreScription = PreScription(preScriptionDate: Date.now, medicine: Medicine.makeExample(), amount: 1.0, amountUnit: .pieces, mode: .oral, frequency: .atRegularIntervals, asNeeded: false, asNeededMaxDoseAmount: 4.0, asNeededMaxDoseAmountUnit: .milliGram, asNeededMaxDoseStrengthValue: 40.0, asNeededMaxDoseStrengthValueUnit: .milliGram, instruction: "vid agitation/drogutlöst psykos.", startDate: Date.now, reasonOfPrescribing: "Drogutlöst psykos.", shouldNotBeReplaced: false, shouldNotBeReplacedReason: "no information.", endDate: Date.TwoWeeksLater(from: Date.now), endDateReason: "Planerad utsättning.")
        
        newPreScription.medications.append(Medication.makeExample())
        
        return newPreScription
    }
    // TODO: Adds a task to the Prescription, to track the medicines
    /// Adds a task to track the medication
    static func addMedication(from startDate: Date, to endDate: Date) {
        let tempDate = startDate // temporär date
        
        var count = 0 // Variable to track how many times the while-loop has been executed.
        
        while tempDate <= endDate {
            print("The medicine has been added \(count) time(s).") // Counts how many times the medicine has been added to the array of medicine-time-tiles.
            // TODO: Add medicinetile to the array in PreScription
            // Change tempDate to next
            // tempDate = Date.nextDay(from: tempDate)
            print(tempDate)
            count += 1
            
        }
    }
}
