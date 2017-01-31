//
//  CarModelViewModel.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/30/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import UIKit

class CarModelViewModel: NSObject {
    var modelType: String
    
    init(modelType: String) {
        self.modelType = modelType
    }
    
    var title: String {
        get {
            return self.modelType
        }
    }

}
