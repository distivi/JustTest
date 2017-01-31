//
//  NetworkingManagerAlamofire.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/30/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import UIKit
import Alamofire

class NetworkingManagerAlamofire: NSObject, NetworkManagerProtocol {
    
    func request(_ requestURL: String, params: [String: Any], callback: @escaping ([String: Any]?, Error?) -> (Void)) {
        Alamofire.request(requestURL, parameters: params)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                if let json = response.result.value as? Dictionary<String, Any> {
                    callback(json,nil)
                } else {
                    callback(nil,response.result.error)
                }
        }
    }
}
