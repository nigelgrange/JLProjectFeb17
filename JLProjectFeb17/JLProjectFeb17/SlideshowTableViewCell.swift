//
//  SlideshowTableViewCell.swift
//  JLProjectFeb17
//
//  Created by Nigel Grange on 14/02/2017.
//  Copyright © 2017 Nigel Grange. All rights reserved.
//

import UIKit
import ImageSlideshow

class SlideshowTableViewCell: UITableViewCell {

    @IBOutlet weak var slideshow: ImageSlideshow!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWithImages(imageUrls:[String]) {
        var imageSources = [InputSource]()
        
        for url in imageUrls {
            imageSources.append(KingfisherSource(urlString:"https:"+url)!)
        }
        
        slideshow.pageControlPosition = PageControlPosition.underScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray;
        slideshow.pageControl.pageIndicatorTintColor = UIColor.black;
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFit
        slideshow.setImageInputs(imageSources)
    }
    
}
