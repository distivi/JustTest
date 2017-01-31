//
//  PaginationModel.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/26/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import Foundation

class PaginationModel: NSObject {
    let pageSize = 15
    var page = 0
    var totalPageCount = 1 // always should be at least one page to load
    
    override init() {
        super.init()
    }
    
    init(page: Int, count: Int) {
        super.init()
        self.page = page
        self.totalPageCount = count
    }
    
    var isCanLoad: Bool {
        if page < totalPageCount {
            return true
        }
        return false
    }
}
