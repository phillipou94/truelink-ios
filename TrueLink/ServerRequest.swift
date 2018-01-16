//
//  ServerRequest.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/16/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON


class ServerRequest: NSObject {
    private let useMockedRequests = true
    private let baseURL = "https://murmuring-coast-1876.herokuapp.com/api/"
    static let shared = ServerRequest();
    
    //MARK :  Helper Methods
    private func getWithEndpoint(endpoint:String, parameters:[String : AnyObject]?, authenticated:Bool, success:@escaping (_ json:JSON) -> Void, failure:@escaping (_ error:JSON) -> Void) {
        let url = baseURL
        let path : String = url + endpoint;
        let headers = getRequestHeaders(authenticated: authenticated)
        
        
//        Alamofire.request(.GET, path, parameters: parameters, headers:headers, encoding: .JSON).responseJSON { response in
//            let status = response.response?.statusCode
//            if let data = response.data {
//                let json = JSON(data:data)
//                if(status == 200) {
//                    success(json: json)
//                } else {
//                    failure(error: json)
//                }
//            }
//        }
    }
    
    private func postWithEndpoint(endpoint:String, parameters:[String : AnyObject]?, authenticated:Bool, success:@escaping (_ json:JSON) -> Void, failure:@escaping (_ error:JSON) -> Void) {
        let url = baseURL
        let path : String = url + endpoint
        let headers = getRequestHeaders(authenticated: authenticated)
        
//        Alamofire.request(.POST, path, parameters: parameters, headers:headers, encoding: .JSON).responseJSON { response in
//            let status = response.response?.statusCode
//            if let data = response.data {
//                
//                let json = JSON(data:data)
//                if(status == 200) {
//                    success(json: json)
//                } else {
//                    failure(error: json)
//                }
//            }
//        }
    }
    
    
    private func putWithEndpoint(endpoint:String, parameters:[String : AnyObject]?, authenticated:Bool, success:@escaping (_ json:JSON) -> Void, failure:@escaping (_ error:JSON) -> Void) {
        let url = baseURL
        let path : String = url + endpoint
        let headers = getRequestHeaders(authenticated:authenticated)
//        Alamofire.request(.PUT, path, parameters: parameters, headers:headers, encoding: .JSON).responseJSON { response in
//            let status = response.response?.statusCode
//            if let data = response.data {
//                let json = JSON(data:data)
//                if(status == 200) {
//                    success(json: json)
//                } else {
//                    failure(error: json)
//                }
//            }
//        }
    }
    
    private func deleteWithEndoint(endpoint:String, parameters:[String : AnyObject]?, authenticated:Bool, success:@escaping (_ json:JSON) -> Void, failure:@escaping (_ error:JSON) -> Void) {
        let url = baseURL
        let path : String = url + endpoint
        let headers = getRequestHeaders(authenticated:authenticated)
//        Alamofire.request(.DELETE, path, parameters: parameters, headers:headers, encoding: .JSON).responseJSON { (response) -> Void in
//            let status = response.response?.statusCode
//            if let data = response.data {
//                let json = JSON(data:data)
//                if(status == 200 || status == 201) {
//                    success(json: json)
//                } else {
//                    failure(error: json)
//                }
//            }
//        }
    }
    
    private func getRequestHeaders(authenticated:Bool) -> [String:String] {

        return ["Content-Type" : "application/json", "Accept": "application/json"];
    }
    
}
