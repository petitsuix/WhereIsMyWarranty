//
//  SettingsCoordinator.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 13/12/2021.
//

import UIKit

class SettingsCoordinator: Coordinator {
    
    // MARK: - Internal properties
    
    var navigationController: UINavigationController
    var rootViewController: UIViewController {
        return navigationController
    }
    
    // MARK: - Methods
    
    init() {
        self.navigationController = UINavigationController()
        showSettingsScreen()
    }
    
    // FIXME: Pourquoi lui il est jamais lu ?
    func start() {
        showSettingsScreen()
    }
    
    // MARK: - Private methods
    
   private func showSettingsScreen() {
        let settingsVC = SettingsViewController()
        // let settingsViewModel = SettingsViewModel(coordinator: self)
        navigationController.setViewControllers([settingsVC], animated: false)
    }
}
