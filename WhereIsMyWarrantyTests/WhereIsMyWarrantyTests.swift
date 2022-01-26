//
//  WhereIsMyWarrantyTests.swift
//  WhereIsMyWarrantyTests
//
//  Created by Richardier on 03/12/2021.
//

import CoreData
import XCTest
@testable import WhereIsMyWarranty

class WhereIsMyWarrantyTests: XCTestCase {
    
    var storageService: StorageService!
    var loadedWarranties: [Warranty] = []
    
    var warranty1 = Warranty()
    var warranty2 = Warranty()
    
    override func setUp() {
        super.setUp()

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
    }
    
    override func tearDown() {
        super.tearDown()
        storageService = nil
        loadedWarranties = []
    }
    
    func testWarrantyLoading() throws {
        
        storageService.save()
        
        do {
            loadedWarranties = try storageService.loadWarranties()
        } catch {
            XCTFail("error loading \(error.localizedDescription)")
        }
        XCTAssertFalse(loadedWarranties.isEmpty)
    }
    
    func testDeletingWarranty() {
        
        storageService.save()
        
        do {
            loadedWarranties = try storageService.loadWarranties()
        } catch {
            XCTFail("error loading \(error.localizedDescription)")
        }
        
        do {
            try storageService.deleteWarranty(loadedWarranties[0])
        } catch {
            XCTFail("error deleting \(error.localizedDescription)")
        }
        
        do {
            loadedWarranties = try storageService.loadWarranties()
        } catch {
            XCTFail("error loading \(error.localizedDescription)")
        }
        
        XCTAssert(loadedWarranties.count == 1)
    }
}
