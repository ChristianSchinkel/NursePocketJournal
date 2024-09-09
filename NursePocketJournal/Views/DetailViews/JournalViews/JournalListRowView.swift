//
//  JournalListRowView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-17.
//

import SwiftUI

struct JournalListRowView: View {
    @Environment(\.modelContext) private var modelContext
    var journal: Journal
    var body: some View {
        VStack(alignment: .leading) {
            Text(journal.date, format: .dateTime)
                .font(.caption)
                .fontWeight(.bold)
            Text(journal.text)
                .font(.caption2)
                .fontWeight(.regular)
        }
    }
}

#Preview {
    JournalListRowView(journal: Journal.makeExample())
        .modelContainer(PersistenceDataController.previewModelContainer)
}
