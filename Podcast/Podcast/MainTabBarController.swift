//
//  MainTabBarController.swift
//  Podcast
//
//  Created by Jaycell on 12/08/2019.
//  Copyright © 2019 Jaycell. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let favoritesController = ViewController()
        favoritesController.tabBarItem.title = "Favorites"
        favoritesController.tabBarItem.image = #imageLiteral(resourceName: "favorites")
        
        
        let searchNavController = UINavigationController(rootViewController: ViewController())
        searchNavController.tabBarItem.title = "Search"
        searchNavController.tabBarItem.image = #imageLiteral(resourceName: "search")
        
        
        viewControllers = [
            favoritesController,
            searchNavController
        ]
    }
}
