//
//  NewWarrantyViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 15/12/2021.
//

import Foundation

class NewWarrantyViewModel: NSObject {
    
    // MARK: - Properties
    
    weak var viewDelegate: NewWarrantyProductInfoViewController?
    weak var stepTwoViewDelegate: NewWarrantyPhotoViewController?
    let coordinator: WarrantiesCoordinator
    let storageService: StorageService
    
    var name: String? {
        didSet {
            guard oldValue != name else { return }
            viewDelegate?.canGoToNextStep(canSave: canSaveWarranty)
        }
    }
    
    var startDate: Date?
    var endDate: Date?
    var invoicePhoto: Data?
    var yearsStepperValue: Int?
    var monthsStepperValue: Int?
    var weeksStepperValue: Int?
    
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
    
    func nextStep() {
        coordinator.showNewWarrantyPhotoScreen()
    }
    
    // FIXME: pour que ce soit clean, peut être rajouter un loading icon sur le button
    func saveWarranty() {
        let warranty = Warranty(context: storageService.viewContext)
        warranty.name = name
        warranty.warrantyStart = startDate
        warranty.warrantyEnd = endDate
        warranty.invoicePhoto = invoicePhoto
        warranty.yearsStepperValue = Int16(yearsStepperValue ?? 0)
        warranty.monthsStepperValue = Int16(monthsStepperValue ?? 0)
        warranty.weeksStepperValue = Int16(weeksStepperValue ?? 0)
        storageService.save()
        warrantySaved()
    }
}
