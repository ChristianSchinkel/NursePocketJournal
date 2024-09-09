//
//  InvoluntaryPsychiatricCommitmentListView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-13.
//

import SwiftUI

struct InvoluntaryPsychiatricCommitmentListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var patient: Patient
    @State private var isShowingInvoluntaryPsychiatricCommitmentAddSheet: Bool = false
    
    fileprivate let headline: String = "Tvångsåtgärder"
    
    var body: some View {
        List {
            ForEach(patient.involuntaryPsychiatricCommitments) { commitment in
                NavigationLink {
                    InvoluntaryPsychiatricCommitmentListDetailView(commitment: commitment)
                } label: {
                    InvoluntaryPsychiatricCommitmentListRowView(commitment: commitment)
                }
            }
            .onDelete(perform: deleteCommitments)
        }
        .navigationTitle(headline)
        .navigationBarTitleDisplayMode(.large)
        //MARK: - Sheets
        .sheet(isPresented: $isShowingInvoluntaryPsychiatricCommitmentAddSheet) {
            InvoluntaryPsychiatricCommitmentAddSheetView(patient: patient)
        }
        // MARK: - Toolbar
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
            
//            ToolbarItem(placement: .principal) {
//                Text("Tvångsåtgärder")
//            }
            
            ToolbarItem {
                Button(action: addCommitment) {
                    Label("Add Commitment", systemImage: "plus")
                }
            }
        }
    }
    // MARK: - Functions for this View:
    private func addCommitment() {
        isShowingInvoluntaryPsychiatricCommitmentAddSheet.toggle()
    }
    
    private func deleteCommitments(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                patient.involuntaryPsychiatricCommitments.remove(at: index)
            }
        }
    }
}

#Preview {
    ModelPreview { patient in
        InvoluntaryPsychiatricCommitmentListView(patient: patient)
    }
}
