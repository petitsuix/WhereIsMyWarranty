//
//  NewWarrantyViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 15/12/2021.
//

import Foundation

class NewWarrantyViewModel: NSObject {
    
    // MARK: - Properties
    
    weak var newWarrantyProductInfoViewDelegate: NewWarrantyProductInfoViewController?
    weak var newWarrantyPhotoViewDelegate: NewWarrantyPhotoViewController?
    let coordinator: WarrantiesCoordinator
    let storageService: StorageService
    
    var name: String? {
        didSet {
            guard oldValue != name else { return }
            newWarrantyProductInfoViewDelegate?.canGoToNextStep(canSave: canSaveWarranty)
            print(oldValue)
            print(name)
        }
    }
    
    var startDate: Date?
    var endDate: Date?
    var isLifetimeWarranty: Bool?
    var productPhoto: Data?
    var invoicePhoto: Data?
    
    var canSaveWarranty: Bool {
        return name?.isEmpty == false
    }
    
    // MARK: - Methods
    
    init(coordinator: WarrantiesCoordinator, storageService: StorageService) {
        self.coordinator = coordinator
        self.storageService = storageService
    }
    
    func notifyWarrantiesListUpdated() {
        let notificationName = NSNotification.Name(rawValue: "warranties list updated")
        let notification = Notification(name: notificationName)
        NotificationCenter.default.post(notification)
    }
    
    func warrantySaved() {
        coordinator.warrantySaved()// ne pas passer entre controleurs
    }
    
    func goToAddProductPhotoScreen() {
        coordinator.showNewWarrantyProductPhotoScreen()
    }
    
    func goToAddInvoicePhotoScreen() {
        coordinator.showNewWarrantyInvoicePhotoScreen()
    }
    
    // FIXME: pour que ce soit clean, peut être rajouter un loading icon sur le button
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
}
