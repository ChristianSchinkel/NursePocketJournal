//
//  WardDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-23.
//

import SwiftUI
import SwiftData

struct WardDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var ward: Ward
    
    @Query private var rooms: [Room]
    @State private var isShowingRoomAddSheet: Bool = false
    
    var body: some View {
        Form {
            Text(ward.name)
            Section("Room (\(rooms.count))") {
                List {
                    ForEach(rooms) { room in
                        NavigationLink {
                            RoomDetailView(room: room)
                        } label: {
                            Text(room.name)
                        }
                    }
                }
                Button("Add Room") {
                    addRoom()
                }
                .sheet(isPresented: $isShowingRoomAddSheet) {
                    RoomAddView(ward: ward)
                }
            }
        }
    }
    // MARK: - Functions for this View:
    private func addRoom() {
        isShowingRoomAddSheet.toggle()
    }
}

#Preview {
    ModelPreview { ward in
        WardDetailView(ward: ward)
    }
}
