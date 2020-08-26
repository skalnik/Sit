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

    @Published var isActive: Bool = false
    @Published var isPaused: Bool = false
    @Published var selectedMinutes: Int = 10
    @Published var timer: Timer? = nil
    @Published var timeRemaining: String = "10:00"
    @Published var progress: Int = 0
    
    private var secondsRemaining: TimeInterval = 0
    private let chimeURL = URL(fileURLWithPath: Bundle.main.path(forResource: "chime.mp3", ofType: nil)!)
    private var chime: AVAudioPlayer?
    private var timeFormatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        
        return formatter
    }
    
    func startTimer() {
        secondsRemaining = TimeInterval(selectedMinutes * 60)
        isActive = true
        isPaused = false
        
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
        isActive = false
        timer?.invalidate()
    }
    
    func playPause() -> Void {
        isPaused.toggle()
    }
    
    func updateTimer() {
        if(!isPaused) {
            updateTimeRemaining()
            
            if secondsRemaining == 0 {
                chime?.play()
                stopTimer()
            } else {
                secondsRemaining -= 1
            }
        }
    }
    
    func updateTimeRemaining() {
        timeRemaining = timeFormatter.string(from: secondsRemaining) ?? "???"
    }
}
