//
//  WarrantiesCoordinator.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 13/12/2021.
//

import Foundation
import UIKit

class WarrantiesCoordinator: Coordinator {
    
    public var navigationController: UINavigationController
    
    private let modalNavigationController: UINavigationController
    private let storageService: StorageService
    private let newWarrantyViewController = NewWarrantyViewController()

    
    init() {
        self.navigationController = UINavigationController()
        self.storageService = StorageService()
        self.modalNavigationController = UINavigationController(rootViewController: newWarrantyViewController)
    }

    public var rootViewController: UIViewController {
        return navigationController
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
    
    func showAddNewWarrantyScreen() {
      //  let secondStepVC = NewWarrantyStepTwoViewController()
        
       // let modalNavigationController = UINavigationController(rootViewController: newWarrantyViewController)
        let viewModel = NewWarrantyViewModel(coordinator: self, storageService: storageService)
        viewModel.viewDelegate = newWarrantyViewController
        newWarrantyViewController.viewModel = viewModel
        newWarrantyViewController.modalPresentationStyle = .popover
        newWarrantyViewController.modalTransitionStyle = .coverVertical
        navigationController.present(modalNavigationController, animated: true, completion: nil)
       // modalNavigationController.pushViewController(secondStepVC, animated: true) // MARK: - CA MARCHE COMME CA, il faut maintenant reussir à
        }
    
    func showNextStepNewWarrantyScreen() {
        
        let newWarrantyStepTwoViewController = NewWarrantyStepTwoViewController()
        newWarrantyStepTwoViewController.modalPresentationStyle = .popover
        newWarrantyStepTwoViewController.modalTransitionStyle = .coverVertical
        modalNavigationController.pushViewController(newWarrantyStepTwoViewController, animated: true)
        print("coucou")
    }
    
    func showWarrantyDetailsScreen(warranty: Warranty) {
        let warrantyDetailsViewController = WarrantyDetailsViewController()
        let warrantyDetailsViewModel = WarrantyDetailsViewModel(coordinator: self, storageService: storageService)
        warrantyDetailsViewModel.viewDelegate = warrantyDetailsViewController
        warrantyDetailsViewController.viewModel = warrantyDetailsViewModel
        warrantyDetailsViewController.warranty = warranty
        navigationController.pushViewController(warrantyDetailsViewController, animated: true)
    }
    
    func backToHome() {
        navigationController.popToRootViewController(animated: true)
    }
    
    
    // func showAddNewWarrantiesScreenFor(category: String) {
    //        let newWarrantiesVC = NewWarrantyViewController()
    //
    //        newWarrantiesVC.coordinator = self
    //        newWarrantiesVC.category = category
    //
    //        tabBarController.pushViewController(newWarrantiesVC, animated: true)
    //
    //   }
}
