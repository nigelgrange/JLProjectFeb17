//
//  ProductOverviewCollectionViewCell.swift
//  JLProjectFeb17
//
//  Created by Nigel Grange on 14/02/2017.
//  Copyright © 2017 Nigel Grange. All rights reserved.
//

import UIKit
import Haneke
import GONMarkupParser

class ProductOverviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWithProductOverview(product : ProductOverview) {
        let parser = GONMarkupParser.default()
        let markup = product.title+"\n<b>£"+product.priceNow+"</>"
        descriptionLabel.attributedText = parser?.attributedString(from: markup)
        image.hnk_setImage(from: URL(string: "https:"+product.imageUrl))
    }

}
