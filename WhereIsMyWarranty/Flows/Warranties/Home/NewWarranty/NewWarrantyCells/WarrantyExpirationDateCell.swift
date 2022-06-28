//
//  WarrantyExpirationDateCell.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 24/06/2022.
//

import UIKit

class WarrantyExpirationDateCell: UICollectionViewListCell {
    
    // MARK: - Internal properties
    
    static let identifier = "WarrantyExpirationDateCell"
    
    var endDateLabel = UILabel()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Strings.initCoderNotImplemented)
    }
}

extension WarrantyExpirationDateCell {
    
    // MARK: - View configuration
    
    func setupUI() {
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel.textAlignment = .center
        endDateLabel.text = Strings.productCoveredUntil
        endDateLabel.numberOfLines = 2
        
        addSubview(endDateLabel)
        
        NSLayoutConstraint.activate([
            endDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            endDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            endDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            endDateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
        ])
    }
    
    func setupData() {
        
    }
}

