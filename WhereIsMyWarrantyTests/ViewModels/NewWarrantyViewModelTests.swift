//
//  NewWarrantyViewModelTests.swift
//  WhereIsMyWarrantyTests
//
//  Created by Richardier on 01/02/2022.
//

import XCTest
@testable import WhereIsMyWarranty

class NewWarrantyViewModelTests: XCTestCase {

    var viewModel: NewWarrantyViewModel!
    var coordinatorMock: CoordinatorMock!
    var storageServiceMock: StorageServiceMock!
    
    override func setUp() {
        storageServiceMock = StorageServiceMock()
        coordinatorMock = CoordinatorMock()
        viewModel = NewWarrantyViewModel(coordinator: coordinatorMock, storageService: storageServiceMock)
    }

    override func tearDown() {
        storageServiceMock = nil
        viewModel = nil
    }
    
    func testWarrantySaved() {
        XCTAssertFalse(coordinatorMock.warrantySavedCalled)
        viewModel.warrantySaved()
        XCTAssertTrue(coordinatorMock.warrantySavedCalled)
    }
    
    func testGoToAddProductPhotoScreen() {
        XCTAssertEqual(coordinatorMock.showNewWarrantyProductPhotoCallCount, 0)
        viewModel.goToAddProductPhotoScreen()
        XCTAssertEqual(coordinatorMock.showNewWarrantyProductPhotoCallCount, 1)
    }
    
    func testGoToAddInvoicePhotoScreen() {
        XCTAssertEqual(coordinatorMock.showNewWarrantyInvoicePhotoCallCount, 0)
        viewModel.goToAddInvoicePhotoScreen()
        XCTAssertEqual(coordinatorMock.showNewWarrantyInvoicePhotoCallCount, 1)
    }
    
    func testGoToExtraInfoScreen() {
        XCTAssertFalse(coordinatorMock.showNewWarrantyExtraInfoCalled)
        viewModel.goToExtraInfoScreen()
        XCTAssertTrue(coordinatorMock.showNewWarrantyExtraInfoCalled)
    }
    
    func testSaveWarranty() {
        XCTAssertFalse(coordinatorMock.warrantySavedCalled)
        viewModel.saveWarranty()
        XCTAssertTrue(coordinatorMock.warrantySavedCalled)
    }
}
