//
//  ProductOverviewJSONDecoder.swift
//  JLProjectFeb17
//
//  Created by Nigel Grange on 14/02/2017.
//  Copyright © 2017 Nigel Grange. All rights reserved.
//

import UIKit

class ProductOverviewJSONDecoder {
    func decodeJSON(json : Data) -> [ProductOverview] {
        var products = [ProductOverview]();
        do {
        let productList = try JSONSerialization.jsonObject(with: json, options: []) as! [String:Any]
            if let productArray = productList["products"]  as? [[String:Any]] {
                for productDict in productArray {
                    if let product = ProductOverview(values:productDict) {
                        products.append(product)
                    }
                }
            }
        } catch let error as NSError {
            // JSON Deocde errors are caght silently, returnng an empty product array
            print("JSON Decode error parsing product overview: \(error)")
        }
        return products;
    }
}
