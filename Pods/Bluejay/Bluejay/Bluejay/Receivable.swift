//
//  Receivable.swift
//  Bluejay
//
//  Created by Jeremy Chiang on 2017-01-03.
//  Copyright © 2017 Steamclock Software. All rights reserved.
//

import Foundation

/// Protocol to indicate that a type can be received from the bluetooth connection.
public protocol Receivable {
    init(bluetoothData: Data)
}
