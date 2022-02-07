//
//  WarrantyDetailsViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 22/12/2021.
//

import Foundation

class WarrantyDetailsViewModel {
    
    // MARK: - Internal properties
    
    weak var viewDelegate: WarrantyDetailsViewController?
    
    var warranty: Warranty
    
    // MARK: - Private properties
    
    private let coordinator: WarrantiesCoordinatorProtocol
    private let storageService: StorageServiceProtocol
    
    // MARK: - Methods
    
    init(coordinator: WarrantiesCoordinatorProtocol, storageService: StorageServiceProtocol, warranty: Warranty) {
        self.coordinator = coordinator
        self.storageService = storageService
        self.warranty = warranty
    }
    
    func showFullScreenInvoicePhoto() {
        if let invoicePhoto = warranty.invoicePhoto {
        coordinator.showFullScreenInvoicePhoto(invoicePhoto: invoicePhoto)
        }
    }
    
    func deleteWarranty() {
        do {
            try storageService.deleteWarranty(warranty)
        } catch {
            print(error) }
    }
    
    func editWarranty() {
        coordinator.showEditWarrantyProductInfoScreen(warranty: warranty)
    }
}
