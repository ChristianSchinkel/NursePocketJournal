//
//  RoomSelecterView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-26.
//

import SwiftUI
import SwiftData

struct RoomSelecterView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var rooms: [Room]
    @Binding var selectedRoom: Int
    fileprivate let labelNoRoomsAvailable: String = "Sorry! No rooms available"
    fileprivate let pickerLabel: String = "Select a room"
    
    var body: some View {
        Section("Room") {
            if !rooms.isEmpty {
                Picker("Select a room", selection: $selectedRoom) {
                    ForEach(0 ..< rooms.count, id: \.self) { index in
                        Text(rooms[index].name).tag(rooms[index].name)
                    }
                }
            } else {
                Label {
                    Text(labelNoRoomsAvailable)
                        .bold()
                        .foregroundStyle(.secondary)
                } icon: {
                    Image(systemName: "circle.badge.xmark.fill")
                        .foregroundStyle(.gray)
                }
            }
        }
    }
    // MARK: - Functions for this View:
}

#Preview {
    RoomSelecterView(selectedRoom: .constant(2)) // TODO: Make the preview live and not constant. It Works for now.
}
