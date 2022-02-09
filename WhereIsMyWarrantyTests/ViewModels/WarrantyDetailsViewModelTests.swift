//
//  WarrantyDetailsViewModelTests.swift
//  WhereIsMyWarrantyTests
//
//  Created by Richardier on 31/01/2022.
//

import XCTest
@testable import WhereIsMyWarranty

class WarrantyDetailsViewModelTests: XCTestCase {

    var warranty1: Warranty!
    
    var viewModel: WarrantyDetailsViewModel!
    var coordinatorMock: CoordinatorMock!
    var storageServiceMock: StorageServiceMock!
    
    override func setUp() {
        storageServiceMock = StorageServiceMock()
        coordinatorMock = CoordinatorMock()
        warranty1 = Warranty(context: storageServiceMock.viewContext)
        viewModel = WarrantyDetailsViewModel(coordinator: coordinatorMock, storageService: storageServiceMock, warranty: warranty1)
    }

    override func tearDown() {
        storageServiceMock = nil
        viewModel = nil
    }

    func testDeleteWarranty() {
        XCTAssertFalse(storageServiceMock.deleteWarrantyCalled)
        viewModel?.deleteWarranty()
        XCTAssertTrue(storageServiceMock.deleteWarrantyCalled)
    }
    
    func testEditWarranty() {
        XCTAssertFalse(coordinatorMock.showEditWarrantyProductInfoCalled)
        viewModel.editWarranty()
        XCTAssertTrue(coordinatorMock.showEditWarrantyProductInfoCalled)
    }
    
    func testShowFullScreenInvoicePhoto() {
        XCTAssertFalse(coordinatorMock.showFullScreenInvoicePhotoCalled)
        // Given
        warranty1.invoicePhoto = MWImages.chevron?.pngData()
        // When
        viewModel.showFullScreenInvoicePhoto()
        // Then
        XCTAssertTrue(coordinatorMock.showFullScreenInvoicePhotoCalled)
    }
}
