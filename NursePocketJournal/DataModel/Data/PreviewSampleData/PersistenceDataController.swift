//
//  PersistenceDataController.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-25.
//

import Foundation
import SwiftData
// MARK: SwiftData - sugar swiftPackage.
/// Data-controller for persistence and preview.
struct PersistenceDataController {
    // TODO: "let sharedModelContainer" can be added here…
//    static let sharedModelContainer: ModelContainer = {
//
//    }
    /// Creates a dedicated container for us within previews only.
    static let previewModelContainer: ModelContainer = {
        do {
            let schema = Schema([Patient.self, Hospital.self])
            let container = try ModelContainer(for: schema, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
            Task { @MainActor in
                let context = container.mainContext
                // MARK: - Testdata starts here…
                let patient = Patient.makeExample()
                patient.journals.append(Journal.makeExample())
                context.insert(patient)
                // FIXME: Code crashes
//                let hospital = Hospital.makeExample()
//                let ward = Ward.makeExample()
//                let room = Room.makeExample()
//                ward.rooms.append(room)
//                hospital.wards.append(ward)
//                hospital.wards.append(Ward.makeExample())
//                context.insert(hospital)
                
                

                // MARK: - Testdata ends here…
            }
            return container
        } catch {
            fatalError("Failed to create previewContainer with error: \(error.localizedDescription)")
        }
    }()
    
    // FIXME: - PreviewContainer
    /// Creates a dedicated container for us within previews only.
    let container: ModelContainer!
    
    init(_ types: [any PersistentModel.Type], isStoredInMemoryOnly: Bool = true) {
        
        let schema = Schema(types)
        let configuration = ModelConfiguration(isStoredInMemoryOnly: isStoredInMemoryOnly)
        self.container = try! ModelContainer(for: schema, configurations: [configuration])
    }
    
    /// Adds items of any kind of PersistentModel to a container, for example from a JSON-file as input.
    /// - Parameter items: [any PersistentModel]
    func addTo(items: [any PersistentModel]) {
        Task { @MainActor in
            items.forEach { container.mainContext.insert($0)}
        }
    }
}
