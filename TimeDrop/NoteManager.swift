//
//  NoteManager.swift
//  TimeDrop
//
//  Created by Maciej Krzyżanowski on 18/05/2026.
//

import SwiftUI
internal import Combine
import OSLog
import SwiftData

@Observable class NoteManager {
    private let logger = Logger()
    public var activeNote = Note(text: "")
    
    func startNewNote(context: ModelContext) {
        context.insert(activeNote)
        
        do {
            try context.save()
            logger.info("notes saved! \(self.activeNote.text)")
        } catch {
            logger.info("notes not saved, error: \(error)")
        }
        
        activeNote = Note(text: "")
    }
}
