//
//  ExtraInfoCell.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 04/03/2022.
//

import UIKit

final class TextFieldTableViewCell: UITableViewCell { // Exprime l'intention comme quoi c'est une classe finale qu'on a théoriquement pas besoin de modifier
    
    var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var returnKeyType: UIReturnKeyType = .default {
        didSet {
            textField.returnKeyType = returnKeyType
        }
    }
    
    static let identifier = Strings.extraInfoCellIdentifier
    
    private let textField = UITextField()
    
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

extension TextFieldTableViewCell {
    func setup() {
        textField.autocapitalizationType = .words
        textField.clearButtonMode = .whileEditing
        textField.enablesReturnKeyAutomatically = true
        textField.textColor = .label
        // textField.font = UIFont.systemFont(ofSize: <#T##CGFloat#>)
       // textField.keyboardType = .namePhonePad A exposer car c'est pas très générique
       // textField.textContentType = .emailAddress
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
       // textField.isEnabled
        textField.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = MWColor.white
        contentView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
}
