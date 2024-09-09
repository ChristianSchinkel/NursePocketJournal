//
//  InvoluntaryPsychiatricCommitmentListRowView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-13.
//

import SwiftUI

struct InvoluntaryPsychiatricCommitmentListRowView: View {
    @Environment(\.modelContext) private var modelContext
    var commitment: InvoluntaryPsychiatricCommitment
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(commitment.date, format: .dateTime)
                .foregroundStyle(.red)
            Text("\(commitment.makeText(from: commitment.isFixed))")
        }
    }
}

#Preview {
    InvoluntaryPsychiatricCommitmentListRowView(commitment: InvoluntaryPsychiatricCommitment.makeExample())
        .modelContainer(PersistenceDataController.previewModelContainer)
}
