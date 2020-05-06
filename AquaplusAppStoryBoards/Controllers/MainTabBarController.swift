//
//  MainTabBarController.swift
//  AquaplusApp
//
//  Created by David Mendes Da Silva on 23/04/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var homeController = HomeController()
    var contactsController = ContactsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let vc = UIViewController()
        vc.view.backgroundColor = .yellow
        
        viewControllers = [
            createNavController(viewController: homeController, tabBarImage: #imageLiteral(resourceName: "delivery")),
            createNavController(viewController: contactsController, tabBarImage: #imageLiteral(resourceName: "contact")),
            createNavController(viewController: vc, tabBarImage: #imageLiteral(resourceName: "hub")),
            createNavController(viewController: vc, tabBarImage: #imageLiteral(resourceName: "report")),
            createNavController(viewController: vc, tabBarImage: #imageLiteral(resourceName: "setting"))
        ]
            
        tabBar.tintColor = .black
        
    }
    
    fileprivate func createNavController(viewController: UIViewController, tabBarImage: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = tabBarImage
        return navController
    }
}
