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
    private let baseURL = "https://limitless-lowlands-74122.herokuapp.com/"
    static let shared = ServerRequest();
    
    //MARK :  Helper Methods
    func getWithEndpoint(endpoint:String, parameters:[String : AnyObject]?, authenticated:Bool, success:@escaping (_ json:JSON) -> Void, failure:@escaping (_ error:JSON) -> Void) {
        let url = baseURL
        let path : String = url + endpoint;
        Alamofire.request(path, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                let status = response.response?.statusCode
                if let data = response.data {
                    let json = JSON(data)
                    if(status == 200) {
                        success(json)
                    } else {
                        failure(json)
                    }
                }
                
        }

    }
    
     func postWithEndpoint(endpoint:String, parameters:[String : AnyObject]?, authenticated:Bool, success:@escaping (_ json:JSON) -> Void, failure:@escaping (_ error:JSON) -> Void) {
        let url = baseURL
        let path : String = url + endpoint
        Alamofire.request(path, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                let status = response.response?.statusCode
                    if let data = response.data {
                        let json = JSON(data)
                        if(status == 200) {
                            success(json)
                        } else {
                            failure(json)
                        }
                    }

        }

    }
    
    
    private func putWithEndpoint(endpoint:String, parameters:[String : AnyObject]?, authenticated:Bool, success:@escaping (_ json:JSON) -> Void, failure:@escaping (_ error:JSON) -> Void) {
        let url = baseURL
        let path : String = url + endpoint
        let headers = getRequestHeaders(authenticated:authenticated)
        
        Alamofire.request(path, method: .put, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                let status = response.response?.statusCode
                if let data = response.data {
                    let json = JSON(data)
                    if(status == 200) {
                        success(json)
                    } else {
                        failure(json)
                    }
                }
                
        }
    }
    
    private func deleteWithEndoint(endpoint:String, parameters:[String : AnyObject]?, authenticated:Bool, success:@escaping (_ json:JSON) -> Void, failure:@escaping (_ error:JSON) -> Void) {
        let url = baseURL
        let path : String = url + endpoint
        let headers = getRequestHeaders(authenticated:authenticated)
        Alamofire.request(path, method: .delete, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                let status = response.response?.statusCode
                if let data = response.data {
                    let json = JSON(data)
                    if(status == 200) {
                        success(json)
                    } else {
                        failure(json)
                    }
                }
                
        }
    }
    
    private func getRequestHeaders(authenticated:Bool) -> [String:String] {

        return ["Content-Type" : "application/json"];
    }
    
}
