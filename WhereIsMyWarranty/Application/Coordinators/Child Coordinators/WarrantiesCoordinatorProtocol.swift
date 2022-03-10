//
//  WarrantiesCoordinatorProtocol.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 09/02/2022.
//

import Foundation

protocol WarrantiesCoordinatorProtocol: Coordinator {
    func showHomeWarrantiesListScreen()
    func showNewWarrantyProductInfoScreen()
    func showNewWarrantyProductPhotoScreen()
    func showNewWarrantyInvoicePhotoScreen()
    func showNewWarrantyExtraInfoScreen()
    func warrantySaved()
    func showWarrantyDetailsScreen(warranty: Warranty)
    func showEditWarrantyProductInfoScreen(warranty: Warranty)
    func showEditWarrantyProductPhotoScreen()
    func showEditWarrantyInvoicePhotoScreen()
    func editedWarrantySaved()
    func showFullScreenInvoicePhoto(invoicePhoto: Data)
}
