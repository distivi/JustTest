//
//  Manufacturer.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/26/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import Foundation

class Manufacturer: NSObject {
    var manufacturerID: String!
    var name: String!
    var modelTypes = [String]()
    
    init(idValue: String, name: String) {
        super.init()
        
        self.manufacturerID = idValue
        self.name = name
    }
}
