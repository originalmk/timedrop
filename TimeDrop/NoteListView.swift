//
//  NoteListView.swift
//  TimeDrop
//
//  Created by Maciej Krzyżanowski on 18/05/2026.
//

import SwiftUI
import SwiftData

struct NoteListView: View {
    @Environment(\.modelContext) private var context
    @Query var notes: [Note]
    
    var body: some View {
        Text("Notes view")
        ForEach(notes) { note in
            VStack {
                Text("Some note:")
                Text(note.text)
            }
        }
    }
}

#Preview {
    NoteListView()
        .modelContainer(for: Note.self, inMemory: true)
}
