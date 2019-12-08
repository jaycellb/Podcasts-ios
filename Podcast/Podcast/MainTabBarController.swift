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
        
        UINavigationBar.appearance().prefersLargeTitles = true
        
        tabBar.tintColor = .purple
        
        setupViewControllers()
        
        setUpPlayerDetailsView()
        
    }
    
    //MARK:- Setup Functions
    //Calls PodcastsSearchController to the MainTabBarController
    
    fileprivate func setUpPlayerDetailsView() {
        print("Setting Up PlayerDetailsView")
        
        let playerDetailsView = PlayerDetailsView.initFromNib()
        playerDetailsView.backgroundColor = .red
        
        playerDetailsView.frame = view.frame
        
        view.addSubview(playerDetailsView)
        
    }
    func setupViewControllers() {
        viewControllers = [
            generateNavigationController(for: PodcastsSearchController(), title: "Search", image: #imageLiteral(resourceName: "search")),
            generateNavigationController(for: ViewController(), title: "Favorites", image: #imageLiteral(resourceName: "favorites")),
            generateNavigationController(for: ViewController(), title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
        ]
    }
    
    //MARK:- Helper Functions
    
    fileprivate func generateNavigationController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
        
    }
}
