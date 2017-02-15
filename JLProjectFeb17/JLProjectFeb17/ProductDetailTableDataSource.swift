//
//  ProductDetailTableDataSource.swift
//  JLProjectFeb17
//
//  Created by Nigel Grange on 15/02/2017.
//  Copyright © 2017 Nigel Grange. All rights reserved.
//

import UIKit
import GONMarkupParser

struct ProductTableViewConstants {
    static let SlideshowReuseIdentifier : String = "SlideshowCell"
    static let ProductPriceReuseIdentifier : String = "PriceCell"
    static let TextReuseIdentifier : String = "TextCell"
    static let FeatureReuseIdentifier : String = "FeatureCell"
}


enum ProductTableSectionType {
    case ProductTableSectionSlideshow
    case ProductTableSectionPrice
    case ProductTableSectionText
    case ProductTableSectionFeature
}

class ProductDetailTableDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let productDetail : ProductDetail
    var sections : [ProductTableSectionType]
    var parsedProductDescription : NSAttributedString?
    var productDescriptionBounds : CGSize = CGSize(width: 0.0, height: 0.0)
    
    
    init(productDetail : ProductDetail, sections : [ProductTableSectionType]) {
        self.productDetail = productDetail
        self.sections = sections
    }

    func sectionTypeForIndex(section: Int) -> ProductTableSectionType {
        assert(section < sections.count, "Invalid section index")
        return sections[section]
    }
    
    func reuseIdentifierForSectionType(type : ProductTableSectionType) -> String {
        switch (type) {
        case .ProductTableSectionSlideshow:
            return ProductTableViewConstants.SlideshowReuseIdentifier
        case .ProductTableSectionPrice:
            return ProductTableViewConstants.ProductPriceReuseIdentifier
        case .ProductTableSectionText:
            return ProductTableViewConstants.TextReuseIdentifier
        case .ProductTableSectionFeature:
            return ProductTableViewConstants.FeatureReuseIdentifier
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sectionTypeForIndex(section: section)
        switch (sectionType) {
        case .ProductTableSectionSlideshow:
            return 1
        case .ProductTableSectionPrice:
            return 1
        case .ProductTableSectionText:
            return 2
        case .ProductTableSectionFeature:
            return productDetail.features.count
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sectionTypeForIndex(section: indexPath.section)
        let reuseIdentifier = reuseIdentifierForSectionType(type: sectionType)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier);
        
        switch (sectionType) {
            
        case .ProductTableSectionSlideshow:
            let slideshowCell = cell as! SlideshowTableViewCell
            slideshowCell.configureWithImages(imageUrls: productDetail.imageUrls)
        case .ProductTableSectionPrice:
            let priceCell = cell as! ProductDetailPriceAndGuaranteeTableViewCell
            priceCell.configureWithProduct(productDetail: productDetail)
        case .ProductTableSectionText:
            let textCell = cell as! ProductTextTableViewCell
            switch(indexPath.row) {
            case 0:
                if (parsedProductDescription != nil) {
                    textCell.configureWithAttributedString(string: parsedProductDescription!)
                }
            case 1:
                textCell.configureWithText(text: "Product Code: "+productDetail.productId)
            default:
                textCell.configureWithText(text: "")
            }
            
        case .ProductTableSectionFeature:
            let featureCell = cell as! ProductFeatureTableViewCell
            let features = productDetail.features
            featureCell.configureWithFeature(values: features[indexPath.row])
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = sectionTypeForIndex(section: section)
        let label = UILabel.init()
        switch (sectionType) {
        case .ProductTableSectionText:
            label.text = " Product information"
        case .ProductTableSectionFeature:
            label.text = " Product specification"
        default:
            label.text = ""
        }
        
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title3)
        label.backgroundColor = UIColor.white
        return label
        
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = sectionTypeForIndex(section: indexPath.section)
        switch (sectionType) {
        case .ProductTableSectionSlideshow:
            return 300.0
        case .ProductTableSectionPrice:
            return 120.0
        case .ProductTableSectionText:
            if (indexPath.row == 0) {
                return productDescriptionBounds.width
            } else {
                return 44.0
            }
        default:
            return 44.0
        }
    }
    
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = sectionTypeForIndex(section: section)
        switch (sectionType) {
        case .ProductTableSectionSlideshow:
            return 0.0
        case .ProductTableSectionPrice:
            return 0.0
        default:
            return 32.0
        }
    }

}
