//
//  ProductDetailPriceAndGuaranteeTableViewCell.swift
//  JLProjectFeb17
//
//  Created by Nigel Grange on 14/02/2017.
//  Copyright © 2017 Nigel Grange. All rights reserved.
//

import UIKit
import GONMarkupParser

class ProductDetailPriceAndGuaranteeTableViewCell: UITableViewCell {
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWithProduct(productDetail : ProductDetail) {
        let line1 = "£"+productDetail.priceNow
        let line2 = productDetail.specialOffer != nil ? productDetail.specialOffer! : ""
        let line3 = productDetail.includedServices.joined(separator: "\n")
        
        var markup = "<font size=\"20\"><color value=\"black\">\(line1)</></>"
        if (line2.characters.count > 0) {
            markup.append("\n\n<font size=\"14\"><color value=\"DarkRed\">\(line2)</></>")
        }
        if (line3.characters.count > 0) {
            markup.append("\n\n<font size=\"14\"><color value=\"DarkGreen\">\(line3)</></>\n")
        }
       
        let parser = GONMarkupParser.default()
        priceLabel.attributedText = parser?.attributedString(from: markup)
    }
    
}
