//
//  EditWarrantyViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 14/01/2022.
//

import Foundation
import UserNotifications

class EditWarrantyViewModel {
    
    // MARK: - Internal properties
    
    var warranty: Warranty
    var notificationService = NotificationService()
    
    weak var productInfoViewDelegate: EditWarrantyProductInfoViewController?
    weak var photoViewDelegate: EditWarrantyPhotoViewController?
    weak var extraInfoViewDelegate: ExtraInfoViewController?
    
    var name: String? {
        didSet {
            productInfoViewDelegate?.canGoToNextStep(canSave: canSaveWarranty)
        }
    }
    var startDate: Date?
    var endDate: Date?
    var isLifetimeWarranty: Bool?
    var areNotificationsEnabled: Bool = false
    var productPhoto: Data?
    var invoicePhoto: Data?
    var price: Double? {
        didSet {
            warranty.price = price ?? 0
        }
    }
    var model: String? {
        didSet {
            warranty.model = model
        }
    }
    var serialNumber: String? {
        didSet {
            warranty.serialNumber = serialNumber
        }
    }
    var sellersName: String? {
        didSet {
            warranty.sellersName = sellersName
        }
    }
    var sellersLocation: String? {
        didSet {
            warranty.sellersLocation = sellersLocation
        }
    }
    var sellersContact: String? {
        didSet {
            warranty.sellersContact = sellersContact
        }
    }
    var sellersWebsite: String? {
        didSet {
            warranty.sellersWebsite = sellersWebsite
        }
    }
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
        warranty.notes = notes
        storageService.save()
        if areNotificationsEnabled == true, let name = name, let endDate = endDate {
            let id = warranty.objectID.uriRepresentation().absoluteString
            notificationService.cancelnotif(for: id)
            notificationService.generateNotificationFor(name, endDate.addingTimeInterval(-30*86400), id: id)
        }
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
