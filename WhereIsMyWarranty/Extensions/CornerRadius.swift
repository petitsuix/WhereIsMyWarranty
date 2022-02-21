//
//  CornerRadius.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 03/12/2021.
//

import UIKit

// ⬇︎ Rounds the corresponding item's corners, based on a given radius
extension UICollectionViewCell {
    func roundingCellCorners(radius: Float) {
        self.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = CGFloat(radius)
    }
}

extension UIView {
    func roundingViewCorners(radius: Float) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = CGFloat(radius)
    }
}
