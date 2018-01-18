//
//  ScanAction.swift
//  Bluejay
//
//  Created by Jeremy Chiang on 2017-02-27.
//  Copyright © 2017 Steamclock Software. All rights reserved.
//

import Foundation

public enum ScanAction {
    case `continue`
    case blacklist
    case stop
    case connect(ScanDiscovery, (ConnectionResult) -> Void)
}
