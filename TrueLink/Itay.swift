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
    var sentTime:Date?
    
    
    
    init(json:JSON) {
        if let id = json["id"].string {
            self.id = id
        }
        
        if let sentTimeString = json["sent_time"].string {
            if let date : Date = sentTimeString.convertToDate() as Date {
                self.sentTime = date
            }
            
        }
        
        
    }
    
    
}
