//
//  Storage Service.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 15/12/2021.
//

import CoreData

class StorageService: StorageServiceProtocol {
    
    // MARK: - Properties
    
    var viewContext: NSManagedObjectContext
    
    static private var persistentContainer: NSPersistentCloudKitContainer = {
        
        let container = NSPersistentCloudKitContainer(name: "WhereIsMyWarranty")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Methods
    
    init(persistentContainer: NSPersistentContainer = StorageService.persistentContainer) {
        self.viewContext = persistentContainer.viewContext
    }
    
    func loadWarranties() throws -> [Warranty] {
        var warranties = [Warranty]()
        do {
            warranties = try viewContext.fetch(Warranty.fetchRequest())
        } catch {
            throw error }
        return warranties
    }
    
    func loadCategories() throws -> [Category] {
        var categories = [Category]()
        do {
            categories = try viewContext.fetch(Category.fetchRequest())
        } catch {
            print(error) }
        return categories
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print(error) }
        }
    }
    
    func deleteWarranty(_ object: NSManagedObject) throws {
        do {
            viewContext.delete(object)
            try viewContext.save()
        } catch {
            throw error
        }
    }
    
    func deleteCategory(_ object: NSManagedObject) throws {
        do {
            viewContext.delete(object)
            try viewContext.save()
        } catch {
            throw error
        }
    }
}
