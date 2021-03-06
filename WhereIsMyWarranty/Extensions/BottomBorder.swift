//
//  BottomBorder.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 13/06/2022.
//

import UIKit

extension UIView {
  func setBottomBorder() {
    self.backgroundColor = MWColor.background
    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    self.layer.shadowOpacity = 1.0
    self.layer.shadowRadius = 0.0
  }
}
