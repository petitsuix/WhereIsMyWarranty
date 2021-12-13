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
        self.navigationController.view.backgroundColor = .yellow
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
    
    func showNewWarrantiesScreenFor(category: String) {
            let newWarrantiesVC = NewWarrantyViewController()
    
    
            navigationController.pushViewController(newWarrantiesVC, animated: true)
    
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
