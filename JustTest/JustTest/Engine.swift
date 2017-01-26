//
//  Engine.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/26/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import UIKit

class Engine: NSObject {

    internal static let sharedInstance = Engine()
    
    //MARK: - Common managers
    public let apiMamanger: APIManager = APIManager()
    
    

}
