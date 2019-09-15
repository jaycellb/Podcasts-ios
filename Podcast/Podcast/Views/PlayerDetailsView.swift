//
//  PlayerDetailsView.swift
//  Podcast
//
//  Created by Jaycell on 16/09/2019.
//  Copyright © 2019 Jaycell. All rights reserved.
//

import UIKit

class PlayerDetailsView: UIView {
   
    @IBAction func handleDismiss(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    @IBOutlet weak var episodeImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    }

