//
//  HomeWarrantiesListViewModelTests.swift
//  WhereIsMyWarrantyTests
//
//  Created by Richardier on 28/01/2022.
//

import XCTest
@testable import WhereIsMyWarranty

class HomeWarrantiesListViewModelTests: XCTestCase {
    
    var viewModel: HomeWarrantiesListViewModel!
    var coordinatorMock: CoordinatorMock!
    var storageServiceMock: StorageServiceMock!
    
    var loadedWarranties: [Warranty] = []
    
    private let warranty1 = Warranty()
    var warranty2 = Warranty()

    override func setUpWithError() throws {
        super.setUp()
        storageServiceMock = StorageServiceMock()
        coordinatorMock = CoordinatorMock()
        viewModel = HomeWarrantiesListViewModel(coordinator: coordinatorMock, storageService: storageServiceMock)
    }

    override func tearDownWithError() throws {
        storageServiceMock = nil
        viewModel = nil
    }
    
    func testShowNewWarrantyScreen() {
        XCTAssertFalse(coordinatorMock.showNewWarrantyProductInfoCalled)
        viewModel.showNewWarrantyScreen()
        XCTAssertTrue(coordinatorMock.showNewWarrantyProductInfoCalled)
    }
    
    func testShowWarrantyDetailsScreen() {
        XCTAssertFalse(coordinatorMock.showWarrantyDetailsScreenCalled)
        XCTAssertNil(coordinatorMock.warranty)
        viewModel.showWarrantyDetailsScreen(warranty: warranty1)
        XCTAssertTrue(coordinatorMock.showWarrantyDetailsScreenCalled)
        XCTAssertEqual(coordinatorMock.warranty, warranty1)
    }
    
    func testFetchWarrantiesFromDatabase() {
        XCTAssertFalse(storageServiceMock.loadWarrantiesCalled)
        viewModel.fetchWarrantiesFromDatabase()
        XCTAssertTrue(storageServiceMock.loadWarrantiesCalled)
    }
}
