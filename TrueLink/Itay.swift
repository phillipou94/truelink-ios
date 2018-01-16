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
    var incoming: Bool
    var acked: Bool
    var sentTime:Date
    var ackedTime:Date
    
    
    
    init(json:JSON) {
        if let id = json["id"].string {
            self.id = id
        }
        
        if let incoming = json["incoming"].bool {
            self.incoming = incoming
        }
        
        if let acked = json["acked"].bool {
            self.acked = acked
        }
        
        if let sentTimeString = json["sent_time"].string {
            if let date = sentTimeString.convertToDate() as! Date {
                self.sentTime = date
            }
            
        }
        
        if let ackedTime = json["acked_time"].string {
            if let date = sentTimeString.convertToDate() as! Date {
                self.ackedTime = date
            }
        }
        
        
        
    }
    
    
}
