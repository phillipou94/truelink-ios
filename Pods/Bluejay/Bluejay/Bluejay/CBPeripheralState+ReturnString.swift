//
//  CBPeripheralState+ReturnString.swift
//  Bluejay
//
//  Created by Jeremy Chiang on 2017-01-11.
//  Copyright © 2017 Steamclock Software. All rights reserved.
//

import Foundation
import CoreBluetooth

extension CBPeripheralState {
    
    public func string() -> String {
        switch self {
        case .connected: return "Connected"
        case .connecting: return "Connecting"
        case .disconnected: return "Disconnected"
        case .disconnecting: return "Disconnecting"
        }
    }
    
}
