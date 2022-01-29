//
//  File.swift
//  WhereIsMyWarrantyTests
//
//  Created by Richardier on 28/01/2022.
//

import Foundation
import UIKit
@testable import WhereIsMyWarranty


class WarrantiesCoordinatorMock: AppCoordinatorProtocol {
    func start() {
        coordinatorStartCalled = true
    }
    
    var navigationController = UINavigationController()
    var coordinatorStartCalled = false
    
//    init() {
//        start()
//    }
    
//    func start() {
//        coordinatorStartCalled = true
//    }
    
    func showWarrantiesScreen() {
    }
    
    func showNewWarrantyProductInfoScreen() {
        start()
    }
    
    func showNewWarrantyProductPhotoScreen() {
    }
    
    func showNewWarrantyInvoicePhotoScreen() {
    }
    
    func warrantySaved() {
    }
    
    func showWarrantyDetailsScreen(warranty: Warranty) {
        start()
    }
    
    func showEditWarrantyProductInfoScreen(warranty: Warranty) {
    }
    
    func showEditWarrantyProductPhotoScreen() {
    }
    
    func showEditWarrantyInvoicePhotoScreen() {
    }
    
    func editedWarrantySaved() {
    }
}
