//
//  MockNetworkingManager.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/31/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import UIKit

class MockNetworkingManager: NSObject, NetworkManagerProtocol {
    var needToFail = false
    
    func request(_ requestURL: String, params: [String : Any], callback: @escaping ([String : Any]?, Error?) -> (Void)) {
        let json = ["page": 0,
                    "pageSize" : 10,
                    "totalPageCount" : 8,
                    "wkda": ["key1": "Manufacturer 1",
                             "key2": "Manufacturer 2"]] as [String : Any]
        if needToFail {
            let error = NSError(domain: "com.JustStan.JustTest", code: 1, userInfo: nil)
         callback(nil, error)
        } else {
            callback(json, nil)
        }
    }
}
