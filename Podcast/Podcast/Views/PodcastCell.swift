//
//  PodcastCell.swift
//  Podcast
//
//  Created by Jaycell on 28/08/2019.
//  Copyright © 2019 Jaycell. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {
    
    
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    var podcast: Podcast! {
        didSet {
        trackNameLabel.text = podcast.trackName
        artistNameLabel.text = podcast.artistName
        }
    
    }
    
}

