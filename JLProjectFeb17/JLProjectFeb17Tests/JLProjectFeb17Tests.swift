//
//  JLProjectFeb17Tests.swift
//  JLProjectFeb17Tests
//
//  Created by Nigel Grange on 10/02/2017.
//  Copyright © 2017 Nigel Grange. All rights reserved.
//

import XCTest
@testable import JLProjectFeb17

class JLProjectFeb17Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testConstuctProductOverviewFromCorrectDictionary() {
        let correctDictionary : Dictionary<String,Any> = ["productId" : "001", "price" : ["now":"123.45"], "title":"Title", "image":"http://test.image"]
        
        let overview = ProductOverview(values: correctDictionary)
        assert(overview?.productId == "001", "Invalid Product ID")
        assert(overview?.priceNow == "123.45", "Invalid Price")
        assert(overview?.title == "Title", "Invalid Title")
        assert(overview?.imageUrl == "http://test.image", "Invalid Image URL")

    }
    
    func testConstructProductOverviewFromInvaldiDictionary() {
        var invalidDictionary : Dictionary<String,Any> = [:]
        assert(ProductOverview(values:invalidDictionary) == nil, "Invalid overview object")
        
        invalidDictionary = ["productId" : "001"]
        assert(ProductOverview(values:invalidDictionary) == nil, "Invalid overview object")
        
        invalidDictionary = ["productId" : "001", "title":"Title"]
        assert(ProductOverview(values:invalidDictionary) == nil, "Invalid overview object")
        
        invalidDictionary = ["productId" : "001", "title":"Title", "image":"http://test.image"]
        assert(ProductOverview(values:invalidDictionary) == nil, "Invalid overview object")
        
        
        invalidDictionary = ["productId" : "001", "title":"Title", "image":"http://test.image","price" : ["was":"123.45"]]
        assert(ProductOverview(values:invalidDictionary) == nil, "Invalid overview object")
        
        invalidDictionary = ["productId" : "001", "title":"Title", "image":"http://test.image","price" : "123.45"]
        assert(ProductOverview(values:invalidDictionary) == nil, "Invalid overview object")
    }
    
    

    
}
