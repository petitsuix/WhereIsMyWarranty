//
//  WarrantiesCoordinator.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 13/12/2021.
//

import Foundation
import UIKit

class WarrantiesCoordinator: Coordinator {
    
    // MARK: - Public properties
    
    public var navigationController: UINavigationController
    public var rootViewController: UIViewController {
        return navigationController
    }
    
    // MARK: - Private properties
    
    private var newWarrantyViewModel: NewWarrantyViewModel?
    private var editWarrantyViewModel: EditWarrantyViewModel?
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
        let warrantiesVC = HomeWarrantiesListViewController()
        let warrantiesViewModel = HomeWarrantiesListViewModel(coordinator: self, storageService: storageService)
        warrantiesViewModel.viewDelegate = warrantiesVC
        warrantiesVC.viewModel = warrantiesViewModel
        navigationController.setViewControllers([warrantiesVC], animated: false)
    }
    
    func showNewWarrantyProductInfoScreen() {
        let newWarrantyViewController = NewWarrantyProductInfoViewController()
        let viewModel = NewWarrantyViewModel(coordinator: self, storageService: storageService)
        viewModel.newWarrantyProductInfoViewDelegate = newWarrantyViewController
        self.newWarrantyViewModel = viewModel
        newWarrantyViewController.viewModel = newWarrantyViewModel
        newWarrantyViewController.modalPresentationStyle = .popover
        newWarrantyViewController.modalTransitionStyle = .coverVertical
        modalNavigationController = UINavigationController(rootViewController: newWarrantyViewController)
        navigationController.present(modalNavigationController, animated: true, completion: nil)
        
    }
    
    func showNewWarrantyProductPhotoScreen() {
        let newWarrantyPhotoViewController = NewWarrantyPhotoViewController()
        self.newWarrantyViewModel?.newWarrantyPhotoViewDelegate = newWarrantyPhotoViewController
        newWarrantyPhotoViewController.viewModel = newWarrantyViewModel
        newWarrantyPhotoViewController.photoMode = .productPhoto
        modalNavigationController.pushViewController(newWarrantyPhotoViewController, animated: true)
    }
    
    func showNewWarrantyInvoicePhotoScreen() {
        let newWarrantyPhotoViewController = NewWarrantyPhotoViewController()
        self.newWarrantyViewModel?.newWarrantyPhotoViewDelegate = newWarrantyPhotoViewController
        newWarrantyPhotoViewController.viewModel = newWarrantyViewModel
        newWarrantyPhotoViewController.photoMode = .invoicePhoto
        modalNavigationController.pushViewController(newWarrantyPhotoViewController, animated: true)
    }
    
    func warrantySaved() {
        // navigationController.dismiss(animated: true, completion: nil) // repasser viewModel à nil
        modalNavigationController.dismiss(animated: true) {
            self.newWarrantyViewModel = nil
        }
        newWarrantyViewModel?.notifyWarrantiesListUpdated() // j'ai bien fait de déclarer notifyWarrantiesListUpdated dans le viewModel ?
    }
    
    func showWarrantyDetailsScreen(warranty: Warranty) {
        let warrantyDetailsViewController = WarrantyDetailsViewController()
        let warrantyDetailsViewModel = WarrantyDetailsViewModel(coordinator: self, storageService: storageService, warranty: warranty)
        warrantyDetailsViewModel.viewDelegate = warrantyDetailsViewController
        warrantyDetailsViewController.viewModel = warrantyDetailsViewModel
        // warrantyDetailsViewController.warranty = warranty
        navigationController.pushViewController(warrantyDetailsViewController, animated: true)
    }
    
    func showEditWarrantyProductInfoScreen(warranty: Warranty) {
        let editWarrantyProductInfoViewController = EditWarrantyProductInfoViewController()
        let viewModel = EditWarrantyViewModel(coordinator: self, storageService: storageService, warranty: warranty)
        viewModel.productInfoViewDelegate = editWarrantyProductInfoViewController
        self.editWarrantyViewModel = viewModel
        editWarrantyProductInfoViewController.viewModel = editWarrantyViewModel
        editWarrantyProductInfoViewController.modalPresentationStyle = .popover
        editWarrantyProductInfoViewController.modalTransitionStyle = .coverVertical
        modalNavigationController = UINavigationController(rootViewController: editWarrantyProductInfoViewController)
        navigationController.present(modalNavigationController, animated: true, completion: nil)
    }
    
    func showEditWarrantyProductPhotoScreen() {
        let editWarrantyPhotoScreen = EditWarrantyPhotoViewController()
        self.editWarrantyViewModel?.invoicePhotoViewDelegate = editWarrantyPhotoScreen
        editWarrantyPhotoScreen.viewModel = editWarrantyViewModel
        editWarrantyPhotoScreen.photoMode = .productPhoto
        modalNavigationController.pushViewController(editWarrantyPhotoScreen, animated: true)
    }
    
    func showEditWarrantyInvoicePhotoScreen() {
        let editWarrantyPhotoScreen = EditWarrantyPhotoViewController()
        self.editWarrantyViewModel?.invoicePhotoViewDelegate = editWarrantyPhotoScreen
        editWarrantyPhotoScreen.viewModel = editWarrantyViewModel
        editWarrantyPhotoScreen.photoMode = .invoicePhoto
        modalNavigationController.pushViewController(editWarrantyPhotoScreen, animated: true)
    }
    
    func editedWarrantySaved() {
        // navigationController.dismiss(animated: true, completion: nil) // repasser viewModel à nil
        modalNavigationController.dismiss(animated: true) {
            self.editWarrantyViewModel = nil
        }
        editWarrantyViewModel?.notifyWarrantyUpdated() // j'ai bien fait de déclarer notifyWarrantiesListUpdated dans le viewModel ?
    }
}
