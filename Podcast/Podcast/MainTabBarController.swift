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
    
    @objc func minimizePlayerDetails() {
        maximizedTopAnchorConstraint.isActive = false
        
        minimizedTopAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            
        })
    }
    
    @objc func maximizePlayerDetails() {
        print(222)
        
        maximizedTopAnchorConstraint.isActive = true
        maximizedTopAnchorConstraint.constant = 0
        minimizedTopAnchorConstraint.isActive = false
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            
        })
    }
    
    //MARK:- Setup Functions
    let playerDetailsView = PlayerDetailsView.initFromNib()
    
    var maximizedTopAnchorConstraint: NSLayoutConstraint!
    var minimizedTopAnchorConstraint: NSLayoutConstraint!
    
    //Calls PodcastsSearchController to the MainTabBar
    fileprivate func setUpPlayerDetailsView() {
        print("Setting Up PlayerDetailsView")
        
        playerDetailsView.backgroundColor = .red
        
//        playerDetailsView.frame = view.frame
        //use auto layout
//        view.addSubview(playerDetailsView)
        view.insertSubview( playerDetailsView, belowSubview: tabBar)
        
        //enables auto layout
        playerDetailsView.translatesAutoresizingMaskIntoConstraints = false
        
        //set anchors
        
        maximizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)

        maximizedTopAnchorConstraint.isActive = true
        
        minimizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
//        minimizedTopAnchorConstraint.isActive = true
        
        playerDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        playerDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
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
