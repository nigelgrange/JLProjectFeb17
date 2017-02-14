//
//  ViewController.swift
//  JLProjectFeb17
//
//  Created by Nigel Grange on 10/02/2017.
//  Copyright © 2017 Nigel Grange. All rights reserved.
//

import UIKit

struct CollectionViewConstants {
    static let ReuseIdentifier = "ProductOverviewCell"
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!

    var products : [ProductOverview]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.register(UINib.init(nibName: "ProductOverviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CollectionViewConstants.ReuseIdentifier)
        loadProductOverview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadProductOverview() {
        let testProductsResource = Bundle(for: type(of: self)).url(forResource: "testProducts", withExtension: "json")
        do {
            let staticData = try Data(contentsOf: testProductsResource!)
            let decoder = ProductOverviewJSONDecoder();
            products = decoder.decodeJSON(json: staticData)
            print("Decoded \(self.products?.count) products")
        } catch let error as NSError {
            print("Error loading test resource: \(error)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (products != nil) ? (products?.count)! : 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewConstants.ReuseIdentifier, for: indexPath) as! ProductOverviewCollectionViewCell
        if let product = products?[indexPath.row] {
            cell.configureWithProductOverview(product: product)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let product = products?[indexPath.row] {
            performSegue(withIdentifier: "presentDetailView", sender: product)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let navController = segue.destination as! UINavigationController
        let productDetailView = navController.viewControllers.first as! ProductDetailViewController
        productDetailView.productOverview = sender as! ProductOverview!
    }

}

