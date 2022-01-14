//
//  EditWarrantyViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 14/01/2022.
//

import Foundation

class EditWarrantyViewModel {
    
    // MARK: - Properties
    
    weak var productInfoViewDelegate: EditWarrantyProductInfoViewController?
    weak var invoicePhotoViewDelegate: EditWarrantyPhotoViewController?
    private let coordinator: WarrantiesCoordinator
    private let storageService: StorageService
    
    var warranty: Warranty
    
    var name: String? {
        didSet {
            guard oldValue != name else { return }
            productInfoViewDelegate?.canGoToNextStep(canSave: canSaveWarranty)
        }
    }
    
    var startDate: Date?
    var endDate: Date?
    var invoicePhoto: Data?
    
    var canSaveWarranty: Bool {
        return name?.isEmpty == false
    }
    
    // MARK: - Methods
    
    init(coordinator: WarrantiesCoordinator, storageService: StorageService, warranty: Warranty) {
        self.coordinator = coordinator
        self.storageService = storageService
        self.warranty = warranty
    }
    
    func showEditWarrantyProductInfoScreen(warranty: Warranty) {
        coordinator.showEditWarrantyProductInfoScreen(warranty: warranty)
    }

    func nextStep() {
        coordinator.showEditWarrantyPhotoScreen()
    }
    
//    var warranty: Warranty? {
//        didSet {
//
//        }
//    }
}
