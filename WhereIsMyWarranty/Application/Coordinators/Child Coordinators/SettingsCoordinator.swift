//
//  SettingsCoordinator.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 13/12/2021.
//

import Foundation
import UIKit

class SettingsCoordinator: Coordinator {
    
    // MARK: - Properties
    
    public var navigationController: UINavigationController
    public var rootViewController: UIViewController {
        return navigationController
    }
    
    // MARK: - Methods
    
    init() {
        self.navigationController = UINavigationController()
        // FIXME: Est-ce que c'est normal de devoir placer showSettingsScreen ici ou ça a rien à faire dans le init ?
        showSettingsScreen()
    }
    
    func start() {
        showSettingsScreen()
    }
    
    func showSettingsScreen() {
        let settingsVC = SettingsViewController()
        // let settingsViewModel = SettingsViewModel(coordinator: self)
        navigationController.setViewControllers([settingsVC], animated: false)
    }
}
