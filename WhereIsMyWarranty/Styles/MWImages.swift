//
//  MWImages.swift
//  Où est ma garantie ?
//
//  Created by Richardier on 03/12/2021.
//

import UIKit

enum MWImages {
    static let arrow = #imageLiteral(resourceName: "fancy-arrow")
    static let doggos = [UIImage(named: "labrador"), UIImage(named: "king charles"), UIImage(named: "golden retriever"), UIImage(named: "Pug")]
    
    static let addCategoryButtonImage = UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 38, weight: .light, scale: .small))
    static let newWarrantyButtonImage = UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .light, scale: .small))
    static let selectAnImageButton = UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .small))
    
    static let warrantiesTabImage = UIImage(systemName: "newspaper")
    static let warrantiesTabImageSelected = UIImage(systemName: "newspaper.fill")
    
    static let settingsTabImage = UIImage(systemName: "gearshape")
    static let settingsTabImageSelected = UIImage(systemName: "gearshape.fill")
    static let chevron = UIImage(systemName: "chevron.right")
}
