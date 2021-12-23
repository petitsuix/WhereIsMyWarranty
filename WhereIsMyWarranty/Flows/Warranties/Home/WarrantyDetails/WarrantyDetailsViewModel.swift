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
    var warranty: Warranty?
    
    init(coordinator: WarrantiesCoordinator/*, storageService: StorageService*/) {
        self.coordinator = coordinator
        
    }
}
