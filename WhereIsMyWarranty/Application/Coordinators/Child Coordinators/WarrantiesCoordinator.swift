//
//  WarrantiesCoordinator.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 13/12/2021.
//

import Foundation
import UIKit

class WarrantiesCoordinator: Coordinator {
    
    // MARK: - Properties
    
    public var navigationController: UINavigationController
    public var rootViewController: UIViewController {
        return navigationController
    }
    var newWarrantyViewModel: NewWarrantyViewModel?
    private let modalNavigationController: UINavigationController
    private let storageService: StorageService
    private let newWarrantyViewController = NewWarrantyViewController()
    private let newWarrantyStepTwoViewController = NewWarrantyStepTwoViewController()
    
    // MARK: - Methods
    
    init() {
        self.navigationController = UINavigationController()
        self.storageService = StorageService()
        self.modalNavigationController = UINavigationController(rootViewController: newWarrantyViewController)
    }
    
    func start() {
        showWarrantiesScreen()
    }
    
    func showWarrantiesScreen() {
        let warrantiesVC = WarrantiesViewController()
        let warrantiesViewModel = WarrantiesViewModel(coordinator: self, storageService: storageService)
        warrantiesViewModel.viewDelegate = warrantiesVC
        warrantiesVC.viewModel = warrantiesViewModel
        navigationController.setViewControllers([warrantiesVC], animated: false)
    }
    
    //    func showAddNewWarrantyScreen() {
    //        let viewModel = NewWarrantyViewModel(coordinator: self, storageService: storageService)
    //        viewModel.viewDelegate = newWarrantyViewController
    //        newWarrantyViewController.viewModel = viewModel
    //        newWarrantyViewController.modalPresentationStyle = .popover
    //        newWarrantyViewController.modalTransitionStyle = .coverVertical
    //        navigationController.present(modalNavigationController, animated: true, completion: nil)
    //    }
    
    func showAddNewWarrantyScreen() {
//        let newWarrantyVC = NewWarrantyViewController()
        let viewModel = NewWarrantyViewModel(coordinator: self, storageService: storageService)
        viewModel.viewDelegate = newWarrantyViewController
        self.newWarrantyViewModel = viewModel
        newWarrantyViewController.viewModel = newWarrantyViewModel
        newWarrantyViewController.modalPresentationStyle = .popover
        newWarrantyViewController.modalTransitionStyle = .coverVertical
        navigationController.present(modalNavigationController, animated: true, completion: nil)
    }
    
    func showNextStepNewWarrantyScreen() {
        let viewModel = NewWarrantyViewModel(coordinator: self, storageService: storageService)
        viewModel.viewDelegate = newWarrantyViewController
        newWarrantyStepTwoViewController.viewModel = newWarrantyViewModel
        modalNavigationController.pushViewController(newWarrantyStepTwoViewController, animated: true)
    }
    
    func showWarrantyDetailsScreen(warranty: Warranty) {
        let warrantyDetailsViewController = WarrantyDetailsViewController()
        let warrantyDetailsViewModel = WarrantyDetailsViewModel(coordinator: self, storageService: storageService)
        warrantyDetailsViewModel.viewDelegate = warrantyDetailsViewController
        warrantyDetailsViewController.viewModel = warrantyDetailsViewModel
        warrantyDetailsViewController.warranty = warranty
        navigationController.pushViewController(warrantyDetailsViewController, animated: true)
    }
    // FIXME: 
    func backToHome() { // renommer en "warrantySaved"?
        navigationController.dismiss(animated: true, completion: nil) // repasser viewModel à nil
        notifyWarrantiesListUpdated()
//        navigationController.dismiss(animated: true) {
//            self.showWarrantiesScreen()
//        }
    }
    
    func notifyWarrantiesListUpdated() {
        let notificationName = NSNotification.Name(rawValue: "warranties list updated")
        let notification = Notification(name: notificationName)
        NotificationCenter.default.post(notification)
    }
}
