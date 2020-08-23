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
            Text("\(self.sessionTimer.timeRemaining)")
                .font(.largeTitle)
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
