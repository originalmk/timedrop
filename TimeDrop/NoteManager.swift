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
    private var sessionManager: SessionManager

    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func startNewNote() {
        self.sessionManager.addSessionNote(note: activeNote)
        activeNote = Note(text: "")
    }
}
