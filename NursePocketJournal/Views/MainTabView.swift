//
//  MainTabView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-25.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var patients: [Patient]
    @State private var selectedTab: Int = 1
    let patientListTabItemLabel = "Patients"
    let settingsViewTabItemLabel = "Settings"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PatientListView() // PatientListView
                .badge(patients.count)
                .tabItem {
                    Label(patientListTabItemLabel, systemImage: "person.3.sequence")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Label(settingsViewTabItemLabel, systemImage: "gear")
                }
                .tag(2)
        }
    }
    // MARK: - Functions for this View:
}

#Preview {
    MainTabView()
        .modelContainer(PersistenceDataController.previewModelContainer)
}
