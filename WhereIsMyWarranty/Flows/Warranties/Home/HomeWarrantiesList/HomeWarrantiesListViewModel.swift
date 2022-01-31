//
//  WarrantiesViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 10/12/2021.
//

import UIKit

class HomeWarrantiesListViewModel {
    
    // MARK: - Properties
    
    weak var viewDelegate: HomeWarrantiesListViewController?
    
    
    var warranties: [Warranty] = [] {
        didSet {
            viewDelegate?.refreshWith(warranties: warranties)
        }
    }
    
    var categories: [Category] = [] {
        didSet {
            viewDelegate?.refresh()
        }
    }
    
    // MARK: - Private properties
    
    private let coordinator: WarrantiesCoordinatorProtocol
    private let storageService: StorageServiceProtocol
    
    // MARK: - objc methods

    // MARK: - Methods
    
    init(coordinator: WarrantiesCoordinatorProtocol, storageService: StorageServiceProtocol) {
        self.coordinator = coordinator
        self.storageService = storageService
    }
    
    func showNewWarrantyScreen() {
        coordinator.showNewWarrantyProductInfoScreen()
    }
    
    func showWarrantyDetailsScreen(warranty: Warranty) {
        coordinator.showWarrantyDetailsScreen(warranty: warranty)
    }
    
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
