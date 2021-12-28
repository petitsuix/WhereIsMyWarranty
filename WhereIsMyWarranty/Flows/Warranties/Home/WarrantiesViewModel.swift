//
//  WarrantiesViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 10/12/2021.
//

import UIKit

class WarrantiesViewModel: NSObject {
    weak var viewDelegate: WarrantiesViewController?

    //private let webservice: Websercice ...
    private let coordinator: WarrantiesCoordinator
    private let storageService: StorageService
    init(coordinator: WarrantiesCoordinator, storageService: StorageService) {
        self.coordinator = coordinator
        self.storageService = storageService
    }
    
    var warranties: [Warranty] = [] {
        didSet {
            viewDelegate?.refreshWith(warranties: warranties)
        }
    }
    
    var categories: [Category] = [] {
        didSet {
            viewDelegate?.refreshWith()
        }
    }
    
    func showNewWarrantyScreen() {
        coordinator.showAddNewWarrantyScreen()
    }
    
    func showWarrantyDetailsScreen(warranty: Warranty) {
        coordinator.showWarrantyDetailsScreen(warranty: warranty)
    }
    
    @objc func showAddCategoryAlert() {
       
    }
    
//    func fetchWarrantiesFromDatabase() {
//        do {
//            warranties = try storageService.viewContext.fetch(Warranty.fetchRequest())
//        }
//        catch {
//            print(error)
//        }
//    }
    
    func fetchWarrantiesFromDatabase() {
        do {
            warranties = try storageService.loadWarranties()
        }
        catch {
            print(error)
        }
    }
    
    func saveCategory(categoryToSave: String) {
        let newCategory = Category(context: storageService.viewContext)
        newCategory.name = categoryToSave
        storageService.save()
    }
    
    func fetchCategoriesFromDatabase() {
        do {
            categories = try storageService.loadCategories()
        }
        catch {
            print(error)
        }
       // categories = ["Electroménager", "Pro", "Informatique"]
    }
}
