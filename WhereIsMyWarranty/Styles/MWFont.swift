//
//  NWFont.swift
//  Où est ma garantie ?
//
//  Created by Richardier on 03/12/2021.
//

import UIKit

enum MWFont {
    static let caption1 = UIFont.preferredFont(forTextStyle: .caption1)
    static let title3 = UIFont.preferredFont(forTextStyle: .title3)
    static let body = UIFont.preferredFont(forTextStyle: .body)
    static let navBar = UIFont.systemFont(ofSize: 19, weight: .semibold)
    static let cellWarrantyName = UIFont.boldSystemFont(ofSize: 20)
    static let warrantyDetailsProductName = UIFont.boldSystemFont(ofSize: 22)
    static let warrantyStatusLabel = UIFont.systemFont(ofSize: 15, weight: .semibold)
    static let invoicePhotoTitle = UIFont.boldSystemFont(ofSize: 18)
    static let editWarrantyButton = UIFont.systemFont(ofSize: 15, weight: .medium)
    static let deleteWarrantyButton = UIFont.systemFont(ofSize: 15, weight: .medium)
    
    // New & EditWarranty screens
    static let nameTitle = UIFont.boldSystemFont(ofSize: 29)
    static let productInfoSubtitles = UIFont.boldSystemFont(ofSize: 16)
    static let addAPhotoTitle = UIFont.boldSystemFont(ofSize: 26)
    
    // Settings screen
    static let aboutLabel = UIFont.systemFont(ofSize: 18, weight: .regular)
    static let versionLabel = UIFont.systemFont(ofSize: 16, weight: .regular)
}
