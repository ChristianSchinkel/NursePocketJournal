//
//  Journal.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-11.
//

import Foundation
import SwiftData
import CSFoundationLibrary

@Model
final class Journal: Identifiable, Exemplifiable {
    let id = UUID() // A unique identifier that never changes.
    let timestamp = Date.now // This is the date when the text was created the first time
    
    var date: Date // When the text should be listed in order to it´s value (date) in the List.
    var isConfirmed: Bool // Text is validated and confirms of the user.
    var isDocumentedOfficially: Bool // Data is dokumented in other programs - work is done.
    var isLocked: Bool // Can not be changed in future.
    
    var text: String // Text, recorded value.
    
     var patient: Patient?
    
    init(date: Date, isConfirmed: Bool, isDocumentedOfficially: Bool, isLocked: Bool, text: String) {
        self.date = date
        self.isConfirmed = isConfirmed
        self.isDocumentedOfficially = isDocumentedOfficially
        self.isLocked = isLocked
        self.text = text
    }
    
    // MARK: - functions goes here.
    static func makeExample() -> Journal {
        Journal(date: Date.now,
                isConfirmed: false,
                isDocumentedOfficially: false,
                isLocked: false,
                text: "This is an example for a journal-entry.")
    }
}
// MARK: - Extensions goes here.
extension Journal {
    /// DocumentType by enum -> Int => .normal, ,.value .in, .out
    enum DocumentTypes: Int, CaseIterable, Codable, Identifiable {
        case normal, value, inTxt, outTxt
        /// Object-identifier where id is **self**.
        var id: Self { self }
    }
}
extension Journal {
    /// Computes text for patients Name and Identification-number.
    /// - Parameters:
    ///   - name: name
    ///   - familyName: familyName
    ///   - swedishSocialSecurityNumber: swedishSocialSecurityNumber
    /// - Returns: String
    static func writeJournalText(_ name: String, _ familyName: String, _ swedishSocialSecurityNumber: String) -> String {
        "ID: \nPatient: \(name) \(familyName) (\(swedishSocialSecurityNumber))\n"
    }
    static func writeJournalText(_ fromClinic: String, _ otherClinic: String, _ fromWard: String, _ otherWard: String, _ howPatientComesIn: Int) -> String {
        switch howPatientComesIn {
        case 0:
            return "Patienten inkommer från \(fromClinic == "Annat" ? otherClinic : fromClinic), \(fromWard == "Annat" ? otherWard : fromWard). \nPatienten söker med frivillig transport av polis.\n"
        case 1:
            return "Patienten inkommer från \(fromClinic == "Annat" ? otherClinic : fromClinic), \(fromWard == "Annat" ? otherWard : fromWard). \nPatienten inkommer med polis enligt LOB.\n"
        case 2:
            return "Patienten inkommer från \(fromClinic == "Annat" ? otherClinic : fromClinic), \(fromWard == "Annat" ? otherWard : fromWard). \nPatienten inkommer med polis enligt LPT § 47.\n"
        case 3:
            return "Patienten söker själv och inkommer från \(fromClinic == "Annat" ? otherClinic : fromClinic), \(fromWard == "Annat" ? otherWard : fromWard).\n"
        case 4:
            return "Patienten inkommer med ambulans från \(fromClinic == "Annat" ? otherClinic : fromClinic), \(fromWard == "Annat" ? otherWard : fromWard).\n"
        case 5:
            return "Patienten inkommer med PAM (Psykiatriambulans) från \(fromClinic == "Annat" ? otherClinic : fromClinic), \(fromWard == "Annat" ? otherWard : fromWard).\n"
        case 6:
            return "Patienten söker med remiss från \(fromClinic == "Annat" ? otherClinic : fromClinic), \(fromWard == "Annat" ? otherWard : fromWard).\n"
        default:
            return "Patienten inkommer med remiss från \(fromClinic == "Annat" ? otherClinic : fromClinic), \(fromWard == "Annat" ? otherWard : fromWard).\n"
        }
        
    }
    /// Computes text for anamnes and background.
    /// - Parameters:
    ///   - anamnes: anamnes
    ///   - somaticDiagnose: somaticDiagnose
    ///   - psychiatricDiagnose: psychiatricDiagnose
    ///   - now: now
    ///   - sRisk: sRisk
    ///   - vRisk: vRisk
    ///   - gradeOfObservation: gradeOfObservation
    /// - Returns: String
    static func writeJournalText(_ anamnes: String, _ somaticDiagnose: String, _ psychiatricDiagnose: String, _ now: String, _ sRisk: String, _ vRisk: String, _ gradeOfObservation: String) -> String {
        """
        Anamnes:
        \(anamnes).\n
        Somatiska sjukdomar:
        \(somaticDiagnose).\n
        Psykiatriska sjukdomar:
        \(psychiatricDiagnose).\n
        \n
        Aktuellt just nu:
        \(now).\n
        Suicidrisk:
                \tSucidrisken bedöms som \(sRisk).
        Våldsrisk:
                \tVåldsrisken bedöms som \(vRisk).
        Tillsynsgrad:\n
                \t\(gradeOfObservation) ordineras.\n
        """
    }
    /// Takes the result of a taken or not taken U-tox and generates text to present it in a human friendly way.
    /// - Parameters:
    ///   - doneTestOnTwelveSubstances: Is the U-tox taken or not.
    ///   - amphetamine: Bool
    ///   - cocaine: Bool
    ///   - benzodiazepine: Bool
    ///   - clonazepam: Bool
    ///   - cannabis: Bool
    ///   - spice: Bool
    ///   - opiates: Bool
    ///   - buprenorphine: Bool
    ///   - methadone: Bool
    ///   - tramadol: Bool
    ///   - oxycodone: Bool
    ///   - fentanyl: Bool
    /// - Returns: String; based on the result of the U-tox.
    static func writeJournalTextUrineTestForDrugsAndSubstances(tested doneTestOnTwelveSubstances: Bool, amp amphetamine: Bool, coc cocaine: Bool, bzo benzodiazepine: Bool, acl clonazepam: Bool, thc cannabis: Bool, spi spice: Bool, mop opiates: Bool, bup buprenorphine: Bool, mtd methadone: Bool, tml tramadol: Bool, oxy oxycodone: Bool, fty fentanyl: Bool) -> String {
        guard doneTestOnTwelveSubstances == true else {
            return "U-TOX:\n - Ej taget."
        }
        let testedSubstances = [amphetamine, cocaine, benzodiazepine, clonazepam, cannabis, spice, opiates, buprenorphine, methadone, tramadol, oxycodone, fentanyl]
        let testedSubstancesNames = ["amphetamine", "cocaine", "benzodiazepine", "clonazepam", "cannabis", "spice", "opiates", "buprenorphine", "methadone", "tramadol", "oxycodone", "fentanyl"]
        var detectedSubstances = [String]()
        
        for i in  0 ... (testedSubstances.count - 1) {
            if testedSubstances[i] == true {
                detectedSubstances.append(testedSubstancesNames[i])
            }
        }
        if detectedSubstances.isEmpty {
            return "U-tox results i negativ."
        } else {
            return "The patient is positiv on:\n \(detectedSubstances)"
        }
    }
    /// Takes the result of taken and not taken healthdata.
    /// - Parameters:
    ///   - heartRate: String
    ///   - bloodPressureSystolic: String
    ///   - bloodPressureDiastolic: String
    ///   - bodyTemperature: String
    ///   - bloodAlcoholContent: String
    ///   - bloodOxygen: String
    ///   - respiratoryRate: String
    ///   - isNeededToObserveBloodOxygen: Bool
    ///   - bloodOxygenGoal: String
    ///   - bloodGlucose: String
    ///   - isNeededToTakeBloodSample: Bool
    /// - Returns: String; based on the incomming values.
    static func writeJournalText(_ heartRate: String, _ bloodPressureSystolic: String, _ bloodPressureDiastolic: String, _ bodyTemperature: String, _ bloodAlcoholContent: String, _ bloodOxygen: String, _ respiratoryRate: String, _ isNeededToObserveBloodOxygen: Bool, _ bloodOxygenGoal: String, _ bloodGlucose: String, _ isNeededToTakeBloodSample: Bool) -> String {
        // MARK: If value is not "", then do text, else return "No health data recorded."
        let notTakenData = "No record."
        // MARK: If needed to observe oxygen level "Oxygen level needs to observe x ≥ 90%"
        let oxygenGoalString = bloodOxygenGoal == "" ? "Saturationsövervak ordineras med en målsaturation på ≥ \(bloodOxygenGoal) %." : "Oxygen level needs to observe x ≥ 90%"
        let textForVitalSigns = """
        Vitalparametrar:
        - CIRCULATION:
                \tHjärtslag: \(heartRate == "" ? notTakenData : "\(heartRate) BPM")\n
                \tBlodtryck: \(bloodPressureSystolic == "" || bloodPressureDiastolic == "" ? notTakenData : "\(bloodPressureSystolic) / \(bloodPressureDiastolic) mm/Hg")\n
        - AIRWAY & BREATHING:
                \tSyresättning: \(bloodOxygen == "" ? notTakenData : "\(bloodOxygen) %")\n
                \t\(isNeededToObserveBloodOxygen == false ? "" : oxygenGoalString)\n
                \tAndetag: \(respiratoryRate == "" ? notTakenData : "\(respiratoryRate) breaths/min.")\n
        - EXPOSURE:
                \tP-Glukos: \(bloodGlucose == "" ? notTakenData : "\(bloodGlucose) mmol/l")\n
                \tKroppstemperatur: \(bodyTemperature == "" ? notTakenData : "\(bodyTemperature) °C")\n
                \tAlkoholhalt i utandningsluft: \(bloodAlcoholContent == "" ? notTakenData : "\(bloodAlcoholContent) ‰")\n
        """
        
        return textForVitalSigns
    }
    /// Computes text for admission.
    /// - Parameters:
    ///   - medicineListIsChecked: medicineListIsChecked
    ///   - medicineIsPrescripted: medicineIsPrescripted
    ///   - otherMedicine: otherMedicine
    ///   - isNeededToBeSendLUS: isNeededToBeSendLUS
    ///   - rapportDate: rapportDate
    ///   - locker: locker
    /// - Returns: String
    static func writeJournalText(_ medicineListIsChecked: Bool, _ medicineIsPrescripted: Bool,_ otherMedicine: String, _ isNeededToBeSendLUS: Bool, _ rapportDate: Date, _ locker: String) -> String {
            """
            Läkemedelslistan är \(medicineListIsChecked ? "" : "inte") genomgången.
            Finns det vidbehovsmedicin?
                        \t\(medicineIsPrescripted ? "Ja" : "Nej").
            Ska LUS göras?
                        \t\(isNeededToBeSendLUS ? "Ja" : "Nej").
            GIVNA LÄKEMEDEL:
                        \t\(otherMedicine).\n
            
            Rapporttid: \(rapportDate).\n
            Skåp: \(locker).
            """
    }
    /// Computes text for DocumentType.inTxt by separatet computing of text by return-values from functions.
    /// - Parameters:
    ///   - name: name
    ///   - familyName: familyName
    ///   - swedishSocialSecurityNumber: swedishSocialSecurityNumber
    ///   - fromClinic: fromClinic
    ///   - otherClinic: otherClinic
    ///   - fromWard: fromWard
    ///   - otherWard: otherWard
    ///   - howPatientComesIn: howPatientComesIn
    ///   - anamnes: anamnes
    ///   - somaticDiagnose: somaticDiagnose
    ///   - psychiatricDiagnose: psychiatricDiagnose
    ///   - now: now
    ///   - sRisk: sRisk
    ///   - vRisk: vRisk
    ///   - gradeOfObservation: gradeOfObservation
    ///   - isTestedForNarcoticSubstances: isTestedForNarcoticSubstances
    ///   - isNeededToBeTested: isNeededToBeTested
    ///   - isUrineTestForDrugsAndSubstancesDone: isUrineTestForDrugsAndSubstancesDone
    ///   - heartRate: heartRate
    ///   - bloodPressureSystolic: bloodPressureSystolic
    ///   - bloodPressureDiastolic: bloodPressureDiastolic
    ///   - bodyTemperature: bodyTemperature
    ///   - bloodAlcoholContent: bloodAlcoholContent
    ///   - bloodOxygen: bloodOxygen
    ///   - respiratoryRate: respiratoryRate
    ///   - isNeededToObserveBloodOxygen: isNeededToObserveBloodOxygen
    ///   - bloodOxygenGoal: bloodOxygenGoal
    ///   - bloodGlucose: bloodGlucose
    ///   - isNeededToTakeBloodSample: isNeededToTakeBloodSample
    ///   - medicineListIsChecked: medicineListIsChecked
    ///   - medicineIsPrescripted: medicineIsPrescripted
    ///   - otherMedicine: otherMedicine
    ///   - isNeededToBeSendLUS: isNeededToBeSendLUS
    ///   - rapportDate: rapportDate
    ///   - locker: locker
    ///   - doneTestOnTwelveSubstances: doneTestOnTwelveSubstances
    ///   - amphetamine: amphetamine
    ///   - cocaine: cocaine description
    ///   - benzodiazepine: benzodiazepine
    ///   - clonazepam: clonazepam
    ///   - cannabis: cannabis
    ///   - spice: spice
    ///   - opiates: opiates
    ///   - buprenorphine: buprenorphine
    ///   - methadone: methadone
    ///   - tramadol: tramadol
    ///   - oxycodone: oxycodone
    ///   - fentanyl: fentanyl 
    /// - Returns: String
    static func writeJournalText(_ name: String, _ familyName: String, _ swedishSocialSecurityNumber: String, _ fromClinic: String, _ otherClinic: String, _ fromWard: String, _ otherWard: String, _ howPatientComesIn: Int, _ anamnes: String, _ somaticDiagnose: String, _ psychiatricDiagnose: String, _ now: String, _ sRisk: String, _ vRisk: String, _ gradeOfObservation: String, _ isTestedForNarcoticSubstances: Bool, _ isNeededToBeTested: Bool, _ isUrineTestForDrugsAndSubstancesDone: Bool, _ heartRate: String, _ bloodPressureSystolic: String, _ bloodPressureDiastolic: String, _ bodyTemperature: String, _ bloodAlcoholContent: String, _ bloodOxygen: String, _ respiratoryRate: String, _ isNeededToObserveBloodOxygen: Bool, _ bloodOxygenGoal: String, _ bloodGlucose: String, _ isNeededToTakeBloodSample: Bool, _ medicineListIsChecked: Bool, _ medicineIsPrescripted: Bool,_ otherMedicine: String, _ isNeededToBeSendLUS: Bool, _ rapportDate: Date, _ locker: String, tested doneTestOnTwelveSubstances: Bool, amp amphetamine: Bool, coc cocaine: Bool, bzo benzodiazepine: Bool, acl clonazepam: Bool, thc cannabis: Bool, spi spice: Bool, mop opiates: Bool, bup buprenorphine: Bool, mtd methadone: Bool, tml tramadol: Bool, oxy oxycodone: Bool, fty fentanyl: Bool) -> String { // TODO: write functions to generate text for journal. Divide enormous functions in little pieces.
        """
        \(Journal.writeJournalText(name, familyName, swedishSocialSecurityNumber))
        \(Journal.writeJournalText(fromClinic, otherClinic, fromWard, otherWard, howPatientComesIn))
        \(Journal.writeJournalText(anamnes, somaticDiagnose, psychiatricDiagnose, now, sRisk, vRisk, gradeOfObservation))
        \(Journal.writeJournalTextUrineTestForDrugsAndSubstances(tested: doneTestOnTwelveSubstances, amp: amphetamine, coc: cocaine, bzo: benzodiazepine, acl: clonazepam, thc: cannabis, spi: spice, mop: opiates, bup: buprenorphine, mtd: methadone, tml: tramadol, oxy: oxycodone, fty: fentanyl))
        \(Journal.writeJournalText(heartRate, bloodPressureSystolic, bloodPressureDiastolic, bodyTemperature, bloodAlcoholContent, bloodOxygen, respiratoryRate, isNeededToObserveBloodOxygen, bloodOxygenGoal, bloodGlucose, isNeededToTakeBloodSample))
        \(Journal.writeJournalText(medicineListIsChecked, medicineIsPrescripted, otherMedicine, isNeededToBeSendLUS, rapportDate, locker))
        
        """
    }
    static func writeJournalText(_ glc: Double) -> String {
        switch glc {
        case 15:
            return "Patienten är vaken"
        case 14.9:
            return "Patienten sover."
        default:
            return "OBS! Bedöm patientens tillstånd; behöver någrant observeras."
        }
    }
}
