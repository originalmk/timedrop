//
//  ContentView.swift
//  TimeDrop
//
//  Created by Maciej Krzyżanowski on 17/05/2026.
//

import SwiftUI
import SwiftData
import OSLog
internal import Combine

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    private let logger = Logger()
    @State private var colonColor = Color.white
    private let timeManager = TimeManager.init()
    private var sessionManager: SessionManager
    @Bindable private var noteManager: NoteManager
    @FocusState private var noteFocused: Bool
    
    init() {
        sessionManager = SessionManager.init(timeManager: timeManager)
        noteManager = NoteManager.init(sessionManager: sessionManager)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack {
                        Text(
                            (timeManager.secondsRemaining / 60)
                                .formatted(
                                    .number.precision(
                                        .integerLength(2)
                                    )
                                )
                        )
                        Text(":")
                            .foregroundStyle(colonColor)
                            .onReceive(timeManager.timer) { _ in
                                if colonColor == .white {
                                    colonColor = .black
                                } else {
                                    colonColor = .white
                                }
                            }
                        Text(
                            (timeManager.secondsRemaining % 60)
                                .formatted(
                                    .number.precision(
                                        .integerLength(2)
                                    )
                                )
                        )
                    }
                    .bold(true)
                    .font(.system(size: 96))
                    Gauge(value: timeManager.percantageLeft, in: 0...1) {
                        Text("Time remaining")
                    }
                }
                VStack {
                    if timeManager.isStarted {
                        TimeDropButton(style: .glass) {
                            Text("Stop timer")
                        } action: {
                            timeManager.stop()
                        }
                        .buttonStyle(.glass)
                    } else {
                        TimeDropButton(style: .glassProminent) {
                            Text("Start timer")
                        } action: {
                            timeManager.start()
                        }
                    }
                    
                    TimeDropButton(style: .glass) {
                        Text("Save session")
                    } action: {
                        noteManager.startNewNote()
                        timeManager.reset()
                        sessionManager.startNewSession(context: modelContext)
                    }
                    .disabled(!timeManager.isStarted && timeManager.percantageLeft == 1.00)
                    
                    TimeDropButton(style: .bordered) {
                        Image(systemName: "arrow.counterclockwise").bold()
                    } action: {
                        timeManager.reset()
                    }
                }
                .padding(20)
                VStack{
                    TextField("Write your session notes here", text: $noteManager.activeNote.text)
                }
            }
            .padding(20)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button {
                            timeManager.timeFullSeconds = 5
                        } label: {
                            Text("5 seconds")
                        }
                        Button {
                            timeManager.timeFullSeconds = 300
                        } label: {
                            Text("5 minutes")
                        }
                        Button {
                            timeManager.timeFullSeconds = 600
                        } label: {
                            Text("10 minutes")
                        }
                        Button {
                            timeManager.timeFullSeconds = 900
                        } label: {
                            Text("15 minutes")
                        }
                        Button {
                            timeManager.timeFullSeconds = 1200
                        } label: {
                            Text("20 minutes")
                        }
                        Button {
                            timeManager.timeFullSeconds = 1500
                        } label: {
                            Text("25 minutes")
                        }
                    } label: {
                        Label("Interval", systemImage: "alarm")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SessionListView()
                    } label: {
                        Label("Notes", systemImage: "text.pad.header")
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .ignoresSafeArea(edges: .top)
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Note.self, inMemory: true)
        .modelContainer(for: Session.self, inMemory: true)
}
