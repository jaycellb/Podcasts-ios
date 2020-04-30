//
//  Podcast.swift
//  Podcast
//
//  Created by Jaycell on 18/08/2019.
//  Copyright © 2019 Jaycell. All rights reserved.
//

import Foundation

class Podcast: NSObject, Decodable, NSCoding {
    func encode(with aCoder: NSCoder) {
        print("Trying to transform Podcast into Data")
        aCoder.encode( trackName ?? "", forKey: "trackNameKey")
        aCoder.encode( artistName ?? "", forKey: "artistNameKey")
        aCoder.encode( artworkUrl600 ?? "", forKey: "artworkNameKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("Trying to tranform Data into Podcast")
        self.trackName = aDecoder.decodeObject(forKey: "trackNameKey") as? String
        self.artistName = aDecoder.decodeObject(forKey: "artistNameKey") as? String
        self.artworkUrl600 = aDecoder.decodeObject(forKey: "artworkNameKey") as? String
    }
    
    var trackName: String?
    var artistName: String?
    var artworkUrl600: String?
    var trackCount: Int?
    var feedUrl: String?
     
}
