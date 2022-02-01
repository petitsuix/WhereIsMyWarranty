//
//  EditWarrantyViewModel.swift
//  WhereIsMyWarrantyTests
//
//  Created by Richardier on 01/02/2022.
//

import XCTest
@testable import WhereIsMyWarranty

class EditWarrantyViewModelTests: XCTestCase {

    var viewModel: EditWarrantyViewModel!
    var coordinatorMock: CoordinatorMock!
    var storageServiceMock: StorageServiceMock!
    
    override func setUp() {
        storageServiceMock = StorageServiceMock()
        coordinatorMock = CoordinatorMock()
        viewModel = EditWarrantyViewModel(coordinator: coordinatorMock, storageService: storageServiceMock, warranty: FakeData.warranty1)
    }

    override func tearDown() {
        storageServiceMock = nil
        viewModel = nil
    }
    
//    func testWarrantySaved() {
//        XCTAssertFalse(coordinatorMock.warrantySavedCalled)
//        viewModel.warrantySaved()
//        XCTAssertTrue(coordinatorMock.warrantySavedCalled)
//    }
    
    func testGoToAddProductPhotoScreen() {
        XCTAssertEqual(coordinatorMock.showNewWarrantyProductPhotoScreenCallCount, 0)
        viewModel.goToEditProductPhotoScreen()
        XCTAssertEqual(coordinatorMock.showNewWarrantyProductPhotoScreenCallCount, 1)
    }
    
    func testGoToAddInvoicePhotoScreen() {
        XCTAssertEqual(coordinatorMock.showNewWarrantyInvoicePhotoScreenCallCount, 0)
        viewModel.goToEditInvoicePhotoScreen()
        XCTAssertEqual(coordinatorMock.showNewWarrantyInvoicePhotoScreenCallCount, 1)
    }
    
    func testSaveEditedWarranty() {
        XCTAssertFalse(coordinatorMock.warrantySavedCalled)
        viewModel.saveEditedWarranty()
        XCTAssertTrue(coordinatorMock.warrantySavedCalled)
    }
}

