//
//  PatientListView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-16.
//

import SwiftUI
import SwiftData

struct PatientListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Patient.room?.number, order: .reverse) private var patients: [Patient]
    
    @State private var isShowingPatientAddSheet: Bool = false
    @State private var isShowingAlertDeleteAllPatients = false // Shows an alert if you are going to delete all patients.
    //    @State private var isShowingConfirmationDialog: Bool = false
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(patients) { patient in
                    Section("\(patient.room?.name ?? "Not placed")") {
                        NavigationLink {
                            PatientListDetailView(patient: patient)
                        } label: {
                            PatientListRowView(patient: patient)
                    }
                    }
                }
                .onDelete(perform: deletePatients)
            }
            .navigationTitle("Care Note")
            // MARK: - Sheets
            .sheet(isPresented: $isShowingPatientAddSheet) {
                PatientAddSheetView()
            }
            // MARK: - Alerts
            .alert("Importatn message", isPresented: $isShowingAlertDeleteAllPatients, actions: {
                Button("Delete", role: .destructive) {
                    deleteAllPatients()
                }
                Button("Cancel", role: .cancel) { }
            }, message: {
                Text("Please read this until you continue. \n Do You want to delete all information?")
            })
            // MARK: - Toolbar
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addPatient) {
                        Label("Add Patient", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    Button(action: addSample) {
                        Label("Add Sample", systemImage: "person")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(role: .destructive) {
                        isShowingAlertDeleteAllPatients.toggle()
                    } label: {
                        Label {
                            Text("Trash")
                        } icon: {
                            Image(systemName: "trash")
                            
                        }
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    // MARK: - Functions for this View:
    private func addSample() {
        let tolvan = Patient(name: "Tolvan", familyName: "Tolvansson", swedishSocialSecurityNumber: "19121212-1212", admitted: .no, locker: .a, timestamp: Date.now)
        let talor = Patient(name: "Talor", familyName: "Swift", swedishSocialSecurityNumber: "19891015-1512", admitted: .yes, locker: .b, timestamp: Date.now)
        let harry = Patient(name: "Harry", familyName: "Potter", swedishSocialSecurityNumber: "19900731-1503", admitted: .no, locker: .c, timestamp: Date.now)
        
        modelContext.insert(tolvan)
        modelContext.insert(talor)
        modelContext.insert(harry)
    }
    private func addPatient() {
        withAnimation {
            isShowingPatientAddSheet.toggle()
        }
    }
    
    private func deletePatients(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(patients[index])
            }
        }
    }
    private func deleteAllPatients() {
        withAnimation {
            do {
                try modelContext.delete(model: Patient.self)
            } catch {
                print("Failed to delete \(Patient.self).")
            }
        }
    }
}

#Preview {
    PatientListView()
        .modelContainer(PersistenceDataController.previewModelContainer)
}
