//
//  SettingsCoordinatorProtocol.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 29/04/2022.
//

import Foundation

protocol SettingsCoordinatorProtocol: Coordinator {
    func showSettingsScreen()
    func showPrivacyPolicyScreen()
    func showTermsAndConditionsScreen()
}
