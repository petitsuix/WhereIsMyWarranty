//
//  AppCoordinator.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 06/12/2021.
//

import Foundation
import UIKit

class AppCoordinator: NSObject, Coordinator, UITabBarControllerDelegate {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    // MARK: - Private Properties
    
    private var rootViewController: UIViewController {
        return tabBarController
    }
    private var tabBarController: UITabBarController
    private let warrantiesCoordinator: WarrantiesCoordinator
    private let settingsCoordinator: SettingsCoordinator
    private let window: UIWindow
    
    // MARK: - Initializer
    
    init(window: UIWindow) {
        self.window = window
        tabBarController = UITabBarController()
        warrantiesCoordinator = WarrantiesCoordinator()
        settingsCoordinator = SettingsCoordinator()
        navigationController = UINavigationController()
        
        var tabBarControllers: [UIViewController] = []
        
        let warrantiesViewController = warrantiesCoordinator.rootViewController
        warrantiesViewController.tabBarItem = UITabBarItem(title: "Garanties", image: UIImage(systemName: "newspaper"), selectedImage: UIImage(systemName: "newspaper.fill"))
        
        let settingsViewController = settingsCoordinator.rootViewController
        settingsViewController.tabBarItem = UITabBarItem(title: "Réglages", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        
        tabBarControllers.append(warrantiesViewController)
        tabBarControllers.append(settingsViewController)
        
        tabBarController.viewControllers = tabBarControllers
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = MWColor.paleOrange
    }
    
    // MARK: - Methods

    func start() {
        startWarrantiesFlow()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    private func startWarrantiesFlow() {
        warrantiesCoordinator.start()
    }
}
