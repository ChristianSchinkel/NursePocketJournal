//
//  PreScriptionListView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-02-16.
//

import SwiftUI

struct PreScriptionListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var patient: Patient
    @State private var isShowingPreScriptionAddSheet: Bool = false
    fileprivate let headline: String = "Prescription-list"
    
    @State private var date: Date = Date.now
    @State private var selectedList: Int = 1
    
    var body: some View {
        DatePicker(selection: $date, label: { Text("Date") })
            .padding([.leading, .trailing])

        Picker(selection: $selectedList, label: Text("Picker")) {
            Text("Prescriptions").tag(1)
            Text("Administrations").tag(2)
        }
        .pickerStyle(.segmented)
        .padding([.leading, .trailing])
        
        if selectedList == 1 {
            List {
                ForEach(patient.preScriptions) { preScription in
                    NavigationLink {
                        PreScriptionListDetailView(preScription: preScription)
                    } label: {
                        PreScriptionListRowView(preScription: preScription)
                    }
                }
                .onDelete(perform: deletePreScriptions)
            }
            .navigationTitle(headline)
            .navigationBarTitleDisplayMode(.large)
            // MARK: - Sheets
            .sheet(isPresented: $isShowingPreScriptionAddSheet) {
                PreScriptionAddSheetView(patient: patient)
            }
            // MARK: - Toolbar
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addPreScription) {
                        Label("Add PreScription", systemImage: "plus")
                    }
                }
            }
        } else {
            MedicationListView(patient: patient, selectedDate: $date) // TODO: code the list for the administration with "where".
        }
    }
    // MARK: - Functions for this View:
    private func addPreScription() {
        isShowingPreScriptionAddSheet.toggle()
    }
    
    private func deletePreScriptions(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                patient.preScriptions.remove(at: index)
            }
        }
    }
}

#Preview {
    ModelPreview { patient in
        PreScriptionListView(patient: patient)
    }
}
