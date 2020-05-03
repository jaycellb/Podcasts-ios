  //
//  FavoritePodcastCell.swift
//   
//
//  Created by Jaycell on 4/30/20.
//  Copyright © 2020 Jaycell. All rights reserved.
//

import UIKit

  class FavoritePodcastCell: UICollectionViewCell {
    
    var podcast: Podcast! {
        didSet {
            nameLabel.text = podcast.trackName
            artistNameLabel.text = podcast.artistName
            
            let url = URL(string: podcast.artworkUrl600 ?? "")
            imageView.sd_setImage(with: url )
        }
    }
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "appicon"))
    let nameLabel = UILabel()
    let artistNameLabel = UILabel()
    
    fileprivate func stylizedUI() {
        nameLabel.text = "Podcast Name"
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        artistNameLabel.text = "Artist Name"
        artistNameLabel.font = UIFont.systemFont(ofSize: 14)
        artistNameLabel.textColor = .lightGray
    }
    
    fileprivate func setupViews() {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stylizedUI()
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  }
