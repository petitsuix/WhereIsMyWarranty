//
//  WarrantyDetailsViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 22/12/2021.
//

import Foundation

class WarrantyDetailsViewModel {
    
    //MARK: - Properties
    
    weak var viewDelegate: WarrantyDetailsViewController?
    
    var warranty: Warranty
    
    //MARK: - Private properties
    
    private let coordinator: WarrantiesCoordinatorProtocol
    private let storageService: StorageServiceProtocol
    
    //MARK: - Methods
    
    init(coordinator: WarrantiesCoordinator, storageService: StorageService, warranty: Warranty) {
        self.coordinator = coordinator
        self.storageService = storageService
        self.warranty = warranty
    }
    
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
}
