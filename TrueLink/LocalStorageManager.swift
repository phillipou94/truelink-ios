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
    let keychain = Keychain(accessGroup: "TrueLinkLocalStorage")
    static let shared = LocalStorageManager()
    
    func updateUserId(userId:String) {
        do {
            try keychain.set(userId, key: "userId")
        } catch let error {
            print(error)
        }
    }
    
    func getUserId() -> String? {
        do {
            let userId = try keychain.get("userId")
            return userId
            
        } catch let error {
            return nil
        }
        
    }
    
    func deleteUserToken() {
        do {
            try keychain.remove("userId")
        } catch let error {
            print("error: \(error)")
        }
    }
    
}
