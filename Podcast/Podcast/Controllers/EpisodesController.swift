//
//  EpisodesController.swift
//  Podcast
//
//  Created by Jaycell on 02/09/2019.
//  Copyright © 2019 Jaycell. All rights reserved.
//

import UIKit
import FeedKit

class EpisodesController: UITableViewController {
    
    var podcast: Podcast? {
        didSet {
            navigationItem.title = podcast?.trackName
            
            fetchEpisodes()
        }
    }
    
    fileprivate func fetchEpisodes() {
        print("Looking for episodes at feed URL:", podcast?.feedUrl ?? "")
        
        guard let feedUrl = podcast?.feedUrl else { return }
        
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        
        guard let url = URL(string: secureFeedUrl) else { return }
        let parser = FeedParser(URL: url)
        parser?.parseAsync(result: { (result) in
            print("Successfully parse feed:", result.isSuccess)
            
            switch result {
            case let .rss(feed):
                var episodes = [Episode]() //blank Episode array
                feed.items?.forEach({ (feedItem) in
                   let episode = Episode(feedItem: feedItem)
                    episodes.append(episode)
                })
                self.episodes = episodes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
            case let .failure(error):
                print("Failed to parse feed:", error)
                break
                
            default:
                print("Found a feed...")
            }
        }) 
    }
    
    fileprivate let cellId = "cellId"
    
    struct Episode {
        let title: String
        let pubDate: Date
        let description: String
        
        init(feedItem: RSSFeedItem) {
            self.title = feedItem.title ?? ""
            self.pubDate = feedItem.pubDate ?? Date()
            self.description = feedItem.description ?? ""
        }
    }
    
    var episodes = [Episode]()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        setupTableView()
    }
    
    //MARK:- Setup TableView
    
    fileprivate func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    //MARK:- UITableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId , for: indexPath)
        let episode = episodes[indexPath.row]
        cell.textLabel?.text = episode.title
        return cell
    }
    
    
}













