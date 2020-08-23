//
//  SessionTimer.swift
//  Sit
//
//  Created by Mike Skalnik on 8/22/20.
//  Copyright © 2020 Mike Skalnik. All rights reserved.
//

import Foundation
class SessionTimer: ObservableObject {
    public let minuteOptions = [Int](1...90)

    @Published var isRunning: Bool = false
}
