//
//  AddShadow.swift
//  LeBaluchon
//
//  Created by Richardier on 29/04/2021.
//

import UIKit

//extension UICollectionViewCell {
//    // ⬇︎ Adds a black shadow to any UICollectionViewCell content
//    func addShadow() {
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width: 0, height: 3)
//        self.layer.shadowRadius = 3
//        self.layer.shadowOpacity = 0.3
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath // Using Bezier path for performances reasons
//    }
//}

extension UIView {
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowColor = UIColor.black.cgColor
    }
}

//extension UILabel {
//    func addShadow() {
//        self.layer.masksToBounds = false
//        self.layer.shadowRadius = 3
//        self.layer.shadowOpacity = 0.3
//        self.layer.shadowOffset = CGSize(width: 0, height: 2)
//        self.layer.shadowColor = UIColor.black.cgColor
//    }
//}
