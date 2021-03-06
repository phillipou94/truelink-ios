//
//  Lamp.swift
//  TrueLink
//
//  Created by Hanna Lee on 1/17/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//


import Foundation
import SwiftyJSON

class Lamp: NSObject, NSCoding{
    var lampId : String!
    var arduinoAddress : String!
    var partnerLampId: String!
    var userId: String?
    var nickname : String?
    var timezone : Int? // Probably defaults to whatever the user's timezone is
    var imageUrl: String?
    
    init(lampId:String, arduinoAddress:String, partnerLampId:String,
         userId:String? = nil, nickname:String? = nil, timezone: Int? = 0, imageUrl: String? = nil) {
        self.lampId = lampId
        self.arduinoAddress = arduinoAddress
        self.partnerLampId = partnerLampId
        self.userId = userId
        self.nickname = nickname
        self.timezone = timezone
        self.imageUrl = imageUrl
    }
    
    
    init(json:JSON) {
        if let lampId = json["lamp_id"].string {
            self.lampId = lampId
        }
        
        if let arduinoAddress = json["arduino_address"].string {
            self.arduinoAddress = arduinoAddress
        }
        
        if let partnerLampId = json["partner_lamp_id"].string {
            self.partnerLampId = partnerLampId
        }
        
        if let userId = json["user_id"].string {
            self.userId = userId
        }
      
        if let nickname = json["nickname"].string {
            self.nickname = nickname
        }
        
        if let timezone = json["timezone"].int {
            self.timezone = timezone
        }
        
        if let imageUrl = json["imageUrl"].string {
            self.imageUrl = imageUrl
        }
        
        self.timezone = 0
    }
    
    // MARK: NSCoding
    
    required convenience init(coder decoder: NSCoder) {
        let lampId = decoder.decodeObject(forKey: "lamp_id") as! String
        let arduinoAddress = decoder.decodeObject(forKey: "arduino_address") as! String
        let partnerLampId = decoder.decodeObject(forKey: "partner_lamp_id") as! String
        let userId = decoder.decodeObject(forKey: "user_id") as? String
        let nickname = decoder.decodeObject(forKey: "nickname") as? String
        let timezone = decoder.decodeObject(forKey: "timezone") as? Int
        let imageUrl = decoder.decodeObject(forKey: "image_url") as? String
        self.init(lampId: lampId, arduinoAddress: arduinoAddress, partnerLampId: partnerLampId, userId: userId, nickname: nickname, timezone: timezone, imageUrl: imageUrl)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.lampId, forKey: "lamp_id")
        aCoder.encode(self.arduinoAddress, forKey: "arduino_address")
        aCoder.encode(self.partnerLampId, forKey: "partner_lamp_id")
        aCoder.encode(self.userId, forKey: "user_id")
        aCoder.encode(self.nickname, forKey: "nickname")
        aCoder.encode(self.imageUrl, forKey: "image_url")
        aCoder.encode(self.timezone, forKey: "timezone")
    }
    
    
}

