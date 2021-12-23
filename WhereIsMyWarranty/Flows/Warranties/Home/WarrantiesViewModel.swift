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
            viewDelegate?.refreshWith(categories: categories)
        }
    }
    
    func showNewWarrantyScreen() {
        coordinator.showAddNewWarrantyScreen()
    }
    
    func showWarrantyDetailsScreen(warranty: Warranty) {
        coordinator.showWarrantyDetailsScreen(warranty: warranty)
    }
    
    func fetchWarrantiesFromDatabase() {
        do {
            warranties = try storageService.viewContext.fetch(Warranty.fetchRequest())
        }
        catch {
            print(error)
        }
    }
    
    func fetchCategories() {
       // categories = ["Electroménager", "Pro", "Informatique"]
    }
}
