//
//  EditWarrantyViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 14/01/2022.
//

import Foundation
import UIKit

class EditWarrantyViewModel {
    
    // MARK: - Properties
    
    weak var productInfoViewDelegate: EditWarrantyProductInfoViewController?
    weak var invoicePhotoViewDelegate: EditWarrantyPhotoViewController?
    private let coordinator: WarrantiesCoordinator
    private let storageService: StorageService
    
    var warranty: Warranty
    
    private var hasNameChanged: Bool {
        name != warranty.name
    }
    var canSave: Bool {
        return hasNameChanged
    }
    
    var name: String? //{
//        didSet {
//            if oldValue != name {
//                
//            }
//        }
//    }
//    
    var canSaveWarranty: Bool {
        return name?.isEmpty == false /// if name?.isEmpty == false, then canSaveWarranty == true
    }
    
    var startDate: Date?
    var isLifetimeWarranty: Bool?
    var endDate: Date?
    var productPhoto: Data?
    var invoicePhoto: Data?
    var yearsStepperValue: Int?
    //{
        // date debut
        // date de fin
        // compute l'increment d'annee Double
    //}
    var monthsStepperValue: Int?
    var weeksStepperValue: Int?
    
    // MARK: - Methods
    
    init(coordinator: WarrantiesCoordinator, storageService: StorageService, warranty: Warranty) {
        self.coordinator = coordinator
        self.storageService = storageService
        self.warranty = warranty
        self.name = warranty.name
    }
    
    func notifyWarrantyUpdated() {
        let notificationName = NSNotification.Name(rawValue: "warranty updated")
        let notification = Notification(name: notificationName)
        NotificationCenter.default.post(notification)
    }

    func goToEditProductPhotoScreen() {
        coordinator.showEditWarrantyProductPhotoScreen()
    }
    
    func goToAddInvoicePhotoScreen() {
        coordinator.showEditWarrantyInvoicePhotoScreen()
    }
    
    func warrantySaved() {
        coordinator.editedWarrantySaved()// ne pas passer entre controleurs
    }
    
    func saveEditedWarranty() {
        if hasNameChanged {
            warranty.name = name
        }
        warranty.warrantyStart = startDate
        warranty.lifetimeWarranty = isLifetimeWarranty ?? false
        warranty.warrantyEnd = endDate
        warranty.productPhoto = productPhoto
        warranty.invoicePhoto = invoicePhoto
        storageService.save()
        warrantySaved()
    }
    
    func getYearsStepperValue() -> Double {
        let calendar = Calendar.current
        guard let warrantyStart = warranty.warrantyStart, let warrantyEnd = warranty.warrantyEnd else { return 0.0 }
        let components = calendar.dateComponents([.year, .month, .day], from: warrantyStart.startOfDay, to: warrantyEnd)
        return Double(components.year ?? 0)
    }
    
    func getMonthsStepperValue() -> Double {
        let calendar = Calendar.current
        guard let warrantyStart = warranty.warrantyStart, let warrantyEnd = warranty.warrantyEnd else { return 0.0 }
        let components = calendar.dateComponents([.year, .month, .day], from: warrantyStart.startOfDay, to: warrantyEnd)
        return Double(components.month ?? 0)
    }
    
    func getWeeksStepperValue() -> Double {
        let calendar = Calendar.current
        guard let warrantyStart = warranty.warrantyStart, let warrantyEnd = warranty.warrantyEnd else { return 0.0 }
        let components = calendar.dateComponents([.year, .month, .day], from: warrantyStart.startOfDay, to: warrantyEnd)
        return Double(components.day ?? 0) / 7
    }
}
