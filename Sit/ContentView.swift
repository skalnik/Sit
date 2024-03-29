//
//  ContentView.swift
//  Sit
//
//  Created by Mike Skalnik on 8/16/20.
//  Copyright © 2020 Mike Skalnik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var sessionTimer: SessionTimer
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Session Time").font(.title)

                Picker("Session Time", selection: $sessionTimer.selectedMinutes) {
                    ForEach(sessionTimer.minuteOptions, id: \.self) { minutes in
                        Text("\(minutes) Minutes")
                    }
                }
                .pickerStyle(.inline)
                
                NavigationLink(destination: TimerView().environmentObject(sessionTimer), isActive: $sessionTimer.isActive) {
                    Text("Start")
                }.buttonStyle(PlainButtonStyle())
                .padding(10)
                .foregroundColor(Color.white)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
            }.navigationBarTitle("Sit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionTimer())
    }
}
