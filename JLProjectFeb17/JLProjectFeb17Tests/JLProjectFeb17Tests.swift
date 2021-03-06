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
    

    func testJSONDecodeValidData() {
        let testProductsResource = Bundle(for: type(of: self)).url(forResource: "testProducts", withExtension: "json")
        do {
        let staticData = try Data(contentsOf: testProductsResource!)
            let decoder = ProductOverviewJSONDecoder();
            let productOverviewList = decoder.decodeJSON(json: staticData)
            print("Decoded \(productOverviewList.count) products")
            assert(productOverviewList.count == 20, "Error: Invalid number of products decoded")
        } catch let error as NSError {
            print("Error loading test resource: \(error)")
        }
    }

    func testJSONDecodeNonJSONData() {
        let testProductsResource = Bundle(for: type(of: self)).url(forResource: "testProductsInvalid1", withExtension: "json")
        do {
            let staticData = try Data(contentsOf: testProductsResource!)
            let decoder = ProductOverviewJSONDecoder();
            let productOverviewList = decoder.decodeJSON(json: staticData)
            print("Decoded \(productOverviewList.count) products")
            assert(productOverviewList.count == 0, "Error: Invalid number of products decoded")
        } catch let error as NSError {
            print("Error loading test resource: \(error)")
        }
    }
    
    func testJSONDecodeNoProductsJSONData() {
        let testProductsResource = Bundle(for: type(of: self)).url(forResource: "testProductsInvalid2", withExtension: "json")
        do {
            let staticData = try Data(contentsOf: testProductsResource!)
            let decoder = ProductOverviewJSONDecoder();
            let productOverviewList = decoder.decodeJSON(json: staticData)
            print("Decoded \(productOverviewList.count) products")
            assert(productOverviewList.count == 0, "Error: Invalid number of products decoded")
        } catch let error as NSError {
            print("Error loading test resource: \(error)")
        }
    }
    
    func testJSONDecodeInvalidProductsJSONData() {
        let testProductsResource = Bundle(for: type(of: self)).url(forResource: "testProductsInvalid3", withExtension: "json")
        do {
            let staticData = try Data(contentsOf: testProductsResource!)
            let decoder = ProductOverviewJSONDecoder();
            let productOverviewList = decoder.decodeJSON(json: staticData)
            print("Decoded \(productOverviewList.count) products")
            assert(productOverviewList.count == 0, "Error: Invalid number of products decoded")
        } catch let error as NSError {
            print("Error loading test resource: \(error)")
        }
    }
    
    
    func testJSONDecodeProductDetail() {
        let testProductsResource = Bundle(for: type(of: self)).url(forResource: "testProductDetail", withExtension: "json")
        do {
            let staticData = try Data(contentsOf: testProductsResource!)
            let productDetailDict = try JSONSerialization.jsonObject(with: staticData, options: []) as! [String:Any]
            
            let detail = ProductDetail(values: productDetailDict)
            assert(detail?.productId == "1913470", "Invalid Product ID")
            assert(detail?.priceNow == "499.00", "Invalid Price")
            assert(detail?.title == "Bosch SMV53M40GB Fully Integrated Dishwasher", "Invalid Title")
            assert((detail?.productInformation.characters.count)! > 0, "Invalid Product Information")
            assert(detail?.specialOffer != nil && detail?.specialOffer?.characters.count == 0, "Invalid special offer")
            assert((detail?.imageUrls.count)! > 0,"Invalid image urls")
            assert((detail?.includedServices.count)! > 0, "Invalid Guarantee information")
            assert((detail?.features.count)! > 0,"Invalid feature list")

        } catch let error as NSError {
            print("Error loading test resource: \(error)")
        }
    }
    
    
    
}
