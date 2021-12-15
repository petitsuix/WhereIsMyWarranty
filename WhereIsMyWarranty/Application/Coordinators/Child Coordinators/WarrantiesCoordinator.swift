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
        let warrantiesViewModel = WarrantiesViewModel(coordinator: self)
        warrantiesViewModel.viewDelegate = warrantiesVC
        warrantiesVC.viewModel = warrantiesViewModel
        navigationController.setViewControllers([warrantiesVC], animated: false)
    }
    
    func showAddNewWarrantyScreen() {
            let newWarrantyViewController = NewWarrantyViewController()
            navigationController.pushViewController(newWarrantyViewController, animated: true)
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
