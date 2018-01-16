//
//  Connection.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/16/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import Foundation
import SwiftyJSON

class Connection: NSObject {
    var id : String!
    var name : String?
    var deviceId: String?
    var imageUrl : String?
    var userId : String?
    var timeZone : Int
    
    
    init(json:JSON) {
        if let id = json["id"].string {
            self.id = id
        }
        
        if let name = json["name"].string {
            self.name = name
        }
        
        if let deviceId = json["deviceId"].string {
            self.deviceId = deviceId
        }
        
        if let imageUrl = json["imageUrl"].string {
            self.imageUrl = imageUrl
        }
        
        if let imageUrl = json["imageUrl"].string {
            self.imageUrl = imageUrl
        }
        
        self.timeZone = 0
        
        
    }
    
    
}
