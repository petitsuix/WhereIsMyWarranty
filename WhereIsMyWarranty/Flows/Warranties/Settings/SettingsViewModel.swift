//
//  SettingsViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 13/12/2021.
//

import Foundation

class SettingsViewModel: NSObject {
    
    // MARK: - Properties
    
    weak var settingsVCViewDelegate: SettingsViewController?
    weak var textVCViewDelegate: TextViewController?
    private let coordinator: SettingsCoordinator
    
    // MARK: - Methods
    
    init(coordinator: SettingsCoordinator) {
        self.coordinator = coordinator
    }
    
    func showPrivacyPolicyScreen() {
        coordinator.showPrivacyPolicyScreen()
    }
    
    func showTermsAndConditionsScreen() {
        coordinator.showTermsAndConditionsScreen()
    }
}
