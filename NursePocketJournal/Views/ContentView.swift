//
//  ContentView.swift
//  NursePocketJournal
//
//  Created by Christian Schinkel on 2024-09-08.
//

import SwiftUI
import SwiftData
import CSFoundationLibrary

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var patients: [Patient]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(patients) { patient in
                    NavigationLink {
                        Text("Patient at")
                    } label: {
                        Text("X")
                    }
                }
                .onDelete(perform: deletePatients)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addPatient) {
                        Label("Add Patient", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a patient")
        }
    }

    private func addPatient() {
        withAnimation {
            let newPatient = Patient(name: "Taylor", familyName: "Swift", swedishSocialSecurityNumber: "19881209-2222")
            modelContext.insert(newPatient)
        }
    }

    private func deletePatients(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(patients[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Patient.self, inMemory: true)
}
