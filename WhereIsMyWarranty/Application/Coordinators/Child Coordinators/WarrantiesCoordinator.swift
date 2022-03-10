//
//  WarrantiesCoordinator.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 13/12/2021.
//

import UIKit

class WarrantiesCoordinator: Coordinator, WarrantiesCoordinatorProtocol {
    
    // MARK: - Internal properties
    
    var navigationController: UINavigationController
    var rootViewController: UIViewController {
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
        showHomeWarrantiesListScreen()
    }
    
    func showHomeWarrantiesListScreen() {
        let homeWarrantiesListViewController = HomeWarrantiesListViewController()
        let homeWarrantiesListViewModel = HomeWarrantiesListViewModel(coordinator: self, storageService: storageService)
        homeWarrantiesListViewModel.viewDelegate = homeWarrantiesListViewController
        homeWarrantiesListViewController.viewModel = homeWarrantiesListViewModel
        navigationController.setViewControllers([homeWarrantiesListViewController], animated: false)
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
    
    func showNewWarrantyExtraInfoScreen() {
        let newWarrantyExtraInfoViewController = ExtraInfoViewController()
        self.newWarrantyViewModel?.newWarrantyExtraInfoViewDelegate = newWarrantyExtraInfoViewController
        newWarrantyExtraInfoViewController.viewModel = newWarrantyViewModel
        modalNavigationController.pushViewController(newWarrantyExtraInfoViewController, animated: true)
    }
    
    func warrantySaved() {
        modalNavigationController.dismiss(animated: true) {
            self.newWarrantyViewModel = nil
        }
        newWarrantyViewModel?.notifyWarrantiesListUpdated()
    }
    
    func showWarrantyDetailsScreen(warranty: Warranty) {
        let warrantyDetailsViewController = WarrantyDetailsViewController()
        let warrantyDetailsViewModel = WarrantyDetailsViewModel(coordinator: self, storageService: storageService, warranty: warranty)
        warrantyDetailsViewModel.viewDelegate = warrantyDetailsViewController
        warrantyDetailsViewController.viewModel = warrantyDetailsViewModel
        navigationController.pushViewController(warrantyDetailsViewController, animated: true)
    }
    
    func showFullScreenInvoicePhoto(invoicePhoto: Data) {
        let fullScreenInvoicePhotoViewController = FullScreenInvoicePhotoViewController()
        fullScreenInvoicePhotoViewController.invoicePhoto = invoicePhoto
        modalNavigationController.modalPresentationStyle = .popover
        modalNavigationController.modalTransitionStyle = .coverVertical
        modalNavigationController = UINavigationController(rootViewController: fullScreenInvoicePhotoViewController)
        navigationController.present(modalNavigationController, animated: true, completion: nil)
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
        self.editWarrantyViewModel?.photoViewDelegate = editWarrantyPhotoScreen
        editWarrantyPhotoScreen.viewModel = editWarrantyViewModel
        editWarrantyPhotoScreen.photoMode = .productPhoto
        modalNavigationController.pushViewController(editWarrantyPhotoScreen, animated: true)
    }
    
    func showEditWarrantyInvoicePhotoScreen() {
        let editWarrantyPhotoScreen = EditWarrantyPhotoViewController()
        self.editWarrantyViewModel?.photoViewDelegate = editWarrantyPhotoScreen
        editWarrantyPhotoScreen.viewModel = editWarrantyViewModel
        editWarrantyPhotoScreen.photoMode = .invoicePhoto
        modalNavigationController.pushViewController(editWarrantyPhotoScreen, animated: true)
    }
    
    func editedWarrantySaved() {
        modalNavigationController.dismiss(animated: true) {
            self.editWarrantyViewModel = nil
        }
        editWarrantyViewModel?.notifyWarrantyUpdated()
    }
    
}
