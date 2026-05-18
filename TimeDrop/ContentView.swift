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
    @Bindable private var noteManager: NoteManager = NoteManager.init()
    @FocusState private var noteFocused: Bool
    
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
                HStack {
                    if timeManager.isStarted {
                        Button{
                            timeManager.stop()
                        } label: {
                            Text("Stop timer")
                                .padding(Edge.Set.horizontal, 10)
                                .padding(Edge.Set.vertical, 5)
                        }
                        .buttonStyle(.glass)
                    } else {
                        Button{
                            timeManager.start()
                        } label: {
                            Text("Start timer")
                                .padding(Edge.Set.horizontal, 10)
                                .padding(Edge.Set.vertical, 5)
                        }
                        .buttonStyle(.glassProminent)
                    }
                    Button{
                        timeManager.reset()
                    } label: {
                        Image(systemName: "arrow.counterclockwise").bold()
                    }
                    .buttonStyle(.bordered)
                }
                .padding(20)
                VStack{
                    TextField("Write your session notes here", text: $noteManager.activeNote.text)
                        .focused($noteFocused)
                        .onChange(of: $noteFocused.wrappedValue) {
                            if !$noteFocused.wrappedValue {
                                noteManager.startNewNote(context: modelContext)
                            }
                        }
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
                        NoteListView()
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
}
