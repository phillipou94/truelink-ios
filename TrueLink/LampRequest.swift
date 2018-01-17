//
//  LampRequest.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/17/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import Foundation
class LampRequest: NSObject {
    static let shared = LampRequest();
    let endpoint = "lamp"
    
    func createLamp(lampId : String, arduinoAddress:String, partnerId : String, success:@escaping (_ lamp:Lamp) -> Void, failure:(_ errorMessage:String) -> Void) {
        let parameters = ["lamp_id":lampId, "arduino_address":arduinoAddress, "partner_lamp_id":partnerId] as [String:AnyObject]
        
        ServerRequest.shared.postWithEndpoint(endpoint: endpoint, parameters: parameters, authenticated: true, success: { (lampJSON) in
            
            success(Lamp(json: lampJSON))
        }) { (error) in
            
        }
    }
    
    func connectPartnerLamp(partnerLampId: String, nickname:String, success:@escaping (_ lamp:Lamp) -> Void, failure:(_ errorMessage:String) -> Void) {
        let path = endpoint+"/"+partnerLampId
        let parameters = ["nickname":nickname] as [String:AnyObject]
        ServerRequest.shared.putWithEndpoint(endpoint: path, parameters: parameters, authenticated: true, success: { (lampJSON) in
            
            success(Lamp(json:lampJSON))
        }) { (error) in
            
        }
    }
    
    
}
