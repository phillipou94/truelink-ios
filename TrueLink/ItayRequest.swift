//
//  ItayRequest.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/16/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import Foundation
import SwiftyJSON
class ItayRequest: NSObject {
    static let shared = ItayRequest();

    
    func sendItay(userLampId : String, recipientLampId:String, success:@escaping (_ itayId:String) -> Void, failure:(_ errorMessage:String) -> Void) {
        let parameters = ["sender_id":userLampId, "recipient_id":recipientLampId] as [String:AnyObject]
            let endpoint = "itay"
        ServerRequest.shared.postWithEndpoint(endpoint: endpoint, parameters: parameters, authenticated: true, success: { (response) in
            
            if let itayId = response["itay_id"].string {
                success(itayId)
            }  
        }) { (error) in
            
        }
    }
    
    func getItays(success:@escaping (_ itays:[Itay]) -> Void, failure:(_ errorMessage:String) -> Void) {
        let lamp : Lamp? = LocalStorageManager.shared.getLamp()
        if let userId = LocalStorageManager.shared.getUserId() {
            let path = "itay_user/"+userId
            ServerRequest.shared.getWithEndpoint(endpoint: path, parameters: [:], authenticated: true, success: { (response) in
               let array = response.array
                let itayArrays = array?.map({ (json:JSON) -> Itay in
                    let itay = Itay(json:json)
                    itay.fromMe = lamp?.lampId == itay.senderId
                    
                    return itay
                })
                
                if let itays = itayArrays {
                    success(itays.reversed())
                }
                
            }, failure: { (error) in
                
            })
        }

    }
    
    
}
