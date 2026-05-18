//
//  Session.swift
//  TimeDrop
//
//  Created by Maciej Krzyżanowski on 18/05/2026.
//

import SwiftData
import Foundation

@Model
class Session {
    var dateCreated: Date
    var durationSeconds: Int
    @Relationship(deleteRule: .cascade, inverse: \Note.belongsTo) var notes: [Note]
    
    init(durationSeconds: Int, notes: [Note]) {
        self.durationSeconds = durationSeconds
        self.notes = notes
        self.dateCreated = Date()
    }
}
