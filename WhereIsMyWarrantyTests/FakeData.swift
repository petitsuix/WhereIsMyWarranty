//
//  fakeData.swift
//  WhereIsMyWarrantyTests
//
//  Created by Richardier on 26/01/2022.
//

 import CoreData
 import Foundation
@testable import WhereIsMyWarranty
 import UIKit

final class FakeData {
    
    static var warranty1: Warranty = Warranty() {
        didSet {
            warranty1.name = "warranty test"
        }
    }
    static var warranty2 = Warranty()
    
    static var category = Category()
    static var category2 = Category()
    
//    static var warranty1: Warranty {
//        let warranty = Warranty()
//        warranty.name = "Warranty 1"
//        warranty.warrantyStart = Date()
//        warranty.warrantyEnd = Date()
//        warranty.productPhoto = UIImage(named: "Launchscreen")?.pngData()
//        warranty.invoicePhoto = UIImage(named: "Launchscreen")?.pngData()
//        warranty.lifetimeWarranty = false
//        return warranty
//    }
//
//    static var warranty2: Warranty {
//        let warranty = Warranty()
//        warranty.name = "Warranty 2"
//        warranty.warrantyStart = Date()
//        warranty.warrantyEnd = Date()
//        warranty.productPhoto = UIImage(named: "Launchscreen")?.pngData()
//        warranty.invoicePhoto = UIImage(named: "Launchscreen")?.pngData()
//        warranty.lifetimeWarranty = true
//        return warranty
//    }
    
//    static var warranty3: Warranty {
//        let warranty = Warranty()
//        warranty.name = "Warranty 3"
//        warranty.warrantyStart = Date()
//        warranty.warrantyEnd = Date()
//        warranty.productPhoto = UIImage(named: "Launchscreen")?.pngData()
//        warranty.invoicePhoto = UIImage(named: "Launchscreen")?.pngData()
//        warranty.lifetimeWarranty = true
//        return warranty
//    }
}