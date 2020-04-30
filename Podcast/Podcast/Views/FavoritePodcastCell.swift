  //
//  FavoritePodcastCell.swift
//   
//
//  Created by Jaycell on 4/30/20.
//  Copyright © 2020 Jaycell. All rights reserved.
//

import UIKit

  class FavoritePodcastCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  }
