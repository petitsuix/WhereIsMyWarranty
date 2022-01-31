//
//  WarrantyDetailsViewModelTests.swift
//  WhereIsMyWarrantyTests
//
//  Created by Richardier on 31/01/2022.
//


import XCTest
@testable import WhereIsMyWarranty

class WarrantyDetailsViewModelTests: XCTestCase {

    private let warranty1 = Warranty()
    
    var viewModel: WarrantyDetailsViewModel!
    var coordinatorMock: CoordinatorMock!
    var storageServiceMock: StorageServiceMock!
    
    override func setUp() {
        storageServiceMock = StorageServiceMock()
        coordinatorMock = CoordinatorMock()
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
}
