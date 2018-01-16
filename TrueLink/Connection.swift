//
//  Connection.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/16/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import Foundation
import SwiftyJSON

class Connection: NSObject, NSCoding{
    var id : String!
    var name : String?
    var deviceId: String?
    var imageUrl : String?
    var userId : String?
    var timeZone : Int
    
    init(id:String, name:String, deviceId:String, imageUrl:String, userId:String, timeZone: Int) {
        self.id = id
        self.name = name
        self.deviceId = deviceId
        self.imageUrl = imageUrl
        self.userId = userId
        self.timeZone = timeZone
    }
    
    
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
    
    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let id = decoder.decodeObject(forKey: "id") as? String,
                let name = decoder.decodeObject(forKey: "name") as? String,
                let deviceId = decoder.decodeObject(forKey: "deviceId") as? String,
                let imageUrl = decoder.decodeObject(forKey: "imageUrl") as? String,
                let userId = decoder.decodeObject(forKey: "userId") as? String,
                let timeZone = decoder.decodeObject(forKey: "timeZone") as? Int
        else { return nil }

        
        self.init(
            id: id,
            name: name,
            deviceId: deviceId,
            imageUrl: imageUrl,
            userId: userId,
            timeZone:timeZone
        )
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "title")
        coder.encode(self.name, forKey: "name")
        coder.encode(self.deviceId, forKey: "deviceId")
        coder.encode(self.imageUrl, forKey: "imageUrl")
        coder.encode(self.timeZone, forKey: "timeZone")
    }
    
    
}
