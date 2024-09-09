//
//  AddRoomView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-23.
//

import SwiftUI
import SwiftData

struct RoomAddView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var ward: Ward
    fileprivate let headline: String = "Add Room"
    @State private var name: String = ""
    @State private var number: Int = 0
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Room's name", text: $name)
                Button("Add Room") {
                    addItem(name, number)
                }
            }
            // MARK: - Toolbar
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss() // "@Environment(\.dismiss) private var dismiss" should be declared on top of struct.
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text(headline) // ' fileprivate let headline: String = "Text" ' should be declared on top of struct.
                }
        }
        }
    }
    // MARK: - Functions for this View:
    private func addItem(_ name: String, _ number: Int) {
        withAnimation {
            // MARK: Create Room
            let newRoom = Room(name: name, number: number)
            // MARK: Add to Ward
            ward.rooms.append(newRoom)
            
            dismiss()
        }
    }
}

#Preview {
    ModelPreview { ward in
        RoomAddView(ward: ward)
    }
}
