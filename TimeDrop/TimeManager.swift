//
//  TimeManager.swift
//  TimeDrop
//
//  Created by Maciej Krzyżanowski on 17/05/2026.
//

import SwiftUI
internal import Combine
import OSLog

@Observable class TimeManager {
    public private(set) var secondsRemaining = 1500
    private var _timeFullSeconds = 25 * 60
    public var timeFullSeconds: Int {
        get {
            return _timeFullSeconds
        }
        set(newValue) {
            _timeFullSeconds = newValue
            reset()
        }
    }
    public let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    private var cancellables = Set<AnyCancellable>()
    public var isStarted: Bool = false
    public var percantageLeft: Float {
        Float(secondsRemaining) / Float(timeFullSeconds)
    }
    private let logger = Logger()

    func start() {
        isStarted = true
        
        if self.secondsRemaining == 0 {
            self.secondsRemaining = timeFullSeconds
        }
        
        timer.sink { _ in
            if self.secondsRemaining > 0 {
                self.secondsRemaining -= 1
                if self.secondsRemaining == 0 {
                    self.stop()
                }
            }
        }
        .store(in: &cancellables)
    }
    
    func reset() {
        stop()
        secondsRemaining = timeFullSeconds
    }
    
    func stop() {
        isStarted = false
        cancellables.removeAll()
    }
}
