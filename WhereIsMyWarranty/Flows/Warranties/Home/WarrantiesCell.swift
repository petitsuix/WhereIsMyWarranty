//
//  WarrantiesCell.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 10/12/2021.
//

import UIKit

class WarrantiesCell: UICollectionViewCell {
    
    static let identifier = "WarrantiesCollectionViewCell"
    
    private var warrantyProductImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.borderColor = #colorLiteral(red: 0.9529626966, green: 0.7530050874, blue: 0.6343111992, alpha: 1)
        contentView.layer.borderWidth = 3
        roundingCellCorners(radius: 10)
        addShadow()
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureImageView() {
        let image = UIImage(named: "Launchscreen")
        warrantyProductImageView.image = image
        contentView.addSubview(warrantyProductImageView)
    }
    
}
