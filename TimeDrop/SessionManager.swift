//
//  SessionManager.swift
//  TimeDrop
//
//  Created by Maciej Krzyżanowski on 18/05/2026.
//

import SwiftUI
internal import Combine
import OSLog
import SwiftData

@Observable class SessionManager {
    private let logger = Logger()
    private var activeSession = Session.init(durationSeconds: 0, notes: [])
    private var timeManager: TimeManager
    private var cancellables = Set<AnyCancellable>()

    init(timeManager: TimeManager) {
        self.timeManager = timeManager
        timeManager.timer.sink { _ in
            self.activeSession.durationSeconds += 1
        }.store(in: &cancellables)
    }
    
    func startNewSession(context: ModelContext) {
        cancellables.removeAll()
        context.insert(activeSession)
        
        do {
            try context.save()
            logger.info("session saved")
        } catch {
            logger.error("session not saved, error: \(error)")
            return
        }
        
        activeSession = Session.init(durationSeconds: 0, notes: [])
    }
    
    func addSessionNote(note: Note) {
        note.belongsTo = activeSession
        activeSession.notes.append(note)
    }
}
