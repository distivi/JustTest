//
//  ManufacturerTableViewCellModel.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/30/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import Foundation

class ManufacturerTableViewCellModel: NSObject {
    
    var manufacturer: Manufacturer
    
    init(manufacturer: Manufacturer) {
        self.manufacturer = manufacturer
    }
    
    var title: String {
        get {
            return self.manufacturer.name
        }
    }

}
