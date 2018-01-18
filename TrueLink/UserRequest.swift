//
//  UserRequest.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/16/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import Foundation
import SwiftyJSON
class UserRequest: NSObject {
    static let shared = UserRequest()
    
    func loginWithEmail(email:String, password:String, success:@escaping (_ lamps:[Lamp]) -> Void, failure:(_ errorMessage:String) -> Void) {
        let endpoint = "login"
        let parameters = ["email":email, "password":password]
        
        ServerRequest.shared.postWithEndpoint(endpoint: endpoint, parameters: parameters as [String : AnyObject], authenticated: false ,  success: { (responseObject) in
            
            if let userId = responseObject["user_id"].string {
                LocalStorageManager.shared.updateUserId(userId: userId)
            }
            
            if let array = responseObject["connections"].array {
                let lamps = array.map({ (json:JSON) -> Lamp in
                                return Lamp.init(json: json)
                            })
                
                
                LocalStorageManager.shared.updateConnections(connections: lamps)
                
                success(lamps)
            } else {
                
                success([])
            }
            //TODO: RETURN CONNECTIONS

        }) { (failureResponse) in
            
        }
    }
    
    func createUser(name:String, email:String, password:String, phoneId:String? = nil,  success:@escaping (_ user:User) -> Void, failure:(_ errorMessage:String) -> Void) {
        let path = "user"
        let parameters = ["name":name, "email":email, "password":password, "phone_id":phoneId]
        
        ServerRequest.shared.postWithEndpoint(endpoint: path, parameters: parameters as [String : AnyObject], authenticated: false, success: { (responseObject) in
            
            if let userId = responseObject["user_id"].string {
                LocalStorageManager.shared.updateUserId(userId: userId)
                let user = User.init(id: userId, name: name, email: email)
                success(user)
            }
            
            
            
        }) { (errorObject) in
            
        }
    }
    
    func connectLamp(lampId : String, success:@escaping (_ lamp:Lamp) -> Void, failure:(_ errorMessage:String) -> Void) {
        if let userId = LocalStorageManager.shared.getUserId() {
            let endpoint = "user/" + userId
            let parameters = ["lamp_id":lampId]
            ServerRequest.shared.putWithEndpoint(endpoint: endpoint, parameters: parameters as [String : AnyObject], authenticated: true, success: { (responseObject) in
                
                
                let lamp = Lamp(json: responseObject["lamp"])
                
                // cache lamp
                LocalStorageManager.shared.updateLamp(lamp: lamp)
                success(lamp)
            }, failure: { (errorobject) in
                
            })
        }
    }
    

}
