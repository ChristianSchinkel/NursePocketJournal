//
//  JournalAddSheetView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-17.
//

import SwiftUI

struct JournalAddSheetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var date: Date = Date.now
    
    @State private var isConfirmed: Bool = false
    @State private var isDocumentedOfficially: Bool = false
    @State private var isLocked: Bool = false
    
    fileprivate let headline: String = "Add journal Text"
    @State private var text: String = "Skriv här"
    
    @Bindable var patient: Patient
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker(selection: $date, label: { Text("Date") })
                TextEditor(text: $text)
                    .frame(height: 300)
            }
            // MARK: - Toolbar
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text(headline) // ' fileprivate let headline: String = "Text" ' should be declared on top of struct.
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", role: .cancel) {
                        addJournal()
                        dismiss()
                    }
                }
            }
        }
    }
    // MARK: - Functions for this View:
    private func addJournal() {
        guard text.isEmpty == false else { return }
        withAnimation {
            let newJournal = Journal(date: date, isConfirmed: isConfirmed, isDocumentedOfficially: isDocumentedOfficially, isLocked: isLocked, text: text)
            // newJournal.patient = selectedPatient
            patient.journals.append(newJournal)
        }
    }
}

#Preview {
    JournalAddSheetView(patient: Patient.makeExample())
        .modelContainer(PersistenceDataController.previewModelContainer)
}
