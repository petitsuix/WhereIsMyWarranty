//
//  NewWarrantyViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 15/12/2021.
//

import Foundation

class NewWarrantyViewModel: NSObject {
    
    // MARK: - Properties
    
    weak var viewDelegate: NewWarrantyViewController?
    weak var stepTwoViewDelegate: NewWarrantyStepTwoViewController?
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
    
    func backToHome() {
        coordinator.backToHome()// ne pas passer entre controleurs
    }
    
    func nextStep() {
        coordinator.showNextStepNewWarrantyScreen()
    }
    
    // FIXME: pour que ce soit clean, peut être rajouter un loading icon sur le button
    func saveWarranty() {
        print("je suis dans saveWarranty")
        let newWarranty = Warranty(context: storageService.viewContext)
        newWarranty.name = viewDelegate?.nameField.text
        newWarranty.warrantyStart = viewDelegate?.startDate.date
       // newWarranty.invoicePhoto = stepTwoViewDelegate?.imageView
        storageService.save()
        backToHome()
    }
    
}
