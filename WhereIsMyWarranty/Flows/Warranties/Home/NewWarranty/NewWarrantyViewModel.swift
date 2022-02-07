//
//  NewWarrantyViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 15/12/2021.
//

import Foundation

class NewWarrantyViewModel: NSObject {
    
    // MARK: - Internal properties
    
    weak var newWarrantyProductInfoViewDelegate: NewWarrantyProductInfoViewController?
    weak var newWarrantyPhotoViewDelegate: NewWarrantyPhotoViewController?
    
    var name: String?
    var startDate: Date?
    var endDate: Date?
    var isLifetimeWarranty: Bool?
    var productPhoto: Data?
    var invoicePhoto: Data?
    
    // MARK: - Private properties
    
    private let coordinator: WarrantiesCoordinatorProtocol
    private let storageService: StorageServiceProtocol
    
    // MARK: - Methods
    
    init(coordinator: WarrantiesCoordinatorProtocol, storageService: StorageServiceProtocol) {
        self.coordinator = coordinator
        self.storageService = storageService
    }
    
    func notifyWarrantiesListUpdated() {
        let notificationName = NSNotification.Name(rawValue: "warranties list updated")
        let notification = Notification(name: notificationName)
        NotificationCenter.default.post(notification)
    }
    
    func goToAddProductPhotoScreen() {
        coordinator.showNewWarrantyProductPhotoScreen()
    }
    
    func goToAddInvoicePhotoScreen() {
        coordinator.showNewWarrantyInvoicePhotoScreen()
    }
    
    func saveWarranty() {
        let newWarranty = Warranty(context: storageService.viewContext)
        newWarranty.name = name
        newWarranty.warrantyStart = startDate
        newWarranty.warrantyEnd = endDate
        newWarranty.lifetimeWarranty = isLifetimeWarranty ?? false
        newWarranty.invoicePhoto = invoicePhoto
        newWarranty.productPhoto = productPhoto
        storageService.save()
        warrantySaved()
    }
    
    // MARK: Private methods
    
    private func warrantySaved() {
        coordinator.warrantySaved()// ne pas passer entre controleurs
    }
}
