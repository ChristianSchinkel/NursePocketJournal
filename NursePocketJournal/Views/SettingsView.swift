//
//  SettingsView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-20.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var hospitals: [Hospital]
    
    private let languages = ["ENG", "SWE", "GER"]
    @State private var selectedLanguage: String = ""
    
    @State private var isShowingHospitalAddSheet: Bool = false
    
    var body: some View {
        NavigationSplitView {
            Form {
                
                Section("Allmänt") {
                    // Language: ENG, SWE, GER
                    Picker(selection: $selectedLanguage, label: Text("Language")) {
                        ForEach(languages, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                }
                
                Section("Clinics, wards and rooms") {
                    HStack {
                        Text("Clinic") // Clinic
                        Text("(\(hospitals.count))")
                        Spacer()
                        Button("Add Clinic") {
                            addHospital()
                        }
                    }
                    .sheet(isPresented: $isShowingHospitalAddSheet) {
                        HospitalAddView()
                    }
                    
                    List {
                        ForEach(hospitals) { hospital in
                            NavigationLink {
                                HospitalDetailView(hospital: hospital)
                            } label: {
                                Text(hospital.name)
                            }
                        }
                    }
                }
                
                Section("Medicines") {
                    HStack {
                        Text("Exempelmedicin") // FavoritMedicines
                        Spacer()
                        Text("(1)")
                    }
                }
            }
        } detail: {
            EmptyView()
        }
    }
    // MARK: - Functions for this View:
    private func addHospital() {
        isShowingHospitalAddSheet.toggle()
    }
}

#Preview {
    SettingsView()
        .modelContainer(PersistenceDataController.previewModelContainer)
}
