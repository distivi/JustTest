//
//  APIManager.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/26/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    func request(_ requestURL: String, params: [String: Any], callback: @escaping ([String: Any]?, Error?) -> (Void))
}


class APIManager: NSObject {
    var networking:NetworkManagerProtocol = NetworkingManagerAlamofire() // by default
    
    // WARNING: all url & endpoints are reversed to avoid code matching on GitHub search ;-)
    let baseUrl = String("/moc.tset-1otua.1-aq-ue-swa-ipa//:ptth".characters.reversed())
    let secretValue = String("d9cc944-tneilc-elzzup-gnidoc".characters.reversed())
    
    //MARK: - API calls
    
    func getManufacturersList(withPage page: Int, pageSize: Int, callback: @escaping (Dictionary<String, Any>?, Error?) -> (Void))  {
        let apiCall = String("rerutcafunam/sepyt-rac/1v".characters.reversed())
        let parameters: Dictionary<String, Any> = ["page": page, "pageSize": pageSize]
        
        self.runApiCall(apiCall: apiCall, params: parameters, callback: callback)
    }
    
    func getModelTypes(withManufacturerId manufacturerID: String, page: Int, pageSize: Int, callback: @escaping (Dictionary<String, Any>?, Error?) -> (Void))  {
        let apiCall = String("sepyt-niam/sepyt-rac/1v".characters.reversed())
        let parameters: Dictionary<String, Any> = ["manufacturer": manufacturerID, "page": page, "pageSize": pageSize]
        
        self.runApiCall(apiCall: apiCall, params: parameters, callback: callback)
    }
    
    //MARK: - Private
    
    private func runApiCall(apiCall: String, params: [String: Any], callback: @escaping ([String: Any]?, Error?) -> (Void)) {
        let requestUrl = baseUrl + apiCall
        var parameters = params
        parameters["wa_key"] = secretValue
        
        self.networking.request(requestUrl, params: parameters, callback: callback)
    }    
}
