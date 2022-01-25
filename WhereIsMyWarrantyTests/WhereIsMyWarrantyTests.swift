//
//  WhereIsMyWarrantyTests.swift
//  WhereIsMyWarrantyTests
//
//  Created by Richardier on 03/12/2021.
//

import CoreData
import XCTest
@testable import WhereIsMyWarranty



class FakeResponseData {
    
    static let viewContext: NSManagedObjectContext? = nil
    
    
    static var warranties: [Warranty] = []
}

class WhereIsMyWarrantyTests: XCTestCase {
    
    var storageService: StorageService!
    var loadedWarranties: [Warranty] = []
    
//    let warranty2 = Warranty()
//    let warranty3 = Warranty()
    override func setUp() {
        super.setUp()
        storageService = StorageService()

        let warranty1 = Warranty(context: storageService.viewContext)

        warranty1.name = "Warranty test 1"
        warranty1.warrantyStart = Date()
        warranty1.lifetimeWarranty = true
        warranty1.warrantyEnd = Date()
//        warranty1.invoicePhoto = UIImage(named: "Launchscreen")?.pngData()
        warranty1.productPhoto = UIImage(named: "Launchscreen")?.pngData()
        
        let warranty2 = Warranty(context: storageService.viewContext)
        warranty2.name = "Warranty test 2"
        warranty2.warrantyStart = Date()
        warranty2.lifetimeWarranty = true
        warranty2.warrantyEnd = Date()
        warranty2.invoicePhoto = UIImage(named: "Launchscreen")?.pngData()
        warranty2.productPhoto = UIImage(named: "Launchscreen")?.pngData()
        
        let warranty3 = Warranty(context: storageService.viewContext)
        warranty3.name = "Warranty test 3"
        warranty3.warrantyStart = Date()
        warranty3.lifetimeWarranty = true
        warranty3.warrantyEnd = Date()
        warranty3.invoicePhoto = UIImage(named: "Launchscreen")?.pngData()
        warranty3.productPhoto = UIImage(named: "Launchscreen")?.pngData()
        
        loadedWarranties = [warranty1, warranty2, warranty3]
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
//        storageService = StorageService()
    }
    
    override func tearDown() {
        super.tearDown()
        storageService = nil
        loadedWarranties = []
    }
    
    func testWarrantyLoading() {
        var loadedWarranties: [Warranty] = []
        
        storageService.save()
        
        do {
            loadedWarranties = try storageService.loadWarranties()
        } catch {
            XCTFail("error loading \(error.localizedDescription)")
        }
        XCTAssertFalse(loadedWarranties.isEmpty)
    }

}
