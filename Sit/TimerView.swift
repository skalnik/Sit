//
//  TimerView.swift
//  Sit
//
//  Created by Mike Skalnik on 8/20/20.
//  Copyright © 2020 Mike Skalnik. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @State private var timer: Timer? = nil

    @State private var timerRunning: Bool = false
    @State private var timeFormat: String = "%02d:%02d"

    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    
    @Binding var sessionMinutes: Int
    
    var body: some View {
        VStack {
            if timerRunning {
                Text("\(String(format: timeFormat, minutes, seconds))").padding()
                Button(action: toggleTimer) {
                    Text("Stop")
                    .foregroundColor(Color.red)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 2))
                }
            } else {
                Text("\(String(format: timeFormat, (sessionMinutes + 1), seconds))").padding()
                Button(action: toggleTimer) {
                    Text("Start")
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
                }
                
            }
        }
    }
    
    func toggleTimer() -> Void {
        if self.timerRunning {
            self.timer?.invalidate()
            self.timerRunning = false
            self.timer = nil
            self.minutes = 10
            self.seconds = 0
        } else {
            self.timerRunning = true
            self.minutes = sessionMinutes + 1

            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { innerTimer in
                if self.seconds == 0 {
                    if self.minutes == 0 {
                        innerTimer.invalidate()
                        self.timerRunning = false
                        self.timer = nil
                    } else {
                        self.seconds = 59
                        self.minutes -= 1
                    }
                } else {
                    self.seconds -= 1
                }
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(sessionMinutes: .constant(10))
    }
}
