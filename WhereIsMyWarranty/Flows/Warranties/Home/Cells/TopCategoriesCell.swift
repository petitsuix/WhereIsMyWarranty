//
//  TopCategoriesCell.swift
//  Où est ma garantie ?
//
//  Created by Richardier on 30/11/2021.
//

import UIKit

class TopCategoriesCell: UICollectionViewCell {
    
    // MARK: - Internal properties
    
    static let identifier = Strings.categoryCellIdentifier
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var category: Category? {
        didSet {
            refreshCategoryData()
        }
    }
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Strings.initCoderNotImplemented)
    }
    
    func refreshCategoryData() {
        guard let name = category?.name else { return }
        titleLabel.text = "  \(name)  "
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}

// MARK: - View configuration

extension TopCategoriesCell {
    
    func setup() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = MWColor.bluegrey
        titleLabel.textAlignment = .natural
        let titleLabelHeightConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 30)
        titleLabelHeightConstraint.priority = .defaultHigh
        roundingCellCorners(radius: 14.8)
        contentView.backgroundColor = MWColor.white
        contentView.layer.borderColor = MWColor.bluegrey.cgColor
        contentView.layer.borderWidth = 1
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            titleLabelHeightConstraint
        ])
    }
    
}
