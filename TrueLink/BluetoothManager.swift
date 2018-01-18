//
//  BluetoothManager.swift
//  TrueLink
//
//  Created by Hanna Lee on 1/18/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit
import Foundation
import Bluejay

class BluetoothManager: NSObject, ConnectionObserver {
    static let shared = BluetoothManager()

    func scanForPeripherals() {
        
        let bluejay = Bluejay()
        
        bluejay.start()
        
//        bluejay.start(connectionObserver: self)
        
        let serviceId = "19B10000-E8F2-537E-4F6C-D104768A1214"
        let characteristicId = "19B10001-E8F2-537E-4F6C-D104768A1214"
        
        let serviceIdentifier = ServiceIdentifier(uuid: serviceId)
        let characteristicIdentifier = CharacteristicIdentifier(uuid: characteristicId, service: serviceIdentifier)
        
        bluejay.scan(
            serviceIdentifiers: [serviceIdentifier],
            discovery: { [weak self] (discovery, discoveries) -> ScanAction in
                
                guard let weakSelf = self else {
                    return .stop
                }
                
                return .continue
            },
            stopped: { (discoveries, error) in
                if let error = error {
                    debugPrint("Scan stopped with error: \(error.localizedDescription)")
                }
                else {
                    debugPrint("Scan stopped without error.")
                }
        })
        
        
        

        
    }
    
    
    //Bluejay delegates
    func bluetoothAvailable(_ available: Bool) {
        
    }
    
    func connected(to peripheral: Peripheral) {
        
    }
    
    func disconnected(from peripheral: Peripheral) {
        
    }

}
