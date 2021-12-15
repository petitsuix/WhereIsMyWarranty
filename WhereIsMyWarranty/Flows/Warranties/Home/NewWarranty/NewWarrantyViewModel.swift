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
    
    var newWarrantyVC = NewWarrantyViewController()
    
    init(coordinator: WarrantiesCoordinator) {
        self.coordinator = coordinator
    }
    
    func goBack() {
        coordinator.goBack() // ne pas passer entre controleurs
    }
}
