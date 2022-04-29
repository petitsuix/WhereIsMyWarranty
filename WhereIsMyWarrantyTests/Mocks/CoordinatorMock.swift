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
    func showHomeWarrantiesListScreen() {
        showWarrantiesCalled = true
    }
    
    var showNewWarrantyProductInfoCalled = false
    func showNewWarrantyProductInfoScreen() {
        showNewWarrantyProductInfoCalled = true
    }
    
    var showNewWarrantyProductPhotoCallCount = 0
    func showNewWarrantyProductPhotoScreen() {
        showNewWarrantyProductPhotoCallCount += 1
    }
    
    var showNewWarrantyInvoicePhotoCallCount = 0
    func showNewWarrantyInvoicePhotoScreen() {
        showNewWarrantyInvoicePhotoCallCount += 1
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
    
    var editedWarrantySavedCalled = false
    func editedWarrantySaved() {
        editedWarrantySavedCalled = true
    }
    
    var showFullScreenInvoicePhotoCalled = false
    func showFullScreenInvoicePhoto(invoicePhoto: Data) {
        showFullScreenInvoicePhotoCalled = true
    }
    
    var showNewWarrantyExtraInfoCalled = false
    func showNewWarrantyExtraInfoScreen() {
        showNewWarrantyExtraInfoCalled = true
    }
    
    var showEditWarrantyExtraInfoCalled = false
    func showEditWarrantyExtraInfoScreen() {
        showEditWarrantyExtraInfoCalled = true
    }
    
}
