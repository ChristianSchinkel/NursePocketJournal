//
//  ModelPreview.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-30.
//

import SwiftUI
import SwiftData
// MARK: SwiftData - sugar swiftPackage.
struct ModelPreview<Model: PersistentModel, Content: View>: View {
    
    var content: (Model) -> Content
    
    init(@ViewBuilder content: @escaping (Model) -> Content) {
        self.content = content
    }
    
    
    var body: some View {
        PreviewContentView(content: content)
            .modelContainer(PersistenceDataController.previewModelContainer)
    }
    
    struct PreviewContentView: View {
        
        @Query private var models: [Model]
        var content: (Model) -> Content
        
        @State private var waitedToShowIssue = false
        
        var body: some View {
            if let model = models.first {
                content(model)
            } else {
                ContentUnavailableView("Failed to load model instance for previews!", systemImage: "xmark")
                    .opacity(waitedToShowIssue ? 1 : 0)
                    .task {
                        Task {
                            try await Task.sleep(for: .seconds(1))
                            waitedToShowIssue = true
                        }
                    }
            }
        }
    }
}

//#Preview {
//    ModelPreview()
//}
