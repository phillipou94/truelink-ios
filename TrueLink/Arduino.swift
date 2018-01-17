//
//  Arduino.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/17/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit

import SwiftyJSON

class Arduino: NSObject {
    var name : String?
    var id : String!
    
    
    
    // For Testing/Mocking Responses
    init(id:String, name : String) {
        self.id = id
        self.name = name
    }
    
    init(json:JSON) {
        if let id = json["id"].string {
            self.id = id
        }
        
        if let name = json["name"].string {
            self.name = name
        }
        
        
    }
    
}

