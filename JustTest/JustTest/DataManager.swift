//
//  DataManager.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/26/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import Foundation

class DataManager: NSObject {
    
    func getManufacturer(with pagination: PaginationModel,
                         callback: @escaping (PaginationModel?, [Manufacturer]?, Error?) -> (Void) ) {
        Engine.sharedInstance.apiMamanger.getManufacturersList(withPage: pagination.page,
                                                               pageSize: pagination.pageSize)
        { (optJSON, error) -> (Void) in
            if let json = optJSON {
                let newPagination = self.parsePagination(json: json)
                let manufacturers = self.parseManufactures(json: json)
                
                callback(newPagination,manufacturers,nil)
            } else {
                callback(nil,nil,error)
            }
        }
    }
    
    func getModelTypesFor(manufacturer :Manufacturer,
                          pagination: PaginationModel,
                          callback: @escaping (PaginationModel?, [String]?, Error?) -> (Void)) {
        Engine.sharedInstance.apiMamanger.getModelTypes(withManufacturerId: manufacturer.manufacturerID,
                                                        page: pagination.page,
                                                        pageSize: pagination.pageSize)
        { (optJSON, error) -> (Void) in
            if let json = optJSON {
                
                let newPagination = self.parsePagination(json: json)
                let models = self.parseCarModels(json: json)
                
                callback(newPagination,models,nil)
            } else {
                callback(nil,nil,error)
            }
            
        }
    }
    
    
    // MARK: - parsers
    
    private func parseError(json: Dictionary<String, Any>) -> (Bool, String?) {
        if let status = json["status"] as? Int {
            print(status)
        }
        return (true, nil)
    }
    
    private func parsePagination(json : Dictionary<String, Any>) -> PaginationModel {
        let page = json["page"] as! Int
        let totalPageCount = json["totalPageCount"] as! Int
        let pagination = PaginationModel(page: page, count: totalPageCount)
        return pagination
    }
    
    private func parseManufactures(json : Dictionary<String, Any>) -> [Manufacturer] {
        var manufacturers = [Manufacturer]()
        if let data = json["wkda"] as! Dictionary<String, Any>! {
            for manufacturer in data {
                let manufacturerModel = Manufacturer(idValue: manufacturer.key, name: manufacturer.value as! String)
                manufacturers.append(manufacturerModel)
            }
        }
        manufacturers.sort { (m1, m2) -> Bool in
            return m1.name.compare(m2.name) == .orderedAscending
        }
        return manufacturers
    }
    
    private func parseCarModels(json: Dictionary<String, Any>) -> [String]? {
        
        if let data = json["wkda"] as! Dictionary<String, Any>! {
            let models: [String] = Array(data.keys.sorted())            
            return models
        }
        return nil
    }

}
