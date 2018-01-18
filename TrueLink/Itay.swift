//
//  Itay.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/16/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import Foundation
import SwiftyJSON

class Itay: NSObject, NSCoding {
    var id : String!
    var senderId : String! //lamp_id of sender
    var recipientId : String! //lamp_id of sender
    var sentTime:Date?
    var fromMe : Bool? = false
    var fromName : String? = ""
    var dateString : String? = "Just Now"
    
    init(id:String, senderId:String, recipientId:String, sentTime:Date? = nil, fromMe:Bool? = false, fromName:String? = "", dateString:String? = "Just Now") {
        self.id = id
        self.senderId = senderId
        self.recipientId = recipientId
        self.sentTime = sentTime
        self.fromMe = fromMe
        self.fromName = fromName
    }
    
    init(json:JSON) {
        if let id = json["_id"].string {
            self.id = id
        }
        
        if let senderId = json["sender_id"].string {
            self.senderId = senderId
        }
        
        if let recipientId = json["recipient_id"].string {
            self.recipientId = recipientId
        }
        
        if let sentTimeString = json["sent_time"].string {
            if let date : Date = sentTimeString.convertToDate() as Date {
                self.sentTime = date
            }
        }
        
        
    }
    
    // MARK: NSCoding
    
    required convenience init(coder decoder: NSCoder) {
        
        let id = decoder.decodeObject(forKey: "_id") as! String
        let senderId = decoder.decodeObject(forKey: "sender_id") as! String
        let recipientId = decoder.decodeObject(forKey: "recipient_id") as! String
        
        let sentTime = decoder.decodeObject(forKey: "sent_time") as? Date
        let fromMe = decoder.decodeObject(forKey: "from_me") as? Bool
        let fromName = decoder.decodeObject(forKey: "from_name") as? String
        self.init(id: "fdssd", senderId: senderId, recipientId: recipientId, sentTime: sentTime, fromMe:fromMe, fromName: fromName)

    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.id, forKey: "_id")
        aCoder.encode(self.senderId, forKey: "sender_id")
        aCoder.encode(self.recipientId, forKey: "recipient_id")
        aCoder.encode(self.sentTime, forKey: "sent_time")
        aCoder.encode(self.fromMe, forKey: "from_me")
        aCoder.encode(self.fromName, forKey: "from_name")
    }

    
    
}
