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
                Arc(startAngle: .degrees(sessionTimer.progress * (360 / 100)), endAngle: .degrees(360), clockwise: true)
                    .strokeBorder(Color.blue, lineWidth: 40)
                    .padding()
                Text("\(sessionTimer.timeRemaining)")
                    .font(.largeTitle)
            }.onAppear {
                self.sessionTimer.startTimer()
            }.onDisappear {
                self.sessionTimer.stopTimer()
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
        }
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView().environmentObject(SessionTimer())
    }
}
