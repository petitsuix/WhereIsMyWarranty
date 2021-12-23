//
//  Storage Service.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 15/12/2021.
//

import CoreData

class StorageService {
    
    // MARK: - Properties
    
    var viewContext: NSManagedObjectContext
    
    // MARK: - Methods
    
    init(persistentContainer: NSPersistentContainer = AppDelegate.persistentContainer) {
        self.viewContext = persistentContainer.viewContext
    }
    
    func loadWarranties() {}
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            }
            catch { print(error) }
        }
    }
    
    func deleteWarranty(_ object: NSManagedObject) throws {
        viewContext.delete(object)
    }
}
