//
//  PatientAddSheetView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-17.
//

import SwiftUI
import SwiftData


struct PatientAddSheetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    // MARK: - Section/ID"Kontaktinformation"
    @State private var name: String = ""
    @State private var familyName: String = ""
    @State private var swedishSocialSecurityNumber: String = ""
    // MARK: - Section/From"Från"
    @State private var fromClinic = Hospital.ClinicNamed.bcs
    @State private var fromWard = Ward.WardNamed.bas
    @State private var otherClinic = ""
    @State private var otherWard = ""
    @State private var howPatientComesIn: Care.HowPatientComesIn = .ss
    // MARK: - Section/Anamnesis"Anamnes"
    @State private var anamnes = ""
    @State private var somaticDiagnose = ""
    @State private var psychiatricDiagnose = ""
    // TODO: somatiska sjukdomar flervals alternativ
    // TODO: psykiatriska sjukdomar flervals alternativ
    // MARK: - What is important now?
    @State private var now = ""
    // MARK: Risk for suicidal action of the patient
    @State private var sRisk: Care.SuicidalRiskNiveau = .low
    // MARK: Risk for violently action of the patient
    @State private var vRisk: Care.ViolenceRiskNiveau = .low
    // MARK: Type of observation due to suicidal risk
    @State private var type: Care.TypesOfObservation = .normal
    // MARK: Test for substances (u-tox)
    @State private var isTestedForNarcoticSubstances: Bool = false
    @State private var isNeededToBeTested: Bool = false
    // MARK: u-tox values
    @State private var isUrineTestForDrugsAndSubstancesDone: Bool = false
    // MARK: Substances
    @State private var isPositiveAmphetamine: Bool = false
    @State private var isPositiveBenzodiazepine: Bool = false
    @State private var isPositiveCannabis: Bool = false
    @State private var isPositiveOpiates: Bool = false
    @State private var isPositiveSpice: Bool = false
    @State private var isPositiveCocaine: Bool = false
    @State private var isPositiveBuprenorphine: Bool = false
    @State private var isPositiveMethadone: Bool = false
    @State private var isPositiveClonazepam: Bool = false
    @State private var isPositiveTramadol: Bool = false
    @State private var isPositiveOxycodone: Bool = false
    @State private var isPositiveFentanyl: Bool = false
    @State private var otherSubstances: String = ""
    // MARK: - Health records: puls, blodtryck…
    @State private var heartRate: String = ""
    @State private var bloodPressureSystolic: String = ""
    @State private var bloodPressureDiastolic: String = ""
    @State private var bodyTemperature: String = ""
    @State private var bloodAlcoholContent: String = ""
    @State private var bloodOxygen: String = ""
    @State private var respiratoryRate: String = ""
    @State private var bloodGlucose: String = ""
    // MARK: MedicalTasks
    @State private var isNeededToTakeBloodSample: Bool = false
    @State private var isNeededToObserveBloodOxygen: Bool = false
    @State private var bloodOxygenGoal: String = ""
    // MARK: - Medicines
    @State private var medicineListIsChecked: Bool = false
    @State private var medicineIsPrescripted: Bool = false
    // MARK: Some medicines
    @State private var medicineIsPrescriptedLergigan: Bool = false
    @State private var medicineIsPrescriptedTheralen: Bool = false
    @State private var medicineIsPrescriptedPhenergan: Bool = false
    
    @State private var medicineIsPrescriptedVitaminB1: Bool = false
    @State private var medicineIsPrescriptedHaldol: Bool = false
    @State private var medicineIsPrescriptedZyprexa: Bool = false
    @State private var medicineIsPrescriptedStesolid: Bool = false
    @State private var medicineIsPrescriptedOxascand: Bool = false
    @State private var medicineIsPrescriptedAtivan: Bool = false
    @State private var medicineIsPrescriptedPropavan: Bool = false
    @State private var medicineIsPrescriptedNitrazepam: Bool = false
    @State private var medicineIsPrescriptedImovane: Bool = false
    @State private var otherMedicine = "" // Additional Information
    // MARK: - Section/Administration"Registrations-status"
    @State private var rapportDate: Date = Date.now
    @State private var admitted: Patient.Admitted = .no
    @State private var isNeededToBeSendLUS: Bool = false
    @State private var locker: Patient.Locker = .none
    @State private var selectedRoom: Int = 0
    @Query private var rooms: [Room]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("ID") {
                    TextField("Name", text: $name)
                    TextField("Family name", text: $familyName)
                    TextField("Person- / reservnummer", text: $swedishSocialSecurityNumber)
                }
                
                Section("Från") {
                    Picker(selection: $fromClinic, label: Text("Klinik")) {
                        ForEach(Hospital.ClinicNamed.allCases) { name in
                            Text(name.stringLabel).tag(name)
                        }
                    }
                    
                    TextField("Annat", text: $otherClinic)
                    
                    Picker(selection: $fromWard, label: Text("Enhet")) {
                        ForEach(Ward.WardNamed.allCases) { name in
                            Text(name.stringLabel).tag(name)
                        }
                    }
                    
                    TextField("Annat", text: $otherWard)
                    
                    Picker(selection: $howPatientComesIn, label: Text("Kontaktsätt")) {
                        ForEach(Care.HowPatientComesIn.allCases) {
                            Text($0.rawValue).tag($0.rawValue)
                        }
                    }
                }
                
                Section("Anamnes") {
                    TextEditor(text: $anamnes)
                        .frame(idealHeight: 100, maxHeight: 200, alignment: .leading)
                    TextField("Somatiska sjukdomar", text: $somaticDiagnose)
                    TextField("Psykiatriska sjukdomar", text: $psychiatricDiagnose)
                }
                
                Section("Aktuellt just nu") {
                    TextEditor(text: $now)
                        .frame(idealHeight: 100, maxHeight: 200, alignment: .leading)
                    
                    Picker(selection: $sRisk, label: Text("Suicidrisk")) {
                        ForEach(Care.SuicidalRiskNiveau.allCases) {
                            Text($0.nivea).tag($0)
                        }
                    }
                    
                    Picker(selection: $vRisk, label: Text("Våldsrisk")) {
                        ForEach(Care.ViolenceRiskNiveau.allCases) {
                            Text($0.nivea).tag($0)
                        }
                    }
                    
                    Picker(selection: $type, label: Text("Tillsynsgrad")) {
                        ForEach(Care.TypesOfObservation.allCases) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    // MARK: Urintest
                    Toggle(isOn: $isTestedForNarcoticSubstances) {
                        Text("U-tox har lämnats")
                    }
                    Toggle(isOn: $isNeededToBeTested) {
                        Text("U-tox ska tas")
                    }
                    UrineTestForDrugsAndSubstancesView(isUrineTestForDrugsAndSubstancesDone: $isUrineTestForDrugsAndSubstancesDone, isPositiveAmphetamine: $isPositiveAmphetamine, isPositiveCocaine: $isPositiveCocaine, isPositiveBenzodiazepine: $isPositiveBenzodiazepine, isPositiveClonazepam: $isPositiveClonazepam, isPositiveCannabis: $isPositiveCannabis, isPositiveSpice: $isPositiveSpice, isPositiveOpiates: $isPositiveOpiates, isPositiveBuprenorphine: $isPositiveBuprenorphine, isPositiveMethadone: $isPositiveMethadone, isPositiveTramadol: $isPositiveTramadol, isPositiveOxycodone: $isPositiveOxycodone, isPositiveFentanyl: $isPositiveFentanyl)
                }
                // MARK: Vital-signs
                VitalSignsView(heartRate: $heartRate, systolic: $bloodPressureSystolic, diastolic: $bloodPressureDiastolic, bodyTemperature: $bodyTemperature, bloodAlcoholContent: $bloodAlcoholContent, bloodOxygenLevel: $bloodOxygen, respiratoryRate: $respiratoryRate, isNeededToObserveBloodOxygen: $isNeededToObserveBloodOxygen, bloodOxygenGoal: $bloodOxygenGoal, bloodGlucose: $bloodGlucose)
                // MARK: Medicines
                Toggle(isOn: $medicineListIsChecked) {
                    Text("Är Läkemedelslistan genomgången?")
                }
                Toggle(isOn: $medicineIsPrescripted) {
                    Text("Finns de vid behov medicin?")
                }
                Toggle(isOn: $isNeededToBeSendLUS) {
                    Text("Ska LUS göras?")
                }
                
                Section("Givna läkemedel") {
                    TextEditor(text: $otherMedicine)
                        .frame(idealHeight: 50, maxHeight: 200, alignment: .leading)
                }
                // MARK: Administration-state, metadata
                Section("Inskrivningsstatus, Tillhörigheter") {
                    DatePicker(selection: $rapportDate, label: { Text("Rapportid") })
                    Picker(selection: $admitted, label: Text("Registrerad som inskriven?")) {
                        ForEach(Patient.Admitted.allCases, id: \.self) { admission in
                            Text(admission.rawValue).tag(admission)
                        }
                    }
                    
                    Picker(selection: $locker, label: Text("Skåp")) {
                        ForEach(Patient.Locker.allCases) { loc in
                            Text(loc.rawValue).tag(loc)
                        }
                    }
                    
                }
                RoomSelecterView(selectedRoom: $selectedRoom)
            }
            // MARK: - Toolbar
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Add patient")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", role: .cancel) {
                        addPatient()
                        dismiss()
                    }
                }
            }
        }
    }
    // MARK: - Functions for this View:
    private func addPatient() {
        withAnimation {
            // MARK: Create Patient
            let newPatient = Patient(name: name, familyName: familyName, swedishSocialSecurityNumber: swedishSocialSecurityNumber, admitted: admitted, locker: locker, timestamp: Date.now)
            // MARK: Create Journal
            let newText = Journal.writeJournalText(name, familyName, swedishSocialSecurityNumber, fromClinic.stringLabel, otherClinic, fromWard.stringLabel, otherWard, howPatientComesIn.converted(from: howPatientComesIn), anamnes, somaticDiagnose, psychiatricDiagnose, now, sRisk.rawValue, vRisk.rawValue, type.rawValue, isTestedForNarcoticSubstances, isNeededToBeTested, isUrineTestForDrugsAndSubstancesDone, heartRate, bloodPressureSystolic, bloodPressureDiastolic, bodyTemperature, bloodAlcoholContent, bloodOxygen, respiratoryRate, isNeededToObserveBloodOxygen, bloodOxygenGoal, bloodGlucose, isNeededToTakeBloodSample, medicineListIsChecked, medicineIsPrescripted, otherMedicine, isNeededToBeSendLUS, rapportDate, locker.rawValue, tested: isUrineTestForDrugsAndSubstancesDone, amp: isPositiveAmphetamine, coc: isPositiveCocaine, bzo: isPositiveBenzodiazepine, acl: isPositiveClonazepam, thc: isPositiveCannabis, spi: isPositiveSpice, mop: isPositiveOpiates, bup: isPositiveBuprenorphine, mtd: isPositiveMethadone, tml: isPositiveTramadol, oxy: isPositiveOxycodone, fty: isPositiveFentanyl)
            let newJournal = Journal(date: rapportDate, isConfirmed: false, isDocumentedOfficially: false, isLocked: false, text: "\(newText)")
            // MARK: Add newJournal to newPatient
            newPatient.journals.append(newJournal)
            // TODO: Uncoment to check if there is something wrong -> Detailview?
            // MARK: Add selectedRoom to newPatient
            if !rooms.isEmpty {
                let index = selectedRoom
                newPatient.room = rooms[index]
            }
            //MARK: Store the newPatient in the ModelContext
            modelContext.insert(newPatient)
        }
    }
}

#Preview {
    PatientAddSheetView()
        .modelContainer(PersistenceDataController.previewModelContainer)
}
