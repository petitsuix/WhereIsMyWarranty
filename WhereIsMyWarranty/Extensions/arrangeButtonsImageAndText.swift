//
//  arrangeButtonsImageAndText.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 03/01/2022.
//

import UIKit

extension UIButton {
    /// Fits the image and text content with a given spacing
    /// - Parameters:
    ///   - spacing: Spacing between the Image and the text
    ///   - contentXInset: The spacing between the view to the left image and the right text to the view
    func arrangeButtonsImageAndText(spacing: CGFloat, contentXInset: CGFloat = 0) {
        let imageTextSpacing = spacing / 2
        
        contentEdgeInsets = UIEdgeInsets(top: 0, left: (imageTextSpacing + contentXInset), bottom: 0, right: (imageTextSpacing + contentXInset))
        imageEdgeInsets = UIEdgeInsets(top: 1.5, left: -imageTextSpacing, bottom: 0, right: imageTextSpacing)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: imageTextSpacing, bottom: 0, right: -imageTextSpacing)
    }
    
    func arrangeButtonsImageAndText2(spacing: CGFloat, contentYInset: CGFloat = 0) {
        let imageTextSpacing = spacing / 2
        
        contentEdgeInsets = UIEdgeInsets(top: 0, left: (imageTextSpacing + 0), bottom: 0, right: (imageTextSpacing + 0))
        imageEdgeInsets = UIEdgeInsets(top: contentYInset, left: -imageTextSpacing, bottom: 0, right: imageTextSpacing)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: imageTextSpacing, bottom: 0, right: -imageTextSpacing)
    }
}
