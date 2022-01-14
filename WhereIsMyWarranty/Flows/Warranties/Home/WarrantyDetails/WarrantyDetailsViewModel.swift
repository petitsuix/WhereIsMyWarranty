//
//  WarrantyDetailsViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 22/12/2021.
//

import Foundation

class WarrantyDetailsViewModel {
    
    weak var viewDelegate: WarrantyDetailsViewController?
    private let coordinator: WarrantiesCoordinator
    private let storageService: StorageService
    
    init(coordinator: WarrantiesCoordinator, storageService: StorageService, warranty: Warranty) {
        self.coordinator = coordinator
        self.storageService = storageService
        self.warranty = warranty
    }
    
    var warranty: Warranty
    
    func deleteWarranty() {
        do {
           try storageService.deleteWarranty(warranty)
        }
        catch {
            print(error)
        }
    }
    
    func editWarranty() {
        coordinator.showEditWarrantyProductInfoScreen(warranty: warranty)
    }
    
//    var warranty: Warranty? {
//        didSet {
//            
//        }
//    }
}
