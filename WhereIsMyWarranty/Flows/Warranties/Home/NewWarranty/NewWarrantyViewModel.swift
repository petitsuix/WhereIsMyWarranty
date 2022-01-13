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
        coordinator.showNextStepNewWarrantyScreen()
    }
    
    // FIXME: pour que ce soit clean, peut être rajouter un loading icon sur le button
    func saveWarranty() {
        print("je suis dans saveWarranty")
        let newWarranty = Warranty(context: storageService.viewContext)
        newWarranty.name = viewDelegate?.nameField.text
        newWarranty.warrantyStart = viewDelegate?.datePicker.date
        newWarranty.warrantyEnd = viewDelegate?.newDate
        let imageAsData = stepTwoViewDelegate?.imageView.image?.pngData()
        newWarranty.invoicePhoto = imageAsData
        storageService.save()
        warrantySaved()
    }
}
