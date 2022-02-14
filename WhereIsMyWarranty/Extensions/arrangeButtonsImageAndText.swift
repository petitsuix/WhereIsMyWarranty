//
//  arrangeButtonsImageAndText.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 03/01/2022.
//

import UIKit

extension UIButton {

    func arrangeButtonsImageAndTextY(spacing: CGFloat, contentYInset: CGFloat = 0) {
        let imageTextSpacing = spacing / 2
        
        contentEdgeInsets = UIEdgeInsets(top: 0, left: (imageTextSpacing + 0), bottom: 0, right: (imageTextSpacing + 0))
        imageEdgeInsets = UIEdgeInsets(top: contentYInset, left: -imageTextSpacing, bottom: 0, right: imageTextSpacing)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: imageTextSpacing, bottom: 0, right: -imageTextSpacing)
    }
}
