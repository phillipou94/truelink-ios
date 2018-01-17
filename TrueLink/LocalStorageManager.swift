//
//  LocalStorageManager.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/16/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import Foundation
import KeychainAccess

class LocalStorageManager: NSObject {
    let userIdCache = NSCache<NSString, NSString>()
    let arduinoCache = NSCache<NSString, Arduino>()
    let connectionsCache = NSCache<NSString, NSArray>()
    let itaysCache = NSCache<NSString, NSArray>()
    let keychain = Keychain(accessGroup: "TrueLinkLocalStorage")
    static let shared = LocalStorageManager()
    
    func updateUserId(userId:String) {
        userIdCache.setObject(userId as NSString, forKey: "userId")

    }
    
    func getUserId() -> String? {
        if userIdCache.object(forKey: "userId") == nil {
            return nil
        }
        return userIdCache.object(forKey: "userId") as! String
        
    }
    
    
    func deleteUserToken() {
        userIdCache.removeObject(forKey: "userId")
    }
    
    func updatePartnerArduino(partnerArduino:Arduino) {
        arduinoCache.setObject(partnerArduino, forKey: "partnerArduino")
    }
    
    func deletePartnerArduino() {
        arduinoCache.removeObject(forKey: "partnerArduinoId")
    }
    
    
    func getPartnerArduino() -> Arduino? {
        if let partnerArduino = arduinoCache.object(forKey: "partnerArduino") {
            return partnerArduino
        }
        return nil
        
    }
    
    func getConnections() -> [Arduino] {
        if (connectionsCache.object(forKey: "connections") != nil) {
            let array : NSArray = connectionsCache.object(forKey: "connections")!
            let connections: [Arduino] = array.flatMap({ $0 as? Arduino })
            return connections
        }
        return []
    }
    
    func updateConnections(connections:[Arduino]) {
        connectionsCache.setObject(connections as NSArray, forKey: "connections")
    }
    
    func getItays() -> [Itay] {
        if (itaysCache.object(forKey: "connections") != nil) {
            let array : NSArray = connectionsCache.object(forKey: "itays")!
            let itays: [Itay] = array.flatMap({ $0 as? Itay })
            return itays
        }
        return []
    }
    
    func updateItays(connections:[Itay]) {
        itaysCache.setObject(connections as NSArray, forKey: "itays")
    }


    
}
