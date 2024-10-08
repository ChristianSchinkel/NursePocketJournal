//
//  NursePocketJournalApp.swift
//  NursePocketJournal
//
//  Created by Christian Schinkel on 2024-09-08.
//

import SwiftUI
import SwiftData

@main
struct NursePocketJournalApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Patient.self,
            Hospital.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
