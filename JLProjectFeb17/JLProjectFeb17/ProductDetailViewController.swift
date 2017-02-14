//
//  ProductDetailViewController.swift
//  JLProjectFeb17
//
//  Created by Nigel Grange on 14/02/2017.
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

class ProductDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var productOverview : ProductOverview!
    var productDetail : ProductDetail!
    
    var parsedProductDescription : NSAttributedString?
    
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib.init(nibName: "SlideshowTableViewCell", bundle: nil), forCellReuseIdentifier: ProductTableViewConstants.SlideshowReuseIdentifier)
        tableView.register(UINib.init(nibName: "ProductDetailPriceAndGuaranteeTableViewCell", bundle: nil), forCellReuseIdentifier: ProductTableViewConstants.ProductPriceReuseIdentifier)
        tableView.register(UINib.init(nibName: "ProductTextTableViewCell", bundle: nil), forCellReuseIdentifier: ProductTableViewConstants.TextReuseIdentifier)
        tableView.register(UINib.init(nibName: "ProductFeatureTableViewCell", bundle: nil), forCellReuseIdentifier: ProductTableViewConstants.FeatureReuseIdentifier)
        
        
        
        
        
        // Do any additional setup after loading the view.
        if (productOverview != nil) {
            self.navigationItem.title = productOverview.title
            loadContent()
            presentDetailContent()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func loadContent() {
        let testProductsResource = Bundle(for: type(of: self)).url(forResource: "testProductDetail", withExtension: "json")
        do {
            let staticData = try Data(contentsOf: testProductsResource!)
            let productDetailDict = try JSONSerialization.jsonObject(with: staticData, options: []) as! [String:Any]
            
            productDetail = ProductDetail(values: productDetailDict)
            
        } catch let error as NSError {
            print("Error loading test resource: \(error)")
        }
    }

    
    func presentDetailContent() {
        let parser = GONMarkupParser.default()
        parsedProductDescription = parser?.attributedString(from: productDetail!.productInformation)
    }

    func sectionTypeForIndex(section: Int) -> ProductTableSectionType {
        switch (section) {
        case 0:
            return ProductTableSectionType.ProductTableSectionSlideshow
        case 1:
            return ProductTableSectionType.ProductTableSectionPrice
        case 2:
            return ProductTableSectionType.ProductTableSectionText
        case 3:
            return ProductTableSectionType.ProductTableSectionFeature
        default:
            assert(true, "Invalid section index")
        }
        return ProductTableSectionType.ProductTableSectionText
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
            return productDetail != nil ? productDetail!.features.count : 0
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sectionTypeForIndex(section: indexPath.section)
        let reuseIdentifier = reuseIdentifierForSectionType(type: sectionType)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier);
        
        switch (sectionType) {
            
        case .ProductTableSectionSlideshow:
            let slideshowCell = cell as! SlideshowTableViewCell
            slideshowCell.configureWithImages(imageUrls: productDetail!.imageUrls)
        case .ProductTableSectionText:
            let textCell = cell as! ProductTextTableViewCell
            switch(indexPath.row) {
            case 0:
                textCell.configureWithAttributedString(string: parsedProductDescription!)
            case 1:
                textCell.configureWithText(text: "Product Code: "+productDetail!.productId)
            default:
                textCell.configureWithText(text: "")
            }
            
            case .ProductTableSectionFeature:
                let featureCell = cell as! ProductFeatureTableViewCell
                let features = productDetail!.features
                featureCell.configureWithFeature(values: features[indexPath.row])
        default:
            print("Noop")
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
                if (parsedProductDescription != nil) {
                    return (parsedProductDescription?.boundingRect(with: CGSize(width: self.tableView.frame.size.width - 16, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil).size.height)! + 120.0
                }
                return 128.0
            }
            return 44.0
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
