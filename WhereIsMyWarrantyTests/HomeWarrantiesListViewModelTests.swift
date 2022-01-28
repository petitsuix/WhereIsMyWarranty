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
        
        coordinator = WarrantiesCoordinatorMock()
        viewModel = HomeWarrantiesListViewModel(coordinator: coordinator, storageService: storageService)
    }

    override func tearDownWithError() throws {
        storageService = nil
        viewModel = nil
    }
    
    func testExample() {
        XCTAssertFalse(coordinator.coordinatorStartCalled)
        viewModel.showNewWarrantyScreen()
        // assert que 
        XCTAssertTrue(coordinator.coordinatorStartCalled)
    }
    
    func testExample2() {
        
    }
}
