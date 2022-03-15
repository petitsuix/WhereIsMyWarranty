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
    weak var newWarrantyExtraInfoViewDelegate: ExtraInfoViewController?
    
    var name: String? {
        didSet {
            newWarrantyProductInfoViewDelegate?.canGoToNextStep(canSave: canSaveWarranty)
        }
    }
    var startDate: Date?
    var endDate: Date?
    var isLifetimeWarranty: Bool?
    var productPhoto: Data?
    var invoicePhoto: Data?
    var price: Double?
    var model: String?
    var serialNumber: String?
    var sellersName: String?
    var sellersLocation: String?
    var sellersContact: String?
    var sellersWebsite: String?
    var notes: String?
    
    var canSaveWarranty: Bool {
            return name?.isEmpty == false
        }
    
    // MARK: - Private properties
    
    private let coordinator: WarrantiesCoordinatorProtocol
    private let storageService: StorageServiceProtocol
    
    // MARK: - Internal methods
    
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
    
    func goToExtraInfoScreen() {
        coordinator.showNewWarrantyExtraInfoScreen()
    }
    
    func saveWarranty() {
        let newWarranty = Warranty(context: storageService.viewContext)
        newWarranty.name = name
        newWarranty.warrantyStart = startDate
        newWarranty.warrantyEnd = endDate
        newWarranty.lifetimeWarranty = isLifetimeWarranty ?? false
        newWarranty.invoicePhoto = invoicePhoto
        newWarranty.productPhoto = productPhoto
        newWarranty.price = price ?? 0
        newWarranty.model = model
        newWarranty.serialNumber = serialNumber
        newWarranty.sellersName = sellersName
        newWarranty.sellersLocation = sellersLocation
        newWarranty.sellersContact = sellersContact
        newWarranty.sellersWebsite = sellersWebsite
        newWarranty.notes = notes
        storageService.save()
        warrantySaved()
    }
    
    // MARK: - Private methods
    
    func warrantySaved() {
        coordinator.warrantySaved()
    }
}
