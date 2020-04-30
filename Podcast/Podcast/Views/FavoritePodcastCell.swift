  //
//  FavoritePodcastCell.swift
//   
//
//  Created by Jaycell on 4/30/20.
//  Copyright © 2020 Jaycell. All rights reserved.
//

import UIKit

  class FavoritePodcastCell: UICollectionViewCell {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "appicon"))
    let nameLabel = UILabel()
    let artistNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nameLabel.text = "Podcast Name"
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        artistNameLabel.text = "Artist Name"
        artistNameLabel.font = UIFont.systemFont(ofSize: 13)
        artistNameLabel.textColor = .lightGray
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        
        let stackview = UIStackView(arrangedSubviews: [imageView, nameLabel, artistNameLabel])
        
        stackview.axis = .vertical
        // enables auto layout
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackview)
        
        stackview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  }
