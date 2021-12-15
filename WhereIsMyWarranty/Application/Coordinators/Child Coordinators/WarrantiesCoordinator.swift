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

 //   private let storageService: StorageService
    
    init() {
        self.navigationController = UINavigationController()
    }

    public var rootViewController: UIViewController {
        return navigationController
    }
    
    func start() {
        showWarrantiesScreen()
    }
    
    
    func showWarrantiesScreen() {
        let warrantiesVC = WarrantiesViewController()
        let warrantiesViewModel = WarrantiesViewModel(coordinator: self/*, storageService: storageService*/)
        warrantiesViewModel.viewDelegate = warrantiesVC
        warrantiesVC.viewModel = warrantiesViewModel
        navigationController.setViewControllers([warrantiesVC], animated: false)
    }
    
    func showAddNewWarrantyScreen() {
        let newWarrantyViewController = NewWarrantyViewController()
        let newWarrantyViewModel = NewWarrantyViewModel(coordinator: self)
        newWarrantyViewModel.viewDelegate = newWarrantyViewController
        newWarrantyViewController.viewModel = newWarrantyViewModel
        navigationController.pushViewController(newWarrantyViewController, animated: true)
        }
    
    func goBack() {
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
