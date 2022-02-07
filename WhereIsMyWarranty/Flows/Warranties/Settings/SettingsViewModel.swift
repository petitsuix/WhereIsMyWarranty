//
//  SettingsViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 13/12/2021.
//

import Foundation

class SettingsViewModel: NSObject {
    
    // MARK: - Properties
    
    weak var viewDelegate: SettingsViewController?
    private let coordinator: AppCoordinator
    
    // MARK: - Methods
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
}
