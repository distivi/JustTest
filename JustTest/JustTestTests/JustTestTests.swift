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
    
    // I Love Volkswagen :-)
    let manufacturerIdVW = "905"
    let manufacturerName = "let manufacturer"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: - API
    
    func testApiGetManufacturersList() {
        runAsyncTest(description: "API: Get Manufacturers List") { (expectation) -> (Void) in
            
            Engine.sharedInstance.apiMamanger.getManufacturersList(withPage: 0, pageSize: 15) { (json, error) -> (Void) in
                XCTAssertNotNil(json)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }
    
    func testApiGetModelTypes() {
        runAsyncTest(description: "API: Get Ford types") { (expectation) -> (Void) in
            Engine.sharedInstance.apiMamanger.getModelTypes(withManufacturerId: self.manufacturerIdVW, page: 0, pageSize: 15, callback: { (json, error) -> (Void) in
                XCTAssertNotNil(json)
                XCTAssertNil(error)
                expectation.fulfill()
            })
        }
    }
    
    //MARK: - Data
    
    func testDataGetManufacturersList(){
        runAsyncTest(description: "DATA: Get Manufacturers List") { (expectation) -> (Void) in
            let pagination = PaginationModel()
            Engine.sharedInstance.dataManager.getManufacturer(with: pagination, callback: { (newPagination, manufacturers, error) -> (Void) in
                XCTAssertNotNil(newPagination)
                XCTAssertNotNil(manufacturers)
                XCTAssertNil(error)
                
                XCTAssertEqual(pagination.page, newPagination!.page)
                XCTAssert(manufacturers!.count > 0)
                
                XCTAssertNotNil(manufacturers!.first?.name)
                XCTAssertNotNil(manufacturers!.first?.manufacturerID)
                XCTAssertEqual(manufacturers!.first?.name, "Abarth")
                XCTAssert(manufacturers!.first?.modelTypes.count == 0)
                
                expectation.fulfill()
            })
        }
    }
    
    func testDataGetModelTypes() {
        runAsyncTest(description: "DATA: Get VW Model types") { (expectation) -> (Void) in
            let pagination = PaginationModel()
            let manufacturer = Manufacturer(idValue: self.manufacturerIdVW, name: self.manufacturerName)
            
            Engine.sharedInstance.dataManager.getModelTypesFor(manufacturer: manufacturer,
                                                               pagination: pagination,
                                                               callback:
                { (newPagination, modelTypes, error) -> (Void) in
                    XCTAssertNotNil(newPagination)
                    XCTAssertNotNil(modelTypes)
                    XCTAssertNil(error)
                    
                    XCTAssertEqual(pagination.page, newPagination!.page)
                    XCTAssert(modelTypes!.count > 0)
                    
                    XCTAssertNotNil(modelTypes!.first)
                    XCTAssertEqual(modelTypes!.first, "Amarok")
                    
                    expectation.fulfill()
            })
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

