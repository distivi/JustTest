//
//  BaseTableViewModelProtocol.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/30/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import Foundation

protocol BaseTableViewModelProtocol {
    var pagination: PaginationModel {get set}
    var isCanLoadMore: Bool {get}
    var elementsCount: Int {get}
    var navigationTitle: String? {get}
        
    func setPaginationToZero()    
    func loadMoreData(_ completition: @escaping (Bool, Error?) -> (Void))
    func elementFor(_ indexPath: IndexPath) -> AnyObject
    func alertMessageFor(_ indexPath: IndexPath) -> String
}

extension BaseTableViewModelProtocol {
    var isCanLoadMore: Bool {
        get {
            return self.pagination.isCanLoad
        }
    }
    
    func setPaginationToZero() {
        self.pagination.page = 0
    }
    
    func alertMessageFor(_ indexPath: IndexPath) -> String {
        return ""
    }
}

