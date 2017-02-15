//
//  JLProjectFeb17IntegrationTests.swift
//  JLProjectFeb17
//
//  Created by Nigel Grange on 15/02/2017.
//  Copyright © 2017 Nigel Grange. All rights reserved.
//

import XCTest
@testable import JLProjectFeb17

class JLProjectFeb17IntegrationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testRetrieveOverviewFromAPI() {
        let api = ProductAPI()
        
        let networkExpectation = expectation(description: "apiRequest")
        
        api.retrieveProductOverview(success: { (products : [ProductOverview]) in
            networkExpectation.fulfill()
            assert(products.count > 0, "Invalid number of products received")
        }) { (err : Error?) in
            networkExpectation.fulfill()
            assert(true, "Network error: \(err)")
        }
        
        self.waitForExpectations(timeout: 5) { error in
            if (error != nil) {
                print("Error waiting for test to complete: \(error)")
            }
        }
    }
    
    
    func testRetrieveProductDetailFromAPI() {
        let api = ProductAPI()
        
        let networkExpectation = expectation(description: "apiRequest")
        
        api.retrieveProductDetail(productID: "1913470", success: { (productDetail : ProductDetail?) in
            networkExpectation.fulfill()
            assert(productDetail != nil, "Invalid product detail received")
        }) { (err : Error?) in
            networkExpectation.fulfill()
            assert(true, "Network error: \(err)")
        }
 
        self.waitForExpectations(timeout: 5) { error in
            if (error != nil) {
                print("Error waiting for test to complete: \(error)")
            }
        }
    }

}
