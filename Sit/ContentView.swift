//
//  ContentView.swift
//  Sit
//
//  Created by Mike Skalnik on 8/16/20.
//  Copyright © 2020 Mike Skalnik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private var max = 90
    @State private var sessionMinutes: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Session Time").bold()
                    Picker("Session Time", selection: $sessionMinutes) {
                        ForEach(1..<90) { minutes in
                            Text("\(minutes)").tag(minutes)
                        }
                    }.labelsHidden()
                }

                NavigationLink(destination: TimerView(sessionMinutes: $sessionMinutes)) {
                    Text("Lets see the \(self.sessionMinutes) minute timer")
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
        ContentView()
    }
}
