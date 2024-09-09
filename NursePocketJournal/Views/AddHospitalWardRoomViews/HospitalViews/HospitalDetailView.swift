//
//  HospitalDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-23.
//

import SwiftUI
import SwiftData

struct HospitalDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var hospital: Hospital
    
    @Query private var wards: [Ward]
    @State private var isShowingWardAddSheet: Bool = false
    
    var body: some View {
        Form {
            Text(hospital.name)
            Section("Ward (\(wards.count))") {
                List {
                    ForEach(wards) { ward in
                        NavigationLink {
                            WardDetailView(ward: ward)
                        } label: {
                            Text(ward.name)
                        }
                    }
                }
                Button("Add Ward") {
                    addWard()
                }
                .sheet(isPresented: $isShowingWardAddSheet) {
                    WardAddView(hospital: hospital)
                }
            }
        }
    }
    // MARK: - Functions for this View:
    private func addWard() {
        isShowingWardAddSheet.toggle()
    }
}

#Preview("Preview vers 0") {
    ModelPreview { hospital in
        HospitalDetailView(hospital: hospital)
    }
}

//#Preview("Previev vers 1") {
//    ModelPreview { hospital in
//        SwiftDataPreviewer(preview: PersistenceDataController(Hospital.self)) {
//            HospitalDetailView(hospital: hospital)
//        }
//    }
//}
