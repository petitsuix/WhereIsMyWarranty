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
    
    var warranty1: Warranty!
    
    override func setUp() {
        super.setUp()
        storageServiceMock = StorageServiceMock()
        coordinatorMock = CoordinatorMock()
        warranty1 = Warranty(context: storageServiceMock.viewContext)
        viewModel = EditWarrantyViewModel(coordinator: coordinatorMock, storageService: storageServiceMock, warranty: warranty1)
    }

    override func tearDown() {
        storageServiceMock = nil
        viewModel = nil
    }
    
    func testWarrantySaved() {
        XCTAssertFalse(coordinatorMock.editedWarrantySavedCalled)
        viewModel.warrantySaved()
        XCTAssertTrue(coordinatorMock.editedWarrantySavedCalled)
    }
    
    func testGoToEditProductPhotoScreen() {
        XCTAssertFalse(coordinatorMock.showEditWarrantyProductPhotoCalled)
        viewModel.goToEditProductPhotoScreen()
        XCTAssertTrue(coordinatorMock.showEditWarrantyProductPhotoCalled)
    }
    
    func testGoToEditInvoicePhotoScreen() {
        XCTAssertFalse(coordinatorMock.showEditWarrantyInvoicePhotoCalled)
        viewModel.goToEditInvoicePhotoScreen()
        XCTAssertTrue(coordinatorMock.showEditWarrantyInvoicePhotoCalled)
    }
    
    func testSaveEditedWarranty() {
        XCTAssertFalse(storageServiceMock.saveCalled)
        viewModel.saveEditedWarranty()
        XCTAssertTrue(storageServiceMock.saveCalled)
    }
    
    func testGetYearsStepperValue() {
        warranty1.warrantyStart = Date()
        warranty1.warrantyEnd = Date().adding(.year, value: 1)
        let numberOfYears = viewModel.calculateNumberOfYears()
        XCTAssertEqual(numberOfYears, 1.0)
    }
    
    func testGetMonthsStepperValue() {
        warranty1.warrantyStart = Date()
        warranty1.warrantyEnd = Date().adding(.month, value: 1)
        let numberOfMonths = viewModel.calculateNumberOfMonths()
        XCTAssertEqual(numberOfMonths, 1.0)
    }
    
    func testGetWeeksStepperValue() {
        warranty1.warrantyStart = Date()
        warranty1.warrantyEnd = Date().adding(.day, value: 7)
        let numberOfWeeks = viewModel.calculateNumberOfWeeks()
        XCTAssertEqual(numberOfWeeks, 1.0)
    }
    
    func testGoToEditExtraInfoScreen() {
        XCTAssertFalse(coordinatorMock.showEditWarrantyExtraInfoCalled)
        viewModel.goToEditExtraInfoScreen()
        XCTAssertTrue(coordinatorMock.showEditWarrantyExtraInfoCalled)
    }
}
