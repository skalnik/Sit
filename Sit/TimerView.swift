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
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .trim(from: CGFloat(sessionTimer.progress), to: 1)
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round))
                    .foregroundColor(Color.blue)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 300, height: 300)
                    .padding()
                    .animation(.easeIn, value: sessionTimer.progress)
                Circle()
                    .trim(from: CGFloat(sessionTimer.intervalTimer.progress), to: 1)
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round))
                    .foregroundColor(Color.indigo)
                    .frame(width: 260, height: 260)
                    .rotationEffect(.degrees(-90))
                    .padding()
                    .animation(.easeIn, value: sessionTimer.intervalTimer.progress)

                Text("\(sessionTimer.timeRemaining)")
                    .font(.largeTitle)
            }
            Button(action: { self.sessionTimer.playPause() }) {
                if(sessionTimer.isPaused) {
                    Image(systemName: "play.circle")
                        .font(.largeTitle)
                        .padding()
                } else {
                    Image(systemName: "pause.circle.fill")
                        .font(.largeTitle)
                        .padding()
                }
            }
        }.onAppear {
            self.sessionTimer.startTimer()
        }.onDisappear {
            self.sessionTimer.stopTimer()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView().environmentObject(SessionTimer())
    }
}
