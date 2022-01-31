//
//  File.swift
//  WhereIsMyWarrantyTests
//
//  Created by Richardier on 28/01/2022.
//

import Foundation
import UIKit
@testable import WhereIsMyWarranty


class CoordinatorMock: WarrantiesCoordinatorProtocol {
    var navigationController = UINavigationController()
    
    var warranty: Warranty?
    
    var coordinatorStartCalled = false
    func start() {
        coordinatorStartCalled = true
    }
    
   var showWarrantiesCalled = false
    func showWarrantiesScreen() {
        showWarrantiesCalled = true
    }
    
    var showNewWarrantyProductInfoCalled = false
    func showNewWarrantyProductInfoScreen() {
        showNewWarrantyProductInfoCalled = true
    }
    
    var showNewWarrantyPhotoSCreenCallCount = 0
    func showNewWarrantyProductPhotoScreen() {
        showNewWarrantyPhotoSCreenCallCount += 1
    }
    
    func showNewWarrantyInvoicePhotoScreen() {
    }
    
    func warrantySaved() {
    }
    
    var showWarrantyDetailsScreenCalled = false
    func showWarrantyDetailsScreen(warranty: Warranty) {
        self.warranty = warranty
        showWarrantyDetailsScreenCalled = true
        
    }
    
    var showEditWarrantyProductInfoCalled = false
    func showEditWarrantyProductInfoScreen(warranty: Warranty) {
        showEditWarrantyProductInfoCalled = true
    }
    
    func showEditWarrantyProductPhotoScreen() {
    }
    
    func showEditWarrantyInvoicePhotoScreen() {
    }
    
    func editedWarrantySaved() {
    }
}
