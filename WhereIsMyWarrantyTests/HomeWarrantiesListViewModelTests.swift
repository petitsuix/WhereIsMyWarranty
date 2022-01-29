//
//  HomeWarrantiesListViewModelTests.swift
//  WhereIsMyWarrantyTests
//
//  Created by Richardier on 28/01/2022.
//

import CoreData
import XCTest
@testable import WhereIsMyWarranty

class HomeWarrantiesListViewModelTests: XCTestCase {
    
    var viewModel: HomeWarrantiesListViewModel!
    var coordinator: WarrantiesCoordinatorMock!
    var storageService: StorageService!
    
    var loadedWarranties: [Warranty] = []
    
    var warranty1 = Warranty()
    var warranty2 = Warranty()

    override func setUpWithError() throws {
        
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        persistentStoreDescription.shouldAddStoreAsynchronously = true
       
        let persistentContainer = NSPersistentContainer(name: "WhereIsMyWarranty",
                                                        managedObjectModel: managedObjectModel)
        persistentContainer.persistentStoreDescriptions = [persistentStoreDescription]
        persistentContainer.loadPersistentStores { description, error in
            precondition(description.type == NSInMemoryStoreType, "Store description is not of type NSInMemoryStoreType")
            if let error = error as NSError? {
                fatalError("Persistent container creation failed : \(error.userInfo)")
            }
        }
        storageService = StorageService(persistentContainer: persistentContainer)
        warranty1 = Warranty(context: storageService.viewContext)
        warranty2 = Warranty(context: storageService.viewContext)
        coordinator = WarrantiesCoordinatorMock()
        viewModel = HomeWarrantiesListViewModel(coordinator: coordinator, storageService: storageService)
    }

    override func tearDownWithError() throws {
        storageService = nil
        viewModel = nil
    }
    
    func testShowNewWarrantyScreen() {
        XCTAssertFalse(coordinator.coordinatorStartCalled)
        viewModel.showNewWarrantyScreen()
        XCTAssertTrue(coordinator.coordinatorStartCalled)
    }
    
    func testShowWarrantyDetailsScreen() {
        XCTAssertFalse(coordinator.coordinatorStartCalled)
        viewModel.showWarrantyDetailsScreen(warranty: warranty1)
        XCTAssertTrue(coordinator.coordinatorStartCalled)
    }
    
    func testFetchWarrantiesFromDatabase() {
        viewModel.fetchWarrantiesFromDatabase()
        XCTAssertFalse(viewModel.warranties.isEmpty)
    }
}
