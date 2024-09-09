//
//  JournalListView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-17.
//

import SwiftUI
import SwiftData


struct JournalListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var patient: Patient
    @State private var isShowingAddJournalSheet: Bool = false
    
    var body: some View {
        List {
            ForEach(patient.journals) { journal in
                NavigationLink {
                    JournalListDetailView(journal: journal)
                } label: {
                    JournalListRowView(journal: journal)
                }
            }
            .onDelete(perform: deleteJournals)
        }
        .navigationTitle("Journal")
        .navigationBarTitleDisplayMode(.large)
        // MARK: - Sheets
        .sheet(isPresented: $isShowingAddJournalSheet) {
            JournalAddSheetView(patient: patient)
        }
        // MARK: - Toolbar
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addJournal) {
                    Label("Add Journal", systemImage: "plus")
                }
            }
        }
    }
    // MARK: - Functions for this View:
    private func addJournal() {
        isShowingAddJournalSheet.toggle()
    }
    
    private func deleteJournals(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                patient.journals.remove(at: index)
                // modelContext.delete(journal)
            }
        }
    }
}

#Preview {
    ModelPreview { patient in
        JournalListView(patient: patient)
    }
}
