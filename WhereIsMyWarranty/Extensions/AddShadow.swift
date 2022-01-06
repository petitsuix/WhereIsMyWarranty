//
//  AddShadow.swift
//  LeBaluchon
//
//  Created by Richardier on 29/04/2021.
//

import UIKit

extension UICollectionViewCell {
    
    // ⬇︎ Adds a black shadow to any UIImageView content
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
}

extension UILabel {
    
    // ⬇︎ Adds a black shadow to any UIImageView content
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
}
