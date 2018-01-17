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
    static let shared = LocalStorageManager()
    
    func updateUserId(userId:String) {
        
        UserDefaults.standard.set(userId as NSString, forKey: "userId")
        UserDefaults.standard.synchronize()
        

    }
    
    func getUserId() -> String? {
        if UserDefaults.standard.string(forKey: "userId") == nil {
            return nil
        }
        return UserDefaults.standard.string(forKey: "userId") as! String
        
    }
    
    
    func deleteUserToken() {
        UserDefaults.standard.removeObject(forKey: "userId")
    }
    
    func updateLamp(lamp:Lamp) {
        let lampData = NSKeyedArchiver.archivedData(withRootObject: lamp)
        
        UserDefaults.standard.set(lampData, forKey: "lamp")
        UserDefaults.standard.synchronize()

    }
    
    func getLamp() -> Lamp? {
        
        if let lampData = UserDefaults.standard.object(forKey: "lamp") as? Data {
            let lamp = NSKeyedUnarchiver.unarchiveObject(with: lampData as Data) as? Lamp
            
            return lamp
    
        }
        return nil
        
    }
    
    
    func updatePartnerLamp(partnerLamp:Lamp) {
        UserDefaults.standard.set(partnerLamp as NSObject, forKey: "partnerLamp")
        UserDefaults.standard.synchronize()
    }
    
    func deletePartnerLamp() {
        UserDefaults.standard.removeObject(forKey: "partnerLampId")
    }
    
    
    func getPartnerLamp() -> Lamp? {
        if let partnerLamp = UserDefaults.standard.object(forKey: "partnerLamp") {
            return partnerLamp as? Lamp
        }
        return nil
        
    }
    
    func getConnections() -> [Lamp] {
        if let lampData = UserDefaults.standard.object(forKey: "connections") as? Data {
            if let connections = NSKeyedUnarchiver.unarchiveObject(with: lampData as Data) as? [Lamp] {
                return connections
            }

            
        }
        return []
    }
    
    func updateConnections(connections:[Lamp]) {
        let connectionsData = NSKeyedArchiver.archivedData(withRootObject: connections)
        UserDefaults.standard.set(connectionsData, forKey: "connections")
        UserDefaults.standard.synchronize()
    }
    
    func getItays() -> [Itay] {
        if (UserDefaults.standard.object(forKey: "connections") != nil) {
            let itays: [Itay] = UserDefaults.standard.object(forKey: "itays") as! [Itay]
            return itays
        }
        return []
    }
    
    func updateItays(connections:[Itay]) {
        UserDefaults.standard.set(connections as NSArray, forKey: "itays")
    }


    
}
