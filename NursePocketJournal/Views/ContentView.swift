//
//  ContentView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-16.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        MainTabView()
    }
    // MARK: - Functions for this View:
}

#Preview("Preview vers 0") {
    ContentView()
        .modelContainer(PersistenceDataController.previewModelContainer)
}

#Preview("Preview vers 1") {
    SwiftDataPreviewer(preview: PersistenceDataController([Patient.self], isStoredInMemoryOnly: true)) {
        ContentView()
    }
}

#Preview("Preview vers 2") {
    SwiftDataPreviewer(preview: PersistenceDataController.init([Patient.self])) {
        ContentView()
    }
}
