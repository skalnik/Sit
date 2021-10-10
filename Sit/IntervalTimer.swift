//
//  IntervalTimer.swift
//  Sit
//
//  Created by Mike Skalnik on 11/27/20.
//  Copyright © 2020 Mike Skalnik. All rights reserved.
//

import Foundation

class IntervalTimer: ObservableObject {
    public let minuteOptions = [1, 2, 3, 4, 5, 10]
    public let selectedMinutes = 5
    private var secondsRemaining: TimeInterval = 0
    
    @Published var progress: Double = 0
    
    init() {
        // Make this configurable
        secondsRemaining = TimeInterval(selectedMinutes * 60)
    }
    
    func updateTimer() {
        if secondsRemaining == 0 {
            secondsRemaining = TimeInterval(selectedMinutes * 60)
        } else {
            secondsRemaining -= 1
        }
        
        progress = (1 - secondsRemaining / Double(selectedMinutes * 60))
    }
}
