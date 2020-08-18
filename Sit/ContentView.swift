//
//  ContentView.swift
//  Sit
//
//  Created by Mike Skalnik on 8/16/20.
//  Copyright © 2020 Mike Skalnik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var pressed: Int = 0

    var body: some View {
        VStack {
            Text("\(pressed)").padding()
            Button(action: increment) {
                Text("Add")
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
            }
        }
    }

    func increment() -> Void {
        self.pressed = self.pressed + 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
