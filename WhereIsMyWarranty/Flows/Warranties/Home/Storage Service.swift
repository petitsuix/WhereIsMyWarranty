//
//  Storage Service.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 15/12/2021.
//

import CoreData

class StorageService {
    
    // MARK: - Properties
    
    static let shared = StorageService()
    private var viewContext: NSManagedObjectContext
    
    // MARK: - Methods
    
    init(persistentContainer: NSPersistentContainer = AppDelegate.persistentContainer) {
        self.viewContext = persistentContainer.viewContext
    }
    
    func loadWarranties() throws -> [Warranty] {
        let fetchRequest: NSFetchRequest<WarrantyEntity> = WarrantyEntity.fetchRequest() // Retrieves a group of managed objects held in the persistent store
        let warrantyEntities: [WarrantyEntity]
        
        do {
            warrantyEntities = try viewContext.fetch(fetchRequest)
        } catch { throw error }
        
        let warranties = warrantyEntities.map { (warrantyEntity) -> Warranty in
            return Warranty(from: warrantyEntity) // Model's init(from recipeEntity) allows to return a valid Recipe based on managed object's values
        }
        return warranties
    }
    
    func saveWarranty(_ warranty: Warranty) throws {
        let warrantyEntity = WarrantyEntity(context: viewContext)
        warrantyEntity.name = warranty.name
        warrantyEntity.warrantyStart = warranty.warrantyStart
        warrantyEntity.warrantyEnd = warranty.warrantyEnd
        warrantyEntity.lifetimeWarranty = warranty.lifetimeWarranty
        warrantyEntity.invoicePhoto = warranty.invoicePhoto
        warrantyEntity.price = warrantyEntity.price
        warrantyEntity.paymentMethod = warranty.paymentMethod
        warrantyEntity.model = warranty.model
        warrantyEntity.serialNumber = warranty.serialNumber
        warrantyEntity.currency = warranty.currency
        warrantyEntity.productPhoto = warranty.productPhoto
        warrantyEntity.sellersName = warranty.sellersName
        warrantyEntity.sellersLocation = warranty.sellersLocation
        warrantyEntity.sellersWebsite = warranty.sellersWebsite
        warrantyEntity.sellersContact = warranty.sellersContact
        warrantyEntity.category = warranty.category
        if viewContext.hasChanges {
            do { try viewContext.save() }
            catch { throw error }
        }
    }
    
    func deleteRecipe(_ warranty: Warranty) throws {
        let fetchRequest: NSFetchRequest<WarrantyEntity> = WarrantyEntity.fetchRequest() // Instantiating NSFetchRequest to retrieve a group of managed objects held in the persistent store
        let predicate = NSPredicate(format: "name == %@", warranty.name) // Condition used to constrain the search
        fetchRequest.predicate = predicate
        let warrantyEntities: [WarrantyEntity]
        do {
            warrantyEntities = try viewContext.fetch(fetchRequest)
            warrantyEntities.forEach { (warrantyEntity) in
                viewContext.delete(warrantyEntity)
            }
            try viewContext.save() // Save when a recipe is deleted
        } catch { throw error }
    }
}
