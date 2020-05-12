//
//  Episode.swift
//  Podcast
//
//  Created by Jaycell on 07/09/2019.
//  Copyright © 2019 Jaycell. All rights reserved.
//

import Foundation
import FeedKit

struct Episode: Encodable {
    let title: String
    let pubDate: Date
    let description: String
    let author: String
    let streamUrl: String
    
    var imageUrl: String?
    
    init(feedItem: RSSFeedItem) {
        
        self.streamUrl = feedItem.enclosure?.attributes?.url ?? "" 
        
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.iTunes?.iTunesSubtitle ?? feedItem.description ?? ""
        self.imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href
        self.author = feedItem.iTunes?.iTunesAuthor ?? ""
        
    }
}
