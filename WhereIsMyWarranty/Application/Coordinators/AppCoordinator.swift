//
//  AppCoordinator.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 06/12/2021.
//

import UIKit

class AppCoordinator: NSObject, Coordinator, UITabBarControllerDelegate {
    
    // MARK: - Internal properties
    
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
        warrantiesViewController.tabBarItem = UITabBarItem(title: Strings.warrantiesTitle, image: MWImages.warrantiesTabImage, selectedImage: MWImages.warrantiesTabImageSelected)
        
        let settingsViewController = settingsCoordinator.rootViewController
        settingsViewController.tabBarItem = UITabBarItem(title: Strings.settingsTitle, image: MWImages.settingsTabImage, selectedImage: MWImages.settingsTabImageSelected)
        
        tabBarControllers.append(warrantiesViewController)
        tabBarControllers.append(settingsViewController)
        
        tabBarController.tabBar.unselectedItemTintColor = MWColor.bluegrey
        tabBarController.tabBar.tintColor = MWColor.bluegrey

        tabBarController.viewControllers = tabBarControllers
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = MWColor.paleOrange
        tabBarController.tabBar.barTintColor = MWColor.paleOrange
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
