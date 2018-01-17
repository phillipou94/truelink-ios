//
//  Itay.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/16/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import Foundation
import SwiftyJSON

class Itay: NSObject {
    var id : String!
    var senderId : String! //lamp_id of sender
    var recipientId : String! //lamp_id of sender
    var sentTime:Date?
    var fromMe : Bool = false
    var fromName : String = ""
    var dateString : String = "Just Now"
    
    init(json:JSON) {
        if let id = json["id"].string {
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
                
                let nsDate = date as NSDate
                self.dateString = String.timeAgoSinceDate(date: nsDate, numericDates: true)
                
                
            }
            
        }
        
        
        
        
        
        
    }
    
    
}
