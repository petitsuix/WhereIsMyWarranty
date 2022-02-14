//
//  AddShadow.swift
//  LeBaluchon
//
//  Created by Richardier on 29/04/2021.
//

import UIKit

extension UIView {
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowColor = UIColor.black.cgColor
    }
}
