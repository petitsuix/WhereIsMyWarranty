//
//  TopCategoriesCell.swift
//  Où est ma garantie ?
//
//  Created by Richardier on 30/11/2021.
//

import UIKit

class TopCategoriesCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "CustomCollectionViewCell"
    
    // FIXME: 
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "éléctroniques"
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
        contentView.backgroundColor = .white
        contentView.layer.borderColor = MWColor.bluegrey.cgColor
        contentView.layer.borderWidth = 1
        titleLabel.textColor = MWColor.bluegrey
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        roundingCellCorners(radius: 15)
        contentView.addSubview(titleLabel)
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshCategoryData() {
        titleLabel.text = category?.name
    }
    
    func configureCell() {
        
    }
    /* func refreshData() {
     title.text = category?.name
     } */
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
}
