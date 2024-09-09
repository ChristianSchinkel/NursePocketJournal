//
//  JournalListDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-11.
//

import SwiftUI

struct JournalListDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var journal: Journal
    fileprivate let headline: String = "Journal"
    
    var body: some View {
        VStack {
            HStack {
                DatePicker("Please enter a date", selection: $journal.date)
                    .labelsHidden()
                Spacer()
            }
            TextEditor(text: $journal.text)
        }
        .navigationTitle(headline)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        // MARK: - Toolbar
        .toolbar {
//            ToolbarItem(placement: .principal) {
//                Text(headline) // ' fileprivate let headline: String = "Text" ' should be declared on top of struct.
//            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save", role: .cancel) {
                    // TODO: 'action' = cal a function.
                    dismiss()
                }
            }
        }
    }
    // MARK: - Functions for this View:
}

#Preview {
    JournalListDetailView(journal: Journal.makeExample())
}
