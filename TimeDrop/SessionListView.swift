//
//  NoteListView.swift
//  TimeDrop
//
//  Created by Maciej Krzyżanowski on 18/05/2026.
//

import SwiftUI
import SwiftData

struct SessionListView: View {
    @Environment(\.modelContext) private var context
    @Query var sessions: [Session]
    
    var body: some View {
        VStack {
            Text("Sessions list")
            ForEach(sessions) { session in
                VStack {
                    Text("Session from \(session.dateCreated.formatted())")
                        .bold()
                    Text("Lasted for \(session.durationSeconds / 60) minutes and \(session.durationSeconds % 60) seconds")
                    ForEach(session.notes) { note in
                        Text(note.text)
                    }
                    Spacer()
                }
                .padding(10)
            }
        }
    }
}

#Preview {
    SessionListView()
        .modelContainer(for: Note.self, inMemory: true)
        .modelContainer(for: Session.self, inMemory: true)
}
