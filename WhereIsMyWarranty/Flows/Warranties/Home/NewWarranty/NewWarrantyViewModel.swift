//
//  NewWarrantyViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 15/12/2021.
//

import Foundation

class NewWarrantyViewModel: NSObject {
    
    weak var viewDelegate: NewWarrantyViewController?
    private let coordinator: WarrantiesCoordinator
    private let storageService: StorageService
    
    var name: String? {
        didSet {
            guard oldValue != name else { return }
            viewDelegate?.canGoToNextStep(canSave: canSaveWarranty)
        }
    }
    
    var canSaveWarranty: Bool {
        return name?.isEmpty == false
    }
    
    init(coordinator: WarrantiesCoordinator, storageService: StorageService) {
        self.coordinator = coordinator
        self.storageService = storageService
    }
    
    func backToHome() {
        coordinator.backToHome() // ne pas passer entre controleurs
    }
    
    func nextStep() {
        coordinator.showNextStepNewWarrantyScreen()
    }
    
    func saveWarranty() {
        print("je suis dans saveWarranty")
        let newWarranty = Warranty(context: storageService.viewContext)
        newWarranty.name = viewDelegate?.nameField.text
        newWarranty.warrantyStart = viewDelegate?.startDate.date
        storageService.save()
        backToHome()
    }
}
