//
//  VitalparameterAddSheetView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-05.
//

import SwiftUI

struct VitalparameterAddSheetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var patient: Patient
    @State private var date: Date = Date.now
    
    @State private var heartRate: String = ""
    @State private var bloodPressureSystolic: String = ""
    @State private var bloodPressureDiastolic: String = ""
    @State private var bodyTemperature: String = ""
    @State private var bloodAlcoholContent: String = ""
    @State private var bloodOxygen: String = ""
    @State private var respiratoryRate: String = ""
    @State private var isNeededToObserveBloodOxygen: Bool = false
    @State private var bloodOxygenGoal: String = ""
    @State private var bloodGlucose: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Date", selection: $date)
                
                VitalSignsView(heartRate: $heartRate, systolic: $bloodPressureSystolic, diastolic: $bloodPressureDiastolic, bodyTemperature: $bodyTemperature, bloodAlcoholContent: $bloodAlcoholContent, bloodOxygenLevel: $bloodOxygen, respiratoryRate: $respiratoryRate, isNeededToObserveBloodOxygen: $isNeededToObserveBloodOxygen, bloodOxygenGoal: $bloodOxygenGoal, bloodGlucose: $bloodGlucose)
            }
            // MARK: - Toolbar
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Add Record")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", role: .cancel) {
                        addRecord()
                        dismiss()
                    }
                }
            }
        }
    }
    // MARK: - Functions for this View:
    private func addRecord() {
        if heartRate != "" {
            patient.heartRate.append(HeartRate(id: UUID(), date: date, value: Double(heartRate)!))
        }
        
        if bloodPressureSystolic != "" {
            patient.bloodPressureSystolic.append(BloodPressure.Systolic(id: UUID(), date: date, value: Double(bloodPressureSystolic)!))
        }
        
        if bloodPressureDiastolic != "" {
            patient.bloodPressureDiastolic.append(BloodPressure.Diastolic(id: UUID(), date: date, value: Double(bloodPressureDiastolic)!))
        }
        
        if bodyTemperature != "" {
            patient.bodyTemperature.append(BodyTemperature(id: UUID(), date: date, value: Double(bodyTemperature)!))
        }
        
        if bloodAlcoholContent != "" {
            patient.breathAlcoholLevel.append(BreathAlcoholLevel(id: UUID(), date: date, value: Double(bloodAlcoholContent)!))
        }
        
        if bloodOxygen != "" {
            patient.bloodOxygen.append(BloodOxygen(id: UUID(), date: date, value: Double(bloodOxygen)!))
        }
        
        if respiratoryRate != "" {
            patient.respiratoryRate.append(RespiratoryRate(id: UUID(), date: date, value: Double(respiratoryRate)!))
        }
        
        if isNeededToObserveBloodOxygen == true && bloodOxygenGoal != "" {
            patient.bloodOxygenGoal.append(BloodOxygenGoal(id: UUID(), date: date, value: Double(bloodOxygenGoal)!))
        }
        
        if bloodGlucose != "" {
            patient.bloodGlucose.append(BloodGlucose(id: UUID(), date: date, value: Double(bloodGlucose)!))
        }
    }
}

#Preview {
    ModelPreview { patient in
        VitalparameterAddSheetView(patient: patient)
    }
}
