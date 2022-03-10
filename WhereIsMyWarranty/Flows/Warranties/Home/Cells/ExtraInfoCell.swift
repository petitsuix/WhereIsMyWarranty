//
//  ExtraInfoCell.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 04/03/2022.
//

import UIKit

class ExtraInfoCell: UITableViewCell {
    
    static let identifier = Strings.extraInfoCellIdentifier
    
    var textField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Strings.initCoderNotImplemented)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textField.text = nil
    }
}

extension ExtraInfoCell {
    func setup() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Prix"
        contentView.backgroundColor = MWColor.white
        contentView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            //textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
