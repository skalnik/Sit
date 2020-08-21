//
//  TimerView.swift
//  Sit
//
//  Created by Mike Skalnik on 8/20/20.
//  Copyright © 2020 Mike Skalnik. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @State var timer: Timer? = nil
    @State var minutes: Int = 10
    @State var seconds: Int = 0
    @State var timeString: String = String(format: "%02d:%02d", 10, 0)
    @State var timerRunning: Bool = false
    
    var body: some View {
        VStack {
            Text("\(timeString)").padding()
            Button(action: toggleTimer) {
                if timerRunning {
                    Text("Stop")
                    .foregroundColor(Color.red)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 2))
                } else {
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

            self.updateTimeString()
        } else {
            self.timerRunning = true

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

                self.updateTimeString()
            }
        }
    }

    func updateTimeString() -> Void {
        self.timeString = String(format: "%02d:%02d", self.minutes, self.seconds)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
