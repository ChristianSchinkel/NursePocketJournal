//
//  AddWardView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-23.
//

import SwiftUI
import SwiftData

struct WardAddView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var hospital: Hospital
    fileprivate let headline: String = "Add Ward"
    @State private var name: String = ""
    @State private var number: Int = 0
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Ward's name", text: $name)
                Button("Add Ward") {
                    addItem(name, number)
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
    private func addItem(_ name: String, _ number: Int) {
        withAnimation {
            // MARK: Create Ward
            let newWard = Ward(name: name, number: number)
            // MARK: Add to Hospital
            hospital.wards.append(newWard)
            
            dismiss()
        }
    }
}

#Preview {
    ModelPreview { hospital in
        WardAddView(hospital: hospital)
    }
}
