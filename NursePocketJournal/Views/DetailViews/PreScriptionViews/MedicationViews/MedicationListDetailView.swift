//
//  MedicationListDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-02-25.
//

import SwiftUI

struct MedicationListDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var medication: Medication
    @Bindable var preScription: PreScription
    
    @State private var date: Date = Date.now
    @State private var amount: Double = 0
    
    fileprivate let headline: String = "Administration"
    fileprivate let buttonToClose: String = "Close"
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(alignment: .center) {
                        Text(medication.medicine.name)
                        Text(medication.medicine.strengthValue, format: .number)
                        Text(medication.medicine.strengthValueUnit.rawValue)
                        Text(medication.medicine.form.rawValue)
                    }
                    
                    HStack(alignment: .center) {
                        Text("Dose")
                        TextField("Amount", value: $amount, format: .number)
                        Text(medication.amountUnit.rawValue)
                    }
                }
                .bold()
                
                Section {
                    DatePicker("Date", selection: $date)
                        .onAppear(perform: {
                            amount = medication.amount
                            date = medication.date
                        })
                }
            }
            // MARK: - Toolbar
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(headline) // ' fileprivate let headline: String = "Text" ' should be declared on top of struct.
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(buttonToClose, role: .cancel) {
                        dismiss()
                    }
                }
            }
            
            Spacer()
            
            HStack(alignment: .center) {
                Button {
                    skipp()// TODO: skip-action
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(maxWidth: 150, maxHeight: 50)
                            .foregroundStyle(.red)
                        Image(systemName: "x.circle.fill")
                            .foregroundStyle(.white)
                    }
                }
                
                Spacer()
                
                Button {
                    confirm() // TODO: administration-action
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(maxWidth: 150, maxHeight: 50)
                            .foregroundStyle(.green)
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
    // MARK: - Functions for this View:
    /// Marks the medication as skipped.
    private func skipp() {
        medication.isSkipped = true
        medication.skippedDate = date
        
        if medication.isConfirmed {
            medication.isConfirmed = false
            medication.confirmedDate = nil
        }
        
        medication.amount = amount
        
        dismiss()
    }
    
    /// Marks the medication as confirmed.
    private func confirm() {
        medication.isConfirmed = true
        medication.confirmedDate = date
        
        if medication.isSkipped ?? true {
            medication.isSkipped = false
            medication.skippedDate = nil
        }
        
        medication.amount = amount
        
        dismiss()
    }
}

#Preview {
    MedicationListDetailView(medication: Medication.makeExample(), preScription: PreScription.makeExample())
        .modelContainer(PersistenceDataController.previewModelContainer)
}
