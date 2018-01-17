//
//  ItayRequest.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/16/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import Foundation
class ItayRequest: NSObject {
    static let shared = ItayRequest();
    let endpoint = "itay"
    
    func sendItay(connectionId : String, success:@escaping (_ success:AnyObject) -> Void, failure:(_ errorMessage:String) -> Void) {
        let userId = LocalStorageManager.shared.getUserId()
        let parameters = ["user_id":userId, "connection_id":connectionId, "to_phone":false] as [String:AnyObject]
        
        ServerRequest.shared.postWithEndpoint(endpoint: endpoint, parameters: parameters, authenticated: true, success: { (response) in
            success(response as AnyObject)
        }) { (error) in
            
        }
    }
    
    
}
