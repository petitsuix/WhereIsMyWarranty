//
//  StorageServiceMock.swift
//  WhereIsMyWarrantyTests
//
//  Created by Richardier on 31/01/2022.
//

import CoreData
@testable import WhereIsMyWarranty

class StorageServiceMock: StorageServiceProtocol {
    
    
    
    var viewContext: NSManagedObjectContext
    
    init() {
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
        self.viewContext = persistentContainer.viewContext
    }
    
    var loadCategoriesCalled = false
    func loadCategories() throws -> [WhereIsMyWarranty.Category] { // Should return [Category], but here we have to precise [WhereIsMyWarranty.Category] because the use of [Category] is ambiguous in this context (conflict with ObjectiveC.Category)
        loadCategoriesCalled = true
        return [FakeData.category, FakeData.category2]
    }
    
    
    var loadWarrantiesCalled = false
    func loadWarranties() throws -> [Warranty] {
        loadWarrantiesCalled = true
        return [FakeData.warranty1, FakeData.warranty2]
    }
    
    var saveCalled = false
    func save() {
        saveCalled = true
    }
    
    var deleteWarrantyCalled = false
    func deleteWarranty(_ object: NSManagedObject) throws {
        deleteWarrantyCalled = true
    }
}
