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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.register(UINib.init(nibName: "ProductOverviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CollectionViewConstants.ReuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewConstants.ReuseIdentifier, for: indexPath)
        return cell
    }

}

