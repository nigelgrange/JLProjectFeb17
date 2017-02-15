//
//  ProductFeatureTableViewCell.swift
//  JLProjectFeb17
//
//  Created by Nigel Grange on 14/02/2017.
//  Copyright © 2017 Nigel Grange. All rights reserved.
//

import UIKit

class ProductFeatureTableViewCell: UITableViewCell {

    @IBOutlet weak var featureValueLabel: UILabel!
    @IBOutlet weak var featureNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWithFeature(values : (String, String)) {
        featureNameLabel.text = values.0
        featureValueLabel.text = values.1
    }
    
}
