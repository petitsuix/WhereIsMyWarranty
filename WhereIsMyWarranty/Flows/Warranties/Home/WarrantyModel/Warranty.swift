//
//  Warranty.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 15/12/2021.
//

import Foundation

struct Warranty {
    
    let name: String
    let warrantyStart: Date
    let warrantyEnd: Date?
    let lifetimeWarranty: Bool
    // FIXME: Photo c'est du String ?
    let invoicePhoto: Data?
    let price: Double?
    let paymentMethod: String?
    let model: String?
    let serialNumber: String?
    let currency: String?
    let productPhoto: Data?
    let sellersName: String?
    let sellersLocation: String?
    let sellersWebsite: String?
    let sellersContact: String?
    let category: String?
}

extension Warranty {
    init(from warrantyEntity: WarrantyEntity) {
        self.name = warrantyEntity.name ?? ""
        // FIXME: Comment correctement passer une valeur par défaut a date ?
        self.warrantyStart = warrantyEntity.warrantyStart ?? NSDate.distantPast
        self.warrantyEnd = warrantyEntity.warrantyEnd
        self.lifetimeWarranty = warrantyEntity.lifetimeWarranty
        self.invoicePhoto = warrantyEntity.invoicePhoto
        self.price = warrantyEntity.price
        self.paymentMethod = warrantyEntity.paymentMethod
        self.model = warrantyEntity.model
        self.serialNumber = warrantyEntity.serialNumber
        self.currency = warrantyEntity.currency
        self.productPhoto = warrantyEntity.productPhoto
        self.sellersName = warrantyEntity.sellersName
        self.sellersLocation = warrantyEntity.sellersLocation
        self.sellersWebsite = warrantyEntity.sellersWebsite
        self.sellersContact = warrantyEntity.sellersContact
        self.category = warrantyEntity.category
    }
}
