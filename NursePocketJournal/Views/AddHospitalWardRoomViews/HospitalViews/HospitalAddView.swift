//
//  AddHospitalView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-23.
//

import SwiftUI
import SwiftData

struct HospitalAddView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    fileprivate let headline: String = "Add Hospital"
    @State private var name: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Hospital's name", text: $name)
                Button("Add Hospital") {
                    addItem(name)
                }
            }
            // MARK: - Toolbar
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss() // "@Environment(\.dismiss) private var dismiss" should be declared on top of struct.
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text(headline) // ' fileprivate let headline: String = "Text" ' should be declared on top of struct.
                }
        }
        }
    }
    
    // MARK: - Functions for this View:
    private func addItem(_ name: String) {
        withAnimation {
            // MARK: Create Hospital
            let newHospital = Hospital(name: name)
            // MARK: Store the newHospital in the ModelContext
            modelContext.insert(newHospital)
            
            dismiss()
        }
    }
}

#Preview("Preview vers 0") {
        HospitalAddView()
            .modelContainer(PersistenceDataController.previewModelContainer)

}

#Preview("Preview vers 1") {
    SwiftDataPreviewer(preview: PersistenceDataController([Hospital.self])) {
        HospitalAddView()
    }
}
