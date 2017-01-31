//
//  ModelTypesScreenModel.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/30/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import Foundation

class ModelTypesScreenModel: NSObject, BaseTableViewModelProtocol {
    
    internal var manufacturer: Manufacturer
    var pagination: PaginationModel = PaginationModel()
    
    var elementsCount: Int {
        get {
            return self.manufacturer.modelTypes.count
        }
    }
    
    var navigationTitle: String? {
        get {
            return manufacturer.name
        }
    }    
    
    init(manufacturer: Manufacturer) {
        self.manufacturer = manufacturer
        super.init()
    }
    
    func loadMoreData(_ completition: @escaping (Bool, Error?) -> (Void)) {
        if self.isCanLoadMore == false {
            completition(false,nil)
        }
        
        Engine.sharedInstance.dataManager.getModelTypesFor(manufacturer: self.manufacturer,
                                                           pagination: self.pagination)
        { (optNewPagination, optModelType, optError) -> (Void) in
            if let newPagination = optNewPagination, let modelTypes = optModelType {
                self.pagination = newPagination
                
                if newPagination.page == 0 && self.manufacturer.modelTypes.count > 0 {
                    // remove all elemenent in case when we refresh all data
                    self.manufacturer.modelTypes.removeAll()
                }
                
                self.pagination.page += 1
                self.manufacturer.modelTypes.append(contentsOf: modelTypes)
            } else if let error = optError {
                completition(false,error)
                return
            }
            completition(false,nil)
        }
    }
    
    func elementFor(_ indexPath: IndexPath) -> AnyObject {
        return self.manufacturer.modelTypes[indexPath.row] as AnyObject
    }
    
    func alertMessageFor(_ indexPath: IndexPath) -> String {
        let modelType = self.manufacturer.modelTypes[indexPath.row]
        let message = "\(manufacturer.name!) \(modelType)"
        return message        
    }

}
