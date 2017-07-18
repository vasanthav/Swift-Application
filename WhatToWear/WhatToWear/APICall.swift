//
//  APICall.swift
//  WhatToWear
//
//  Created by Vasantha Vurakaranam on 9/29/16.
//


import Foundation
import UIKit

var str = "API Request"


private func dataTask(_ request: NSMutableURLRequest, method: String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
    request.httpMethod = method
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
        if let data = data {
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                completion(true, json as AnyObject?)
                
            } else {
                completion(true, json as AnyObject?)
            }
        }
        }) .resume()
}

private func clientURLRequest(_ params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
    let request = NSMutableURLRequest(url: URL(string: "http://swiftlabapi.mybluemix.net/api/stores")!)
    if let params = params {
        do {
            let json = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.httpBody = json
        } catch{
            print("Error")
        }
    }
    
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    return request
}



func get(_ request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
    dataTask(request, method: "GET", completion: completion)
}

func post(_ request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
    dataTask(request, method: "POST", completion: completion)
}

func requestGET(_ userName: String,completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()){
    /* let urlStr = "http://swiftlabapi.mybluemix.net/api/stores/findOne?filter[where][name]=" + userName */
     //let urlStr = "http://api.openweathermap.org/data/2.5/weather?q=London&APPID=ec8873215b7f54a366da3d1876139bff"
    let urlStr = "http://api.openweathermap.org/data/2.5/weather?APPID=ec8873215b7f54a366da3d1876139bff&q=" + userName
    print("URL STRING IS::::::", urlStr)
    let url = URL(string: urlStr)!
    let request = NSMutableURLRequest(url: url)
    get(request){ (success, object) -> () in
        if success {
            completion(success, object)
        } else {
            print("error");
        }
    }
    
}

func requestPOST(_ userName: String, userMessage: String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()){
    let userObject = ["name": userName, "message": userMessage]
    post(clientURLRequest(userObject as Dictionary<String, AnyObject>?)) { (success, object) -> () in
        if success {
            completion(true, object)
        } else {
            var message = "there was an error"
            if let object = object, let passedMessage = object["message"] as? String {
                message = passedMessage
            }
            completion(false, message as AnyObject?)
        }
    }
    
}
