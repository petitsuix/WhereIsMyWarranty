//
//  WarrantyDetailsExtraInfoCell.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 05/05/2022.
//

import UIKit

class WarrantyDetailsExtraInfoCell: UITableViewCell {
    
    // MARK: - Internal properties
    
    static let identifier = "WarrantyDetailsExtraInfoCell"
    
    // MARK: - Private properties
    
    var title = UILabel()
    var body = UITextView()
    private var parentStackView = UIStackView()
    
    // MARK: - Methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Strings.initCoderNotImplemented)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        body.text = nil
    }
}

extension WarrantyDetailsExtraInfoCell {
    func setup() {
        isUserInteractionEnabled = false
        title.font = UIFont.preferredFont(forTextStyle: .subheadline)
        body.backgroundColor = MWColor.extraInfoCellBackground
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .vertical
        parentStackView.addArrangedSubview(title)
        parentStackView.addArrangedSubview(body)
        backgroundColor = MWColor.extraInfoCellBackground
        self.isUserInteractionEnabled = false
        contentView.addSubview(parentStackView)
        
        NSLayoutConstraint.activate([
            parentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            parentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            parentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            parentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 4)
        ])
    }
}
