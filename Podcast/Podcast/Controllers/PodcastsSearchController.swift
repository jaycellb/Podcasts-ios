//
//  PodcastsSearchController.swift
//  Podcast
//
//  Created by Jaycell on 18/08/2019.
//  Copyright © 2019 Jaycell. All rights reserved.
//

import UIKit

class PodcastsSearchController: UITableViewController {
    
    let podcasts = [
        Podcast(name: "Let's Build That App", artistName: "Brian Voong"),
        Podcast(name: "Some Podcast", artistName: "Some Artist"),
    ]
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. register a cell for the tableview
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let podcast = self.podcasts[indexPath.row]
        cell.textLabel?.text = "\(podcast.name)\n\(podcast.artistName)"
        cell.textLabel?.numberOfLines = -1
        cell.imageView?.image = #imageLiteral(resourceName: "appicon")
        
        return cell
    }
}
