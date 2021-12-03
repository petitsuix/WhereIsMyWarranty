///
//  TabBarViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 30/11/2021.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tabBar.backgroundColor = #colorLiteral(red: 0.9285728335, green: 0.7623301148, blue: 0.6474828124, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create Tab one
        let warrantiesTab = UINavigationController(rootViewController: WarrantiesViewController())
        let tabOneBarItem = UITabBarItem(title: "Garanties", image: UIImage(systemName: "newspaper"), selectedImage: UIImage(systemName: "newspaper.fill"))
        
        warrantiesTab.tabBarItem = tabOneBarItem
        
        
        // Create Tab two
        let settingsTab = UINavigationController(rootViewController: SettingsViewController())
        let tabTwoBarItem2 = UITabBarItem(title: "Réglages", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        
        settingsTab.tabBarItem = tabTwoBarItem2
        
        
        self.viewControllers = [warrantiesTab, settingsTab]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
}
