//
//  ManufacturerScreenModel.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/30/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import Foundation

class ManufacturerScreenModel: NSObject, BaseTableViewModelProtocol {
    
    internal var manufactures = [Manufacturer]()
    var pagination: PaginationModel = PaginationModel()
    
    var elementsCount: Int {
        get {
            return self.manufactures.count
        }
    }
    
    var navigationTitle: String? {
        get {
            return NSLocalizedString("Manufacturers", comment: "Manufacturers")
        }
    }
        
    func loadMoreData(_ completition: @escaping (Bool, Error?) -> (Void)) {
        if self.isCanLoadMore == false {
            completition(false,nil)
        }
        
        Engine.sharedInstance.dataManager.getManufacturer(with: pagination) { (optNewPagination, optNewManufactures, optError) -> (Void) in
            if let newPagination = optNewPagination, let newManufactures = optNewManufactures {
                self.pagination = newPagination
                
                if newPagination.page == 0 && self.manufactures.count > 0 {
                    // remove all elemenent in case when we refresh all data
                    self.manufactures.removeAll()
                }
                
                self.pagination.page += 1                
                self.manufactures.append(contentsOf: newManufactures)
                completition(true,nil)
                return
            } else if let error = optError {
                completition(false,error)
                return
            }
            completition(false,nil)
        }
    }
    
    func elementFor(_ indexPath: IndexPath) -> AnyObject {
        return self.manufactures[indexPath.row]
    }
}
