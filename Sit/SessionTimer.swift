//
//  SessionTimer.swift
//  Sit
//
//  Created by Mike Skalnik on 8/22/20.
//  Copyright © 2020 Mike Skalnik. All rights reserved.
//

import Foundation
import AVFoundation

class SessionTimer: ObservableObject {
    public let minuteOptions = [Int](1...90)

    @Published var isRunning: Bool = false
    @Published var selectedMinutes: Int = 10
    @Published var timer: Timer? = nil
    @Published var timeRemaining: String = "10:00"
    
    private var seconds: Int = 0
    private var minutes: Int = 0
    private let chimeURL = URL(fileURLWithPath: Bundle.main.path(forResource: "chime.mp3", ofType: nil)!)
    private var chime: AVAudioPlayer?
    
    func startTimer() {
        minutes = selectedMinutes
        seconds = 0
        isRunning = true
        
        do {
            chime = try AVAudioPlayer(contentsOf: chimeURL)
        } catch {
            print("Couldn't load sound file")
        }
        
        updateTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateTimer()
        }
    }
    
    func stopTimer() {
        isRunning = false
        timer?.invalidate()
    }
    
    func updateTimer() {
        updateTimeRemaining()
        
        if seconds == 0 {
            if minutes == 0 {
                chime?.play()
                stopTimer()
            } else {
                seconds = 59
                minutes -= 1
            }
        } else {
            seconds -= 1
        }
    }
    
    func updateTimeRemaining() {
        timeRemaining = String(format: "%02d:%02d", minutes, seconds)
    }
}
