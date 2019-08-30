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
            
        episodeCountLabel.text = "\(podcast.trackCount ?? 0) Episodes"
            
        print("Loading image with URL:", podcast.artworkUrl600 ?? "")
            
        guard let url = URL(string: podcast.artworkUrl600 ?? "") else {
                return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            print("Finished downloading data:", data)
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.podcastImageView.image = UIImage(data: data)
            }
        }.resume()
    
    }
    
}
}
