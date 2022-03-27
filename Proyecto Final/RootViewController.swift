//
//  RootViewController.swift
//  Proyecto Final
//
//  Created by Himar Muñoz García on 15/3/22.
//

import UIKit

class RootViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create and configure Launches tab
        let launchesTab = UINavigationController(rootViewController: ListViewController())
        
        launchesTab.navigationBar.prefersLargeTitles = true
        launchesTab.navigationItem.title = "Launches"

        let launchesTabBarItem = UITabBarItem(title: "Launches", image: UIImage(systemName: "bolt"), selectedImage: UIImage(systemName: "bolt.fill"))
        
        // Create and configure Favorites tab
        let favoritesTab = UINavigationController(rootViewController: FavoritesViewController())
        
        favoritesTab.navigationBar.prefersLargeTitles = true
        favoritesTab.navigationItem.title = "Favorites"

        let favoritesTabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        
        launchesTab.tabBarItem = launchesTabBarItem
        favoritesTab.tabBarItem = favoritesTabBarItem
        
        // Set both tabs
        self.viewControllers = [launchesTab, favoritesTab]
    }
}
