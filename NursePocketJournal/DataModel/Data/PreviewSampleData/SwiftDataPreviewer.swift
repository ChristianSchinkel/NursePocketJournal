//
//  SwiftDataPreviewer.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-12-01.
//

import Foundation
import SwiftData
import SwiftUI
// MARK: SwiftData - sugar swiftPackage.
/// Any View can be passed in here: **Text, Form, List** and so on.
struct SwiftDataPreviewer<Content: View>: View {
    
    private let content: Content
    private let preview: PersistenceDataController
    private let items: [any PersistentModel]?
    
    init(preview: PersistenceDataController,
         items: [any PersistentModel]? = nil,
         @ViewBuilder _ content: () -> Content) {
        self.preview = preview
        self.items = items
        self.content = content()
    }
    
    var body: some View {
        content
            .modelContainer(preview.container)
            .onAppear {
                if let items {
                    preview.addTo(items: items)
                }
            }
    }
}
