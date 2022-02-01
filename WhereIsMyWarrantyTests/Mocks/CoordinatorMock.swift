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
    
    var showNewWarrantyProductPhotoScreenCallCount = 0
    func showNewWarrantyProductPhotoScreen() {
        showNewWarrantyProductPhotoScreenCallCount += 1
    }
    
    var showNewWarrantyInvoicePhotoScreenCallCount = 0
    func showNewWarrantyInvoicePhotoScreen() {
        showNewWarrantyInvoicePhotoScreenCallCount += 1
    }
    
    var warrantySavedCalled = false
    func warrantySaved() {
        warrantySavedCalled = true
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
    
    var showEditWarrantyProductPhotoCalled = false
    func showEditWarrantyProductPhotoScreen() {
        showEditWarrantyProductPhotoCalled = true
    }
    
    var showEditWarrantyInvoicePhotoCalled = false
    func showEditWarrantyInvoicePhotoScreen() {
        showEditWarrantyInvoicePhotoCalled = true
    }
    
    func editedWarrantySaved() {
    }
}
