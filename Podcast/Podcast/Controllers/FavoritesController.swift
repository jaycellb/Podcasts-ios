//
//  FavoritesController.swift
//   
//
//  Created by Jaycell on 4/29/20.
//  Copyright © 2020 Jaycell. All rights reserved.
//

import UIKit

class FavoritesController: UICollectionViewController {
    
    fileprivate let cellId = "cellId"
    
    override func viewDidLoad() {

        
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .blue
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    
    
}
