//
//  TimerView.swift
//  Sit
//
//  Created by Mike Skalnik on 8/20/20.
//  Copyright © 2020 Mike Skalnik. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var sessionTimer: SessionTimer

    @State private var timer: Timer? = nil
    @State private var timeFormat = "%02d:%02d"

    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    
    @Binding var sessionMinutes: Int
    
    var body: some View {
        VStack {
            Text("\(String(format: timeFormat, minutes, seconds))")
                .font(.largeTitle)
        }.onAppear {
            self.startTimer()
        }.onDisappear {
            self.stopTimer()
        }
    }
    
    private func startTimer() -> Void {
        self.minutes = self.sessionMinutes
        sessionTimer.isRunning = true

        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.seconds == 0 {
                if self.minutes == 0 {
                    self.stopTimer()
                } else {
                    self.seconds = 59
                    self.minutes -= 1
                }
            } else {
                self.seconds -= 1
            }
        }
    }

    private func stopTimer() -> Void {
        sessionTimer.isRunning = false
        self.timer?.invalidate()
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(sessionMinutes: .constant(10))
    }
}
