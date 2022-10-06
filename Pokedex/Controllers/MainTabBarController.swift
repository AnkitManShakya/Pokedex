//
//  ViewController.swift
//  netflix
//
//  Created by Ankit on 6/20/22.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //MARK: - Properties
    
    //MARK: - Selectors
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setupTabBar()
    }

    //MARK: - Helpers
    
    func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    func setupTabBar() {
        
        setViewControllers([
            createTabViewController(.pokedex),
            createTabViewController(.gender),
            createTabViewController(.habitat),
        ], animated: true)
        
        tabBar.tintColor = .white
        tabBar.backgroundColor = .black
        tabBar.unselectedItemTintColor = .gray
        
    }
    
    func createTabViewController(_ tab: TabBar) -> UINavigationController {
        let nav = UINavigationController(rootViewController: tab.controller)
        nav.title = tab.title
        nav.tabBarItem.image = UIImage(systemName: tab.icon)
        return nav
    }
    
}

   
 
