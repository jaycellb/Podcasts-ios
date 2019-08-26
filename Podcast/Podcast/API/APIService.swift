//
//  APIService.swift
//  Podcast
//
//  Created by Jaycell on 26/08/2019.
//  Copyright © 2019 Jaycell. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    //singleton
    static let shared = APIService()
    
    func fetchPodcasts(searchText: String) {
        print("Searching for podcast...")
        
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let err = dataResponse.error {
                print("Failed to contact yahoo.", err)
                return
            }
            
            guard let data = dataResponse.data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self  , from: data)
//                self.podcasts = searchResult.results
//                self.tableView.reloadData()
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
            }
        }
 
    }
    
    struct SearchResults: Decodable {
        let resultCount: Int
        let results: [Podcast]
    }
    
}
