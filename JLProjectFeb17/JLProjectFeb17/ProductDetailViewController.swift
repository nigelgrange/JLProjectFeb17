//
//  ProductDetailViewController.swift
//  JLProjectFeb17
//
//  Created by Nigel Grange on 14/02/2017.
//  Copyright © 2017 Nigel Grange. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    var productOverview : ProductOverview!
    var productDetail : ProductDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
    }


}
