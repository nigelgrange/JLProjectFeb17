//
//  ProductAPI.swift
//  JLProjectFeb17
//
//  Created by Nigel Grange on 15/02/2017.
//  Copyright © 2017 Nigel Grange. All rights reserved.
//

import UIKit

struct ProductAPIURL {
    static let ProductAPIOverviewURL = "https://api.johnlewis.com/v1/products/search?q=dishwasher&key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb&pageSize=20"
    static let ProductAPIDetailURL = "https://api.johnlewis.com/v1/products/{productId}?key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb"
}

class ProductAPI: NSObject {
    
    func retrieveProductOverview(success: @escaping ([ProductOverview]) -> Void, onError : @escaping (Error?) -> Void) {
        let url = URL(string: ProductAPIURL.ProductAPIOverviewURL)
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data : Data?, _, error : Error?) in
            if (error == nil) {
                let decoder = ProductOverviewJSONDecoder();
                if (data != nil) {
                    let productOverviewList = decoder.decodeJSON(json: data!)
                    success(productOverviewList)
                }
            } else {
                onError(error)
            }
        }
        task.resume()
    }
    
    
    
    func retrieveProductDetail(productID: String, success: @escaping (ProductDetail?) -> Void, onError : @escaping (Error?) -> Void) {
        let urlString = ProductAPIURL.ProductAPIDetailURL.replacingOccurrences(of: "{productId}", with: productID)
        let url = URL(string: urlString)
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data : Data?, _, error : Error?) in
            if (error == nil) {
                do {
                    if (data != nil) {
                        let productDetailDict = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                        let detail = ProductDetail(values: productDetailDict)
                        success(detail)
                    }
                } catch let error  {
                    onError(error)
                }

            } else {
                onError(error)
            }
        }
        task.resume()
        
    }
}
