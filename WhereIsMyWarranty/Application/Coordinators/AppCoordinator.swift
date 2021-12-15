//
//  AppCoordinator.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 06/12/2021.
//

import Foundation
import UIKit

class AppCoordinator: NSObject, Coordinator, UITabBarControllerDelegate {
    
    var navigationController: UINavigationController
    
    var rootViewController: UIViewController {
        return tabBarController
    }
    
    var tabBarController: UITabBarController
    
    let warrantiesCoordinator: WarrantiesCoordinator
    let settingsCoordinator: SettingsCoordinator
    let window: UIWindow
    
    /*
    let userdefault ..
    let networkSetrvice: Network..
    let storage: staor...State
    
    init(window: UIWindow, storageService: StorageService = StorageService() ...) {
        self.window =
        ...
    }
     */
    
    init(window: UIWindow) {
        self.window = window
        tabBarController = UITabBarController()
        warrantiesCoordinator = WarrantiesCoordinator() //WarrantiesCoordinator(storageservice : stor)
        settingsCoordinator = SettingsCoordinator()
        navigationController = UINavigationController()
        
        var tabBarControllers: [UIViewController] = []
        
        let warrantiesViewController = warrantiesCoordinator.rootViewController
        warrantiesViewController.tabBarItem = UITabBarItem(title: "Garanties", image: UIImage(systemName: "newspaper"), selectedImage: UIImage(systemName: "newspaper.fill"))
        
     //   warrantiesViewController.tabBarController?.target(forAction: Selector, withSender: <#T##Any?#>)
        
        let settingsViewController = settingsCoordinator.rootViewController
        settingsViewController.tabBarItem = UITabBarItem(title: "Réglages", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        
        
        
        
        tabBarControllers.append(warrantiesViewController)
        tabBarControllers.append(settingsViewController)
        
        tabBarController.viewControllers = tabBarControllers
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = MWColor.paleOrange
        //  tabBarController.delegate = self
    }
    
    var coordinators: [Coordinator] {
        return [warrantiesCoordinator, settingsCoordinator]
    }
    
    //    func handleNotification() {
    //        switch
    //        showNewWarrantiesScreenFor(category: <#T##String#>)
    //    }
    func start() {
        print("ok")
        startWarrantiesFlow()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        // est-ce que l'utilisateur est venu d'un lien ?
        // envoyer une notification ?
        //startWarrantiesHomeFlow()
        //window.makeKeyAndVisible()
        //        if Bool.random() {
        //            showWarrantiesScreen()
        //        } else {
        //            showNewWarrantiesScreenFor(category: "TEST RANDOM")
        //        }
    }
    
    //    func showNewWarrantiesScreenFor(category: String) {
    //        let newWarrantiesVC = NewWarrantyViewController()
    //
    //        newWarrantiesVC.coordinator = self
    //        newWarrantiesVC.category = category
    //
    //        tabBarController.pushViewController(newWarrantiesVC, animated: true)
    //
    //    }
    
    private func startWarrantiesFlow() {
        warrantiesCoordinator.start()
    }
}
