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
                
        let api = ProductAPI();
        api.retrieveProductOverview(success: { (products : [ProductOverview]) in
            self.products = products
            
            DispatchQueue.main.async(execute: {
                self.collectionView.reloadData()
            })
            
        }) { (error : Error?) in
            DispatchQueue.main.async(execute: {
                let alert = UIAlertController.init(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(self, animated: true, completion: nil)
            })
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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

