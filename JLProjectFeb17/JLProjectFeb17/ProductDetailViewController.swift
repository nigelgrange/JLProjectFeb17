//
//  ProductDetailViewController.swift
//  JLProjectFeb17
//
//  Created by Nigel Grange on 14/02/2017.
//  Copyright © 2017 Nigel Grange. All rights reserved.
//

import UIKit
import GONMarkupParser

struct ProductDetailLayout {
    static let ProductDetailSideViewWidth : CGFloat = 380.0
}

class ProductDetailViewController: UIViewController {

    var productOverview : ProductOverview!
    var productDetail : ProductDetail!
    var tableDataSource : ProductDetailTableDataSource!
    var sideTableDataSource : ProductDetailTableDataSource!
    
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sideTableView: UITableView!
    @IBOutlet weak var sideViewWidthConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells(tableView: tableView)
        registerCells(tableView: sideTableView)
        
        // Do any additional setup after loading the view.
        if (productOverview != nil) {
            self.navigationItem.title = productOverview.title
            loadContent()
        }
    }
    

    override func viewDidLayoutSubviews() {
        sideViewWidthConstraint.constant = view.bounds.size.width > view.bounds.size.height ? ProductDetailLayout.ProductDetailSideViewWidth : 0.0
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
        
        let api = ProductAPI()
        api.retrieveProductDetail(productID: productOverview.productId, success: { (productDetail : ProductDetail?) in
            self.productDetail = productDetail
            DispatchQueue.main.async {
                self.presentDetailContent();
            }
        }) { (error : Error?) in
            DispatchQueue.main.async(execute: {
                let alert = UIAlertController.init(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(self, animated: true, completion: nil)
            })
        }

    }
    
    func sectionsForOrientation(isLandscape : Bool) -> [ProductTableSectionType] {
        if (isLandscape) {
            return [ProductTableSectionType.ProductTableSectionSlideshow,
                    ProductTableSectionType.ProductTableSectionText,
                    ProductTableSectionType.ProductTableSectionFeature]
        } else {
            return [ProductTableSectionType.ProductTableSectionSlideshow,
             ProductTableSectionType.ProductTableSectionPrice,
             ProductTableSectionType.ProductTableSectionText,
             ProductTableSectionType.ProductTableSectionFeature]
        }
    }
    
    func presentDetailContent() {
        tableDataSource = ProductDetailTableDataSource(productDetail: productDetail, sections:sectionsForOrientation(isLandscape: view.bounds.size.width > view.bounds.size.height))
        
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
        
        tableView.reloadData()
        sideTableView.reloadData()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            self.view.layoutIfNeeded()
        }) { (context) in
            if (self.productDetail != nil) {
                self.presentDetailContent()
            }
        }
        
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
