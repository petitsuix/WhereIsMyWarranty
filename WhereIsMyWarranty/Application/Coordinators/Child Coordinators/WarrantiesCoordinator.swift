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
    private var modalNavigationController: UINavigationController = UINavigationController()
    private let storageService: StorageService
    
    // MARK: - Methods
    
    init() {
        self.navigationController = UINavigationController()
        self.storageService = StorageService()
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
        let newWarrantyViewController = NewWarrantyProductInfoViewController()
        let viewModel = NewWarrantyViewModel(coordinator: self, storageService: storageService)
        viewModel.viewDelegate = newWarrantyViewController
        self.newWarrantyViewModel = viewModel
        newWarrantyViewController.viewModel = newWarrantyViewModel
        newWarrantyViewController.modalPresentationStyle = .popover
        newWarrantyViewController.modalTransitionStyle = .coverVertical
        modalNavigationController = UINavigationController(rootViewController: newWarrantyViewController)
        navigationController.present(modalNavigationController, animated: true, completion: nil)

    }
    
    func showNextStepNewWarrantyScreen() {
        let newWarrantyStepTwoViewController = NewWarrantyPhotoViewController()
        self.newWarrantyViewModel?.stepTwoViewDelegate = newWarrantyStepTwoViewController
        newWarrantyStepTwoViewController.viewModel = newWarrantyViewModel
        modalNavigationController.pushViewController(newWarrantyStepTwoViewController, animated: true)
    }
    
    func showWarrantyDetailsScreen(warranty: Warranty) {
        let warrantyDetailsViewController = WarrantyDetailsViewController()
        let warrantyDetailsViewModel = WarrantyDetailsViewModel(coordinator: self, storageService: storageService, warranty: warranty)
        warrantyDetailsViewModel.viewDelegate = warrantyDetailsViewController
        warrantyDetailsViewController.viewModel = warrantyDetailsViewModel
        // warrantyDetailsViewController.warranty = warranty
        navigationController.pushViewController(warrantyDetailsViewController, animated: true)
    }

    func warrantySaved() {
       // navigationController.dismiss(animated: true, completion: nil) // repasser viewModel à nil
        modalNavigationController.dismiss(animated: true) {
            self.newWarrantyViewModel = nil
        }
        newWarrantyViewModel?.notifyWarrantiesListUpdated() // j'ai bien fait de déclarer notifyWarrantiesListUpdated dans le viewModel ?
    }
}
