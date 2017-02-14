//
//  ProductTextTableViewCell.swift
//  JLProjectFeb17
//
//  Created by Nigel Grange on 14/02/2017.
//  Copyright © 2017 Nigel Grange. All rights reserved.
//

import UIKit

class ProductTextTableViewCell: UITableViewCell {
    @IBOutlet weak var productTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWithText(text : String) {
        productTextLabel.text = text
    }
    
    func configureWithAttributedString(string: NSAttributedString) {
        productTextLabel.attributedText = string
    }
}
