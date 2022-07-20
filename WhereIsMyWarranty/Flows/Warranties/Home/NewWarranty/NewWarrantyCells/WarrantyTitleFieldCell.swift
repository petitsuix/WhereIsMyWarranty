//
//  WarrantyTitleCell.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 24/06/2022.
//

import UIKit

class WarrantyTitleFieldCell: UICollectionViewListCell {
    
    // MARK: - Internal properties
    
    static let identifier = "WarrantyTitleFieldCell"
    
    var warranty: Warranty? {
        didSet {
            refreshData()
        }
    }
    
    // MARK: - Private properties
    
    var nameField = UITextField()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Strings.initCoderNotImplemented)
    }
    
    // MARK: - Methods
    
    private func refreshData() {
        setupData()
    }
}

// MARK: - Configuration

extension WarrantyTitleFieldCell {
    func setupUI() {
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.autocorrectionType = .no
        nameField.placeholder = Strings.productNamePlaceHolder
        nameField.setBottomBorder()
        nameField.addDoneToolbar()
        nameField.becomeFirstResponder()
        
        addSubview(nameField)
        
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            nameField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            nameField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
    }
    
    func configure(with item: Configuration) {
        nameField.placeholder = item.placeholder
    }
    
    func setupData() {
       
    }
}

extension WarrantyTitleFieldCell {
    struct Configuration {
        let placeholder: String?

        init(placeholder: String?) {
            self.placeholder = placeholder
        }
    }
}
