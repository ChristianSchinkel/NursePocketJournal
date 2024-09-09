//
//  MedicationListView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-02-25.
//

import SwiftUI

struct MedicationListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var patient: Patient
    // psyeudoCode: @Query ... medication where medication.date is >= && <= date
    // Maybe @Query isn't the right to do this? - but with sortDescriptors?
    @Binding var selectedDate: Date
    
    var body: some View {
        if !patient.preScriptions.isEmpty {
            List {
                ForEach(patient.preScriptions) { preScription in
                    ForEach(preScription.medications.filter { Calendar.current.compare($0.date, to: selectedDate, toGranularity: .day) == .orderedSame }) { medication in
                        NavigationLink {
                            MedicationListDetailView(medication: medication, preScription: preScription)
                        } label: {
                            MedicationListRowView(selectedDate: $selectedDate, medication: medication, preScription: preScription)
                        }
                    }
                }
            }
        } else {
            Text("No medications")
            Spacer()
        }
    }
    // MARK: - Functions for this View:
}

#Preview {
    struct Preview: View {
        @State private var selectedDate: Date = Date.now
        
        var body: some View {
            ModelPreview { patient in
                MedicationListView(patient: patient, selectedDate: $selectedDate)
            }
        }
    }
    
    return Preview()
}
