//
//  AppCoordinator.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 06/12/2021.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
    }
    
    func start() {
        print("ok")
        // est-ce que l'utilisateur est venu d'un lien ?
        // envoyer une notification ?
        startWarrantiesHomeFlow()
        window.makeKeyAndVisible()
    }
    
    private func startWarrantiesHomeFlow() {
        let homeViewController = WarrantiesViewController()
      //  homeViewController.viewModel = homeViewModel
        navigationController.setViewControllers([homeViewController], animated: false)
        window.rootViewController = TabBarViewController()
        
//        navigationController.title = "Garanties"
    }
}
