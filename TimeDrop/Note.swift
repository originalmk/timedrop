//
//  Note.swift
//  TimeDrop
//
//  Created by Maciej Krzyżanowski on 18/05/2026.
//

import SwiftData

@Model
class Note {
    var text: String
    
    init(text: String) {
        self.text = text
    }
}
