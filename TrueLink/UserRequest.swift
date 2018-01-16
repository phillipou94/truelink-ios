//
//  UserRequest.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/16/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import Foundation
class UserRequest: NSObject {
    static let shared = UserRequest();
    
    func loginWithEmail(email:String, password:String, success:@escaping (_ response:[AnyObject]) -> Void, failure:(_ errorMessage:String) -> Void) {
        let endpoint = "login"
        let parameters = ["email":email, "password":password]
        
        ServerRequest.shared.postWithEndpoint(endpoint: endpoint, parameters: parameters as [String : AnyObject], authenticated: false ,  success: { (responseObject) in
            
            if let userId = responseObject["user_id"].string {
                LocalStorageManager.shared.updateUserId(userId: userId)
            }
            
            //TODO: RETURN CONNECTIONS

        }) { (failureResponse) in
            
        }
    }
    
    func createUser(name:String, email:String, password:String, phoneId:String,  success:(_ user:User) -> Void, failure:(_ errorMessage:String) -> Void) {
        let path = "create_user"
        let parameters = ["name":name, "email":email, "password":password, "phone_id":phoneId]
        
        ServerRequest.shared.postWithEndpoint(endpoint: path, parameters: parameters as [String : AnyObject], authenticated: false, success: { (responseObject) in
            
            if let userId = responseObject["user_id"].string {
                LocalStorageManager.shared.updateUserId(userId: userId)
            }
            
        }) { (errorObject) in
            
        }
    }
    

}
