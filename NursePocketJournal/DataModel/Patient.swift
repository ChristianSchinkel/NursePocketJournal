//
//  Patient.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-16.
//

import Foundation
import SwiftData
import CSFoundationLibrary

@Model
/// A patient is a type of human being.
final class Patient: Identifiable, HumanlyNamed, Exemplifiable {
    let id = UUID() // A unique identifier that never changes.
    // MARK: Id: HumanlyNamed
    var name: String
    var familyName: String
    //    @Attribute(.unique)
    var swedishSocialSecurityNumber: String
    
    var admitted: Admitted
    
    @Relationship(deleteRule: .nullify, inverse: \Room.patient) var room: Room? // one-to-one or zero-to-one relationship.
    // MARK: Journal, data
    @Relationship(deleteRule: .cascade, inverse: \Journal.patient) var journals = [Journal]()
    @Relationship(deleteRule: .cascade) var preScriptions = [PreScription]() // TODO: Uncomment to Store PreScriptions
    @Relationship(deleteRule: .cascade) var medications = [Medication]() // TODO: Uncomment to Store Medications
    @Relationship(deleteRule: .cascade) var medicines = [Medicine]() // TODO: Check ifi have to remove the makro '@Relationship'
    @Relationship(deleteRule: .cascade, inverse: \InvoluntaryPsychiatricCommitment.patient) var involuntaryPsychiatricCommitments = [InvoluntaryPsychiatricCommitment]()
    // MARK: - Values start
    
    // MARK: Risk for suicidal action of the patient
    var sRisk = [SuicidalRiskNiveau]()
    // MARK: Risk for violently action of the patient
    var vRisk = [ViolenceRiskNiveau]()
    // MARK: Type of observation due to suicidal risk
    var type = [TypesOfObservation]()
    // MARK: Vitalparametrar
    var behaviouralStatusIndex = [BehaviouralStatusIndex]()
    var bloodGlucose = [BloodGlucose]()
    var bloodOxygen = [BloodOxygen]()
    var bloodOxygenGoal = [BloodOxygenGoal]()
    var bloodPressureSystolic = [BloodPressure.Systolic]()
    var bloodPressureDiastolic = [BloodPressure.Diastolic]()
    var bodyTemperature = [BodyTemperature]()
    var breathAlcoholLevel = [BreathAlcoholLevel]()
    var consciousness = [Consciousness]()
    var disability = [Disability]()
    var excrement = [Excrement]()
    var faeces = [Faeces]()
    var heartRate = [HeartRate]()
    var medicalGradeOfOrientation = [MedicalGradeOfOrientation]()
    var peripheralVenousCatheter = [PeripheralVenousCatheter]()
    var respiratoryRate = [RespiratoryRate]()
    // MARK: Test-results
    var urineTestSubstances = [UrineTestSubstance]()
    
    
    
    // MARK: - Values end
    var locker: Locker
    
    var timestamp: Date // Date patient was created - not the same as rapportDate.
    
    init(name: String, familyName: String, swedishSocialSecurityNumber: String, admitted: Admitted, locker: Locker, timestamp: Date) {
        self.name = name
        self.familyName = familyName
        self.swedishSocialSecurityNumber = swedishSocialSecurityNumber
        self.admitted = admitted
        self.locker = locker
        self.timestamp = timestamp
    }
    
    // MARK: - functions goes here.
    static func makeExample() -> Patient {
        let patient = Patient(name: "Tolvan", familyName: "Tolvansson", swedishSocialSecurityNumber: "19121212-1212", admitted: .no, locker: .a, timestamp: Date())
        patient.preScriptions.append(PreScription.makeExample())
        patient.medicines.append(Medicine.makeExample())
        patient.involuntaryPsychiatricCommitments.append(InvoluntaryPsychiatricCommitment.makeExample())
        
        return patient
    }
}
// MARK: - Extensions goes here.
extension Patient {
    /// The Locker a patient gets for there clothes.
    enum Locker: String, CaseIterable, Codable, Identifiable {
        case none, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z
        
        var id: Self { self }
    }
}

extension Patient {
    /// Admission: Cases where the patient is admitted and archived.
    enum Admitted: String, CaseIterable, Codable, Identifiable {
        case no, yes, archived
        
        var id: Self { self }
    }
}
