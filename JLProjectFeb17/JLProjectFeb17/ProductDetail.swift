//
//  ProductDetail.swift
//  JLProjectFeb17
//
//  Created by Nigel Grange on 14/02/2017.
//  Copyright © 2017 Nigel Grange. All rights reserved.
//

import UIKit

class ProductDetail: NSObject {
    var productId : String
    var priceNow : String
    var title : String
    var productInformation : String
    var specialOffer : String?
    var includedServices : [String]
    var imageUrls : [String]
    var features : [(String,String)]

    init?(values : Dictionary<String, Any>) {
        let productId = values["productId"] as? String
        let priceDict  =  values["price"] as? [String : Any]
        let priceNowString = priceDict != nil ? priceDict?["now"] as? String : nil
        let title = values["title"] as? String
        
        let detailsDict = values["details"] as? [String : Any]
        let productInformation = detailsDict != nil ? detailsDict?["productInformation"] as? String : nil
        
        specialOffer = values["displaySpecialOffer"] as? String
        
        let mediaDict = values["media"] as? [String: Any]
        let mediaImages = mediaDict != nil ? mediaDict?["images"] as? [String : Any] : nil
        let mediaUrls = mediaImages != nil ? mediaImages?["urls"] as? [String] : nil

        let additionalServicesDict = values["additionalServices"] as? [String : Any]
        let includedServices = additionalServicesDict != nil ? additionalServicesDict?["includedServices"] as? [String] : nil
        
        features = [(String,String)]()
        
        let featuresDict = detailsDict?["features"] as? [[String : Any]]
        let featureGroup = featuresDict?.first
        let attributesArray = featureGroup?["attributes"] as? [[String : Any]]
        
        if (attributesArray != nil) {
            for attribute in attributesArray! {
                let name = attribute["name"] as? String
                let value = attribute["value"] as? String
                if (name != nil && value != nil) {
                    features.append((name!,value!))
                }
            }
        }
        
        if (productId != nil &&
            priceNowString != nil &&
            title != nil &&
            productInformation != nil &&
            mediaUrls != nil &&
            includedServices != nil) {
            self.productId = productId!
            self.priceNow = priceNowString!
            self.title = title!
            self.productInformation = productInformation!
            self.imageUrls = mediaUrls!
            self.includedServices = includedServices!
            
        }
        else {
            return nil
        }
    }
}
