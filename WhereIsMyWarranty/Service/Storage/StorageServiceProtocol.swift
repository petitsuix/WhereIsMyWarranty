//
//  StorageServiceProtocol.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 09/02/2022.
//

import CoreData

protocol StorageServiceProtocol {
    var viewContext: NSManagedObjectContext { get }
    func loadWarranties() throws -> [Warranty]
    func loadCategories() throws -> [Category]
    func save()
    func deleteWarranty(_ object: NSManagedObject) throws
}
