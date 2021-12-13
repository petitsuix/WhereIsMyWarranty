//
//  Coordinator.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 06/12/2021.
//

import UIKit

protocol Coordinator {
    
    func start()
    var navigationController: UINavigationController { get set }
}
