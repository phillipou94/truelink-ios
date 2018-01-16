//
//  File.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/16/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import SwiftyJSON

class User: NSObject {
    var name : String?
    var id : String! // cannot be nil
    var email : String? 

    
    // For Testing/Mocking Responses
    init(id:String, name : String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
    
    init(json:JSON) {
        if let id = json["id"].string {
            self.id = id
        }
        
        if let name = json["name"].string {
            self.name = name
        }
        
        if let email = json["email"].string {
            self.email = email
        }
        
        
    }
    
}

