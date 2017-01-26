//
//  JustTestTests.swift
//  JustTestTests
//
//  Created by Stanislav Dymedyuk on 1/26/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import XCTest
@testable import JustTest

class JustTestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: - API
    
    func testApiGetCarsList() {
        runAsyncTest(description: "API: Get Cars List") { (expectation) -> (Void) in
            
            Engine.sharedInstance.apiMamanger.getCarsList(withPage: 0, pageSize: 15) { (json, error) -> (Void) in
                XCTAssertNotNil(json)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }
    
    func testApiGetCarTypes() {
        runAsyncTest(description: "API: Get Ford types") { (expectation) -> (Void) in
            let fordId = 285
            Engine.sharedInstance.apiMamanger.getCarType(withCarId: fordId, page: 0, pageSize: 15, callback: { (json, error) -> (Void) in
                XCTAssertNotNil(json)
                XCTAssertNil(error)
                expectation.fulfill()
            })
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK: - Helpers
    
    
    func runAsyncTest(description: String, testCode: @escaping (XCTestExpectation) -> (Void))  {
        let asyncExpectation = expectation(description: description)
        
        testCode(asyncExpectation)
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
}
