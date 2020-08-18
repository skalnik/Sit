//
//  ContentView.swift
//  Sit
//
//  Created by Mike Skalnik on 8/16/20.
//  Copyright © 2020 Mike Skalnik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var timeLeft: String = "00:00:00"
    let df = DateFormatter()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("\(timeLeft)").padding().onReceive(timer) { time in
                self.df.dateFormat = "hh:mm:ss"
                self.timeLeft = self.df.string(from: time)
            }
            
            Button(action: startTimer) {
                Text("Start")
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
            }
        }
    }

    func startTimer() -> Void {
        // Make timer start instead of autostarting with `#autconnect()`
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

