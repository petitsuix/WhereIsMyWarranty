//
//  File.swift
//  WhereIsMyWarrantyTests
//
//  Created by Richardier on 28/01/2022.
//

import Foundation
import UIKit
@testable import WhereIsMyWarranty


class WarrantiesCoordinatorMock: WarrantiesCoordinator {
    
    var coordinatorStartCalled = false
    
    override func start() {
        coordinatorStartCalled = true
    }
}
