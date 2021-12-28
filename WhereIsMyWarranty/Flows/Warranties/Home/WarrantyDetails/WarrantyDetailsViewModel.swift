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
    
    init(coordinator: WarrantiesCoordinator, storageService: StorageService) {
        self.coordinator = coordinator
        self.storageService = storageService
    }
    
    var warranty: Warranty? {
        didSet {
            
        }
    }
}
