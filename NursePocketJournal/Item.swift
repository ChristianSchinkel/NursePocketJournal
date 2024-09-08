//
//  Item.swift
//  NursePocketJournal
//
//  Created by Christian Schinkel on 2024-09-08.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
