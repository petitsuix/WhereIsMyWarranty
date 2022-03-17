//
//  EditWarrantyViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 14/01/2022.
//

import Foundation

class EditWarrantyViewModel {
    
    // MARK: - Internal properties
    
    weak var productInfoViewDelegate: EditWarrantyProductInfoViewController?
    weak var photoViewDelegate: EditWarrantyPhotoViewController?
    weak var extraInfoViewDelegate: ExtraInfoViewController?
    
    var warranty: Warranty
    
    var name: String? {
        didSet {
            productInfoViewDelegate?.canGoToNextStep(canSave: canSaveWarranty)
        }
    }
    var startDate: Date?
    var isLifetimeWarranty: Bool?
    var endDate: Date?
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
    
    private var canSaveWarranty: Bool {
            return name?.isEmpty == false
    }
    
    // MARK: - Private properties
    
    private let coordinator: WarrantiesCoordinatorProtocol
    private let storageService: StorageServiceProtocol
    
    // MARK: - Methods
    
    init(coordinator: WarrantiesCoordinatorProtocol, storageService: StorageServiceProtocol, warranty: Warranty) {
        self.coordinator = coordinator
        self.storageService = storageService
        self.warranty = warranty
    }
    
    func notifyWarrantyUpdated() {
        let notificationName = NSNotification.Name(rawValue: Strings.warrantyUpdatedNotif)
        let notification = Notification(name: notificationName)
        NotificationCenter.default.post(notification)
    }

    func goToEditProductPhotoScreen() {
        coordinator.showEditWarrantyProductPhotoScreen()
    }
    
    func goToEditInvoicePhotoScreen() {
        coordinator.showEditWarrantyInvoicePhotoScreen()
    }
    
    func goToEditExtraInfoScreen() {
        coordinator.showEditWarrantyExtraInfoScreen()
    }
    
    func saveEditedWarranty() {
        warranty.name = name
        warranty.warrantyStart = startDate
        warranty.lifetimeWarranty = isLifetimeWarranty ?? false
        warranty.warrantyEnd = endDate
        warranty.productPhoto = productPhoto
        warranty.invoicePhoto = invoicePhoto
        warranty.price = price ?? 0
        warranty.model = model
        warranty.serialNumber = serialNumber
        warranty.sellersName = sellersName
        warranty.sellersLocation = sellersLocation
        warranty.sellersContact = sellersContact
        warranty.sellersWebsite = sellersWebsite
        warranty.notes = notes
        storageService.save()
        warrantySaved()
    }
    
    func calculateNumberOfYears() -> Double {
        let calendar = Calendar.current
        guard let warrantyStart = warranty.warrantyStart, let warrantyEnd = warranty.warrantyEnd else { return 0.0 }
        let components = calendar.dateComponents([.year, .month, .day], from: warrantyStart.startOfDay, to: warrantyEnd)
        return Double(components.year ?? 0)
    }
    
    func calculateNumberOfMonths() -> Double {
        let calendar = Calendar.current
        guard let warrantyStart = warranty.warrantyStart, let warrantyEnd = warranty.warrantyEnd else { return 0.0 }
        let components = calendar.dateComponents([.year, .month, .day], from: warrantyStart.startOfDay, to: warrantyEnd)
        return Double(components.month ?? 0)
    }
    
    func calculateNumberOfWeeks() -> Double {
        let calendar = Calendar.current
        guard let warrantyStart = warranty.warrantyStart, let warrantyEnd = warranty.warrantyEnd else { return 0.0 }
        let components = calendar.dateComponents([.year, .month, .day], from: warrantyStart.startOfDay, to: warrantyEnd)
        return Double(components.day ?? 0) / 7
    }
    
    // MARK: - Private methods
    
    func warrantySaved() {
        coordinator.editedWarrantySaved()
    }
}
