//
//  SettingsCoordinator.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 13/12/2021.
//

import Foundation
import UIKit

class SettingsCoordinator: Coordinator {
    
    func start() {
    }
    
    public var navigationController: UINavigationController

    init() {
        self.navigationController = UINavigationController()
        self.navigationController.view.backgroundColor = .blue
    }

    public var rootViewController: UIViewController {
        return navigationController
    }
}
