//
//  MedicationListRowView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-02-25.
//

import SwiftUI

struct MedicationListRowView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var selectedDate: Date
    
    var medication: Medication
    var preScription: PreScription
    
    var isConfirmedCircleView: some View {
        medication.isConfirmed == false ? Image(systemName: "circle").foregroundStyle(.gray) : Image(systemName: "checkmark.circle").foregroundStyle(.green)
    }
    
    var body: some View {
        HStack(alignment: .center) {
            isConfirmedCircleView
            
            VStack(alignment: .leading) {
                HStack {
                    medication.frequency == .asNeeded ? Text("vb") : Text(medication.date, style: .time)
                    if medication.confirmedDate != nil {
                        Text(medication.confirmedDate ?? Date.now, style: .time)
                            .foregroundStyle(.red)
                            .fontWeight(.bold)
                    } else {
                        Text("--:--")
                    }
                }
                
                VStack( alignment: .leading) {
                    
                    VStack(alignment: .leading) {
                        Text(medication.medicine.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                        HStack(alignment: .center) {
                            Group {
                                Text(medication.medicine.strengthValue, format: .number)
                                Text(medication.medicine.strengthValueUnit.rawValue)
                                
                                Text("x")
                                
                                Text(medication.amount, format: .number)
                                Text(medication.amountUnit.rawValue)
                                
                                Text("=")
                            }
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            
                            Text("\(medication.medicine.strengthValue * medication.amount, format: .number) \(medication.medicine.strengthValueUnit.rawValue)")
                                .font(.subheadline)
                                .fontWeight(.bold)
                        }
                    }
                    
                    HStack(alignment: .center) {
                        Text(medication.medicine.activeSubstance)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Text(medication.medicine.form.rawValue)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                        Text(medication.mode.rawValue)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                    }
                    if preScription.asNeededMaxDoseAmount != nil {
                        Text("Max dose for day: \(preScription.asNeededMaxDoseAmount ?? 0.0, format: .number)")
//                        if !preScription.medications.isEmpty {
//                            Text("Taken today: \(countMedications(isConfirmedWith: selectedDate))")
//                        }
                    }
                }
            }
        }
    }
    /// This function counts the amount of confirmed medications on a selected date.
    /// - Parameter selectedDate: Date()
    /// - Returns:  Double()
    private func countMedications(isConfirmedWith selectedDate: Date) -> Double {
        return Double(preScription.medications.filter { Calendar.current.compare($0.date, to: selectedDate, toGranularity: .day) == .orderedSame && $0.isConfirmed }.count)
    }
}

#Preview {
    struct Preview: View {
        @State private var selectedDate: Date = Date.now
        
        var body: some View {
            MedicationListRowView(selectedDate: $selectedDate, medication: Medication.makeExample(), preScription: PreScription.makeExample())
                .modelContainer(PersistenceDataController.previewModelContainer)
        }
    }
    
    return Preview()
    
}
