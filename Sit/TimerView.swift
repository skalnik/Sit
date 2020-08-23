//
//  TimerView.swift
//  Sit
//
//  Created by Mike Skalnik on 8/20/20.
//  Copyright © 2020 Mike Skalnik. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timerRunning = false
    @State private var timeFormat = "%02d:%02d"

    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    
    @Binding var sessionMinutes: Int
    
    var body: some View {
        VStack {
            Text("\(String(format: timeFormat, minutes, seconds))").padding()
        }.onReceive(timer) { timer in
            self.updateTime()
        }.onAppear {
            self.minutes = self.sessionMinutes
            self.timerRunning = true
        }
    }
    
    func updateTime() -> Void {
        if self.seconds == 0 {
            if self.minutes == 0 {
                self.minutes = sessionMinutes
                self.timerRunning = false
            } else {
                self.seconds = 59
                self.minutes -= 1
            }
        } else {
            self.seconds -= 1
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(sessionMinutes: .constant(10))
    }
}
