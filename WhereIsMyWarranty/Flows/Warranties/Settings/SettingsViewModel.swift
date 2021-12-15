//
//  SettingsViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 13/12/2021.
//

import Foundation

class SettingsViewModel: NSObject {
    weak var viewDelegate: SettingsViewController?

    //private let webservice: Websercice ...
    private let coordinator: AppCoordinator
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
}
