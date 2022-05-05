//
//  SettingsCoordinator.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 13/12/2021.
//

import UIKit

class SettingsCoordinator: Coordinator, SettingsCoordinatorProtocol {
    
    // MARK: - Internal properties
    
    var navigationController: UINavigationController
    var rootViewController: UIViewController {
        return navigationController
    }
    
    // MARK: - Methods
    
    init() {
        self.navigationController = UINavigationController()
        start()
    }
    
    func start() {
        showSettingsScreen()
    }
    
    // MARK: - Private methods
    
    internal func showSettingsScreen() {
        let settingsVC = SettingsViewController()
        let settingsViewModel = SettingsViewModel(coordinator: self)
        settingsViewModel.settingsVCViewDelegate = settingsVC
        settingsVC.viewModel = settingsViewModel
        navigationController.setViewControllers([settingsVC], animated: false)
    }
    
    func showPrivacyPolicyScreen() {
        let privacyPolicyViewController = TextViewController()
        let privacyPolicyViewModel = SettingsViewModel(coordinator: self)
        privacyPolicyViewModel.textVCViewDelegate = privacyPolicyViewController
        privacyPolicyViewController.viewModel = privacyPolicyViewModel
        privacyPolicyViewController.controllerType = .privacyPolicy
        navigationController.pushViewController(privacyPolicyViewController, animated: true)
    }
    
    func showTermsAndConditionsScreen() {
        let termsAndConditionsViewController = TextViewController()
        let termsAndConditionsViewModel = SettingsViewModel(coordinator: self)
        termsAndConditionsViewModel.textVCViewDelegate = termsAndConditionsViewController
        termsAndConditionsViewController.viewModel = termsAndConditionsViewModel
        termsAndConditionsViewController.controllerType = .termsAndConditions
        navigationController.pushViewController(termsAndConditionsViewController, animated: true)
    }
}
