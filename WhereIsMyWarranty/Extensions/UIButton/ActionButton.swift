//
//  ActionButton.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 04/03/2022.
//

import UIKit

class ActionButton: UIButton {
    
    func setup(title: String) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = MWColor.bluegreyElement
        roundingViewCorners(radius: 8)
        setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        isUserInteractionEnabled = true
    }
}
