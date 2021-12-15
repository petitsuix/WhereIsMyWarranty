//
//  WarrantiesViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 10/12/2021.
//

import UIKit

class WarrantiesViewModel: NSObject {
    weak var viewDelegate: WarrantiesViewController?

    //private let webservice: Websercice ...
    private let coordinator: WarrantiesCoordinator
    init(coordinator: WarrantiesCoordinator) {
        self.coordinator = coordinator
    }
    
    var warranties: [String] = [] {
        didSet {
            viewDelegate?.refreshWith(warranties: warranties)
        }
    }
    
    var categories: [String] = [] {
        didSet {
            viewDelegate?.refreshWith(categories: categories)
        }
    }
    
    func showNewWarrantyScreen() {
        coordinator.showAddNewWarrantyScreen()
    }
    
    func fetchWarranties() {
        // appel reseau
        // response
        // warratnesiappelreseau = warranties
        warranties = ["war1", "war2","war3"]
    }
    
    func fetchCategories() {
        categories = ["Electroménager", "Pro", "Informatique"]
    }
}
