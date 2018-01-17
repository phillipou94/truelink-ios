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
    let arduinoCache = NSCache<NSString, AnyObject>()
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
    
    func updateArduinoId(partnerArduinoId:String) {
        userIdCache.setObject(partnerArduinoId as NSString, forKey: "arduinoId")
    }
    
    func getArduinoId() -> String? {
        if userIdCache.object(forKey: "arduinoId") == nil {
            return nil
        }
        return userIdCache.object(forKey: "arduinoId") as! String
        
        
    }

    func updatePartnerArduinoId(partnerArduinoId:String) {
        userIdCache.setObject(partnerArduinoId as NSString, forKey: "partnerArduinoId")
    }
    
    func deletePartnerArduino() {
        userIdCache.removeObject(forKey: "partnerArduinoId")
    }
    
    
    func getPartnerArduinoId() -> String? {
        if userIdCache.object(forKey: "partnerArduinoId") == nil {
            return nil
        }
        return userIdCache.object(forKey: "partnerArduinoId") as! String
        
    }

    
}
