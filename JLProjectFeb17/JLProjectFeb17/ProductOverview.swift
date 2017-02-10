//
//  ProductOverview.swift
//  JLProjectFeb17
//
//  Created by Nigel Grange on 10/02/2017.
//  Copyright © 2017 Nigel Grange. All rights reserved.
//

import UIKit

class ProductOverview: NSObject {
    var productId : String
    var priceNow : String
    var title : String
    var imageUrl : String
    
    init?(values : Dictionary<String, Any>) {
        let productId = values["productId"] as? String
        let priceDict  =  values["price"] as? Dictionary<String, Any>
        let priceNowString = priceDict != nil ? priceDict?["now"] as? String : nil
        let title = values["title"] as? String
        let imageUrl = values["image"] as? String
    
        if (productId != nil &&
            priceNowString != nil &&
            title != nil &&
            imageUrl != nil) {
            self.productId = productId!
            self.priceNow = priceNowString!
            self.title = title!
            self.imageUrl = imageUrl!
            
        }
        else {
            return nil
        }
    }
}
