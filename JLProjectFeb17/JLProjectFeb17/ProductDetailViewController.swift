//
//  ProductDetailViewController.swift
//  JLProjectFeb17
//
//  Created by Nigel Grange on 14/02/2017.
//  Copyright © 2017 Nigel Grange. All rights reserved.
//

import UIKit
import GONMarkupParser


class ProductDetailViewController: UIViewController {

    var productOverview : ProductOverview!
    var productDetail : ProductDetail!
    var tableDataSource : ProductDetailTableDataSource!
    var sideTableDataSource : ProductDetailTableDataSource!
    
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sideTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells(tableView: tableView)
        registerCells(tableView: sideTableView)
        
        // Do any additional setup after loading the view.
        if (productOverview != nil) {
            self.navigationItem.title = productOverview.title
            loadContent()
            presentDetailContent()
        }
    }
    
    func registerCells(tableView: UITableView) {
        tableView.register(UINib.init(nibName: "SlideshowTableViewCell", bundle: nil), forCellReuseIdentifier: ProductTableViewConstants.SlideshowReuseIdentifier)
        tableView.register(UINib.init(nibName: "ProductDetailPriceAndGuaranteeTableViewCell", bundle: nil), forCellReuseIdentifier: ProductTableViewConstants.ProductPriceReuseIdentifier)
        tableView.register(UINib.init(nibName: "ProductTextTableViewCell", bundle: nil), forCellReuseIdentifier: ProductTableViewConstants.TextReuseIdentifier)
        tableView.register(UINib.init(nibName: "ProductFeatureTableViewCell", bundle: nil), forCellReuseIdentifier: ProductTableViewConstants.FeatureReuseIdentifier)
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
        tableDataSource = ProductDetailTableDataSource(productDetail: productDetail, sections:[ProductTableSectionType.ProductTableSectionSlideshow,
                                                                                               ProductTableSectionType.ProductTableSectionPrice,
                                                                                               ProductTableSectionType.ProductTableSectionText,
                                                                                               ProductTableSectionType.ProductTableSectionFeature])
        
        sideTableDataSource = ProductDetailTableDataSource(productDetail: productDetail, sections:[ProductTableSectionType.ProductTableSectionPrice])
        
        
        let parser = GONMarkupParser.default()
        let parsedDescription = parser?.attributedString(from: productDetail!.productInformation)
        tableDataSource.parsedProductDescription = parsedDescription
        if (parsedDescription != nil) {
            tableDataSource.productDescriptionBounds = (parsedDescription?.boundingRect(with: CGSize(width: self.tableView.frame.size.width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil).size)!
        }

        tableView.dataSource = tableDataSource;
        tableView.delegate = tableDataSource
        
        sideTableView.dataSource = sideTableDataSource
        sideTableView.delegate = sideTableDataSource
    }



}
