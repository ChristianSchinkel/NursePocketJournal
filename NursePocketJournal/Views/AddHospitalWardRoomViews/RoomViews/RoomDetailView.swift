//
//  RoomDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-23.
//

import SwiftUI
import SwiftData

struct RoomDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var room: Room
    @State private var name: String = ""
    @State private var number: Int = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(room.name)
                Text(room.number.description)
            }
            .font(.title)
            .padding()
        }
    }
}

#Preview {
    ModelPreview { room in
        RoomDetailView(room: room)
    }
}
