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
}
